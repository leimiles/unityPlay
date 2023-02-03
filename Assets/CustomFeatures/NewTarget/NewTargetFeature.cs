using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class NewTargetFeature : ScriptableRendererFeature {
    class NewTargetPass0 : ScriptableRenderPass {
        RTHandle m_Handle;
        RTHandle m_DestinationColor;
        RTHandle m_DeininationDepth;

        Mesh mesh;
        Material material;
        public NewTargetPass0(Mesh mesh, Material material) {
            m_Handle = RTHandles.Alloc("MyNewPassHandle", name: "MyNewPassHandle");
            this.mesh = mesh;
            this.material = material;

        }
        public void Setup(RTHandle destinationColor, RTHandle destinationDepth) {
            m_DestinationColor = destinationColor;
            m_DeininationDepth = destinationDepth;
        }
        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData) {
            var descriptor = renderingData.cameraData.cameraTargetDescriptor;
            descriptor.depthBufferBits = 0;
            RenderingUtils.ReAllocateIfNeeded(ref m_Handle, descriptor, FilterMode.Point, TextureWrapMode.Clamp);
        }
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
            if (mesh is null || material is null) {
                Debug.Log("can't find mesh or material, quit rendering");
                return;
            }
            CommandBuffer cmd = CommandBufferPool.Get("New Pass Test");

            RTHandle tempColorHandle = renderingData.cameraData.renderer.cameraColorTargetHandle;

            Blitter.BlitCameraTexture(cmd, tempColorHandle, m_Handle);

            if (mesh is null) Debug.Log("dodod");
            if (material is null) Debug.Log("momomo");
            cmd.DrawMesh(mesh, Matrix4x4.identity, material, 0, 0);
            Blitter.BlitCameraTexture(cmd, m_Handle, tempColorHandle);

            context.ExecuteCommandBuffer(cmd);
            cmd.Clear();
            CommandBufferPool.Release(cmd);
        }
        public override void OnCameraCleanup(CommandBuffer cmd) {
            m_DestinationColor = null;
            m_DeininationDepth = null;
        }
        void Dispose() {
            m_Handle?.Release();
        }


    }

    NewTargetPass0 pass0;

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {

        if (renderingData.cameraData.cameraType == CameraType.Game || renderingData.cameraData.cameraType == CameraType.SceneView) {
            renderer.EnqueuePass(pass0);
        }
    }

    public override void SetupRenderPasses(ScriptableRenderer renderer, in RenderingData renderingData) {
        pass0.renderPassEvent = RenderPassEvent.AfterRenderingOpaques;
        pass0.Setup(renderer.cameraColorTargetHandle, renderer.cameraDepthTargetHandle);
    }

    [SerializeField]
    Mesh mesh;
    [SerializeField]
    Material material;

    public override void Create() {
        pass0 = new NewTargetPass0(mesh, material);
    }

}
