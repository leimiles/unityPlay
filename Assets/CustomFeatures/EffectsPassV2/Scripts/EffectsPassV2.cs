using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class EffectsPassV2 : ScriptableRenderPass {
    Material material;
    MaterialPropertyBlock materialPropertyBlock;
    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
        Debug.Log("yoyo");
        //Debug.Log("wazzup");
        CommandBuffer cmd = CommandBufferPool.Get(name: "Effect Pass V2");
        //context.ExecuteCommandBuffer(cmd);
        DrawRenderersByEffectsManager(ref cmd);
        context.ExecuteCommandBuffer(cmd);
        CommandBufferPool.Release(cmd);
    }

    public EffectsPassV2() {
        materialPropertyBlock = new MaterialPropertyBlock();
    }

    public void SetMateial(Material material) {
        this.material = material;
    }

    void DrawRenderersByEffectsManager(ref CommandBuffer cmd) {
        Debug.Log(EffectsManager.Count());
        foreach (EffectsTrigger effectsTrigger in EffectsManager.EffectsTriggers) {
            foreach (Renderer renderer in effectsTrigger.GetRenderers()) {
                renderer.GetPropertyBlock(materialPropertyBlock);
                materialPropertyBlock.SetFloat(Shader.PropertyToID("_attackedColor_Intensity"), effectsTrigger.intensity);
                renderer.SetPropertyBlock(materialPropertyBlock);
                cmd.DrawRenderer(renderer, material, 0, 0);
            }
        }
    }
}