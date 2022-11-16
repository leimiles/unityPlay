using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class EffectsFeature : ScriptableRendererFeature {
    class EffectsPass : ScriptableRenderPass {
        Material sourceMaterial;
        public EffectsPass(Material material) {
            this.sourceMaterial = material;
        }
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
            if (renderingData.cameraData.cameraType == CameraType.Game || renderingData.cameraData.cameraType == CameraType.SceneView) {
                CommandBuffer commandBuffer = CommandBufferPool.Get(name: "Effects Pass");
                if (EffectsManager.Count() > 0) {
                    foreach (EffectsTrigger effectsTrigger in EffectsManager.EffectsTriggers) {
                        if (effectsTrigger.EffectsMaterial == null) {
                            effectsTrigger.EffectsMaterial = new Material(this.sourceMaterial);
                        }
                        effectsTrigger.EffectsMaterial.SetFloat(Shader.PropertyToID("_attackedColor_Intensity"), effectsTrigger.intensity);
                        commandBuffer.DrawRenderer(effectsTrigger.GetRenderers()[0], effectsTrigger.EffectsMaterial);
                    }
                }
                context.ExecuteCommandBuffer(commandBuffer);
                CommandBufferPool.Release(commandBuffer);
            }
        }
    }
    public RenderPassEvent renderPassEvent = RenderPassEvent.AfterRenderingTransparents;
    private EffectsPass _effectsPass;
    public Material material;
    public override void Create() {
        if (material != null) {
            _effectsPass = new EffectsPass(material);
            _effectsPass.renderPassEvent = renderPassEvent;
            EffectsManager.Init(this);
        }
    }
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
        if (material != null) {
            renderer.EnqueuePass(_effectsPass);
        }
    }

}
