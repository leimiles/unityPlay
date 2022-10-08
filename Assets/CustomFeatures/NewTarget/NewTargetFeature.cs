using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class NewTargetFeature : ScriptableRendererFeature {
    class NewTargetPass0 : ScriptableRenderPass {
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
            //Debug.Log("NewTargetPass0 executing...");
            CommandBuffer commandBuffer = CommandBufferPool.Get("Pass0_Pass");
            using (new ProfilingScope(commandBuffer, profilingSampler)) {
                commandBuffer.ClearRenderTarget(RTClearFlags.All, Color.black, 1.0f, 0xF0);
                context.ExecuteCommandBuffer(commandBuffer);
                commandBuffer.Clear();

            }
            context.ExecuteCommandBuffer(commandBuffer);
            CommandBufferPool.Release(commandBuffer);
        }
        public NewTargetPass0() {
            profilingSampler = new ProfilingSampler("Pass0_Sampler");
        }
    }
    class NewTargetPass1 : ScriptableRenderPass {
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
            Debug.Log("NewTargetPass1 executing...");
        }
    }
    [System.Serializable]
    public class NewTargetSettings {
        public RenderPassEvent renderPassEvent = RenderPassEvent.AfterRenderingTransparents;
    }

    NewTargetPass0 pass0;
    public NewTargetSettings settings;

    /*
    called per frame per camera
    */
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
        //Debug.Log("feature added");
        if (renderingData.cameraData.cameraType == CameraType.Game || renderingData.cameraData.cameraType == CameraType.SceneView) {
            renderer.EnqueuePass(pass0);
        }
    }
    /*
    called once when enbaled
    */
    public override void Create() {
        //Debug.Log("feature created");
        pass0 = new NewTargetPass0();
        pass0.renderPassEvent = settings.renderPassEvent;
    }

}
