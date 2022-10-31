using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

class MIDPass : ScriptableRenderPass {
    private MaterialPropertyBlock materialPropertyBlock;
    private Material material;
    public Renderer[] renderers;
    public ParticleSystem[] particleSystems;
    public MIDFeature.MIDMode mIDMode;
    private Material errorMaterial;
    public MIDPass(Material material) {
        this.material = material;
        materialPropertyBlock = new MaterialPropertyBlock();
        mIDMode = MIDFeature.MIDMode.Off;
        errorMaterial = CoreUtils.CreateEngineMaterial(Shader.Find("Hidden/InternalErrorShader"));
        errorMaterial.name = "error material";
    }
    //public MIDFeature.MIDMode mIDMode;
    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
        CommandBuffer commandBuffer = CommandBufferPool.Get(name: "MID Pass");
        if (renderers != null && renderers.Length > 0) {
            switch (mIDMode) {
                case MIDFeature.MIDMode.ByMaterial:
                    DrawRenderersByMaterial(ref commandBuffer);
                    break;
                case MIDFeature.MIDMode.ByShader:
                    DrawRenderersByShader(ref commandBuffer);
                    break;
                case MIDFeature.MIDMode.ByShaderAndKeywords:
                    DrawRenderersByShaderAndKeywords(ref commandBuffer);
                    break;
            }
        }
        context.ExecuteCommandBuffer(commandBuffer);
        CommandBufferPool.Release(commandBuffer);
    }

    void DrawRenderersByMaterial(ref CommandBuffer commandBuffer) {
        foreach (Renderer renderer in renderers) {
            if (renderer == null) {
                return;
            }
            if (renderer.sharedMaterials.Length > 1) {
                for (int i = 0; i < renderer.sharedMaterials.Length; i++) {
                    renderer.GetPropertyBlock(materialPropertyBlock);
                    materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(renderer.sharedMaterials[i] == null ? errorMaterial : renderer.sharedMaterials[i], renderer.gameObject));
                    renderer.SetPropertyBlock(materialPropertyBlock);
                    commandBuffer.DrawRenderer(renderer, material, i);
                }
            } else {
                renderer.GetPropertyBlock(materialPropertyBlock);
                materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(renderer.sharedMaterial == null ? errorMaterial : renderer.sharedMaterial, renderer.gameObject));
                renderer.SetPropertyBlock(materialPropertyBlock);
                commandBuffer.DrawRenderer(renderer, material);
            }
        }
    }

    void DrawRenderersByShader(ref CommandBuffer commandBuffer) {
        foreach (Renderer renderer in renderers) {
            if (renderer == null) {
                return;
            }
            if (renderer.sharedMaterials.Length > 1) {
                for (int i = 0; i < renderer.sharedMaterials.Length; i++) {
                    renderer.GetPropertyBlock(materialPropertyBlock);
                    materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(renderer.sharedMaterials[i] == null ? errorMaterial.shader : renderer.sharedMaterials[i].shader, renderer.gameObject));
                    renderer.SetPropertyBlock(materialPropertyBlock);
                    commandBuffer.DrawRenderer(renderer, material, i);
                }
            } else {
                renderer.GetPropertyBlock(materialPropertyBlock);
                materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(renderer.sharedMaterial == null ? errorMaterial.shader : renderer.sharedMaterial.shader, renderer.gameObject));
                renderer.SetPropertyBlock(materialPropertyBlock);
                commandBuffer.DrawRenderer(renderer, material);
            }
        }
    }

    void DrawRenderersByShaderAndKeywords(ref CommandBuffer commandBuffer) {
        foreach (Renderer renderer in renderers) {
            if (renderer == null) {
                return;
            }
            if (renderer.sharedMaterials.Length > 1) {
                for (int i = 0; i < renderer.sharedMaterials.Length; i++) {
                    renderer.GetPropertyBlock(materialPropertyBlock);
                    string fullVariantName = MIDManager.GetFullVariantName(renderer.sharedMaterials[i] == null ? errorMaterial : renderer.sharedMaterials[i]);
                    materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(fullVariantName, renderer.gameObject));
                    renderer.SetPropertyBlock(materialPropertyBlock);
                    commandBuffer.DrawRenderer(renderer, material, i);
                }
            } else {
                renderer.GetPropertyBlock(materialPropertyBlock);
                string fullVariantName = MIDManager.GetFullVariantName(renderer.sharedMaterial == null ? errorMaterial : renderer.sharedMaterial);
                materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(fullVariantName, renderer.gameObject));
                renderer.SetPropertyBlock(materialPropertyBlock);
                commandBuffer.DrawRenderer(renderer, material);
            }
        }
    }

}
