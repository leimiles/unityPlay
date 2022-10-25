using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class MIDFeature : ScriptableRendererFeature {
    class MIDPass : ScriptableRenderPass {
        Material material;
        public MeshRenderer[] meshRenderers;
        public MIDPass(Material material) {
            this.material = material;
        }

        public MIDMode mIDMode;
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
            CommandBuffer commandBuffer = CommandBufferPool.Get(name: "MID Pass");
            if (meshRenderers != null && meshRenderers.Length > 0) {
                /*
                foreach (MeshRenderer meshRenderer in meshRenderers) {
                    foreach (Material material in meshRenderer.sharedMaterials) {
                        if (material == null) {
                        } else {
                            commandBuffer.DrawRenderer(meshRenderer, material);
                        }
                    }
                }
                */
                switch (mIDMode) {
                    case MIDMode.Off:
                        break;
                    case MIDMode.ByMaterial:
                        MIDManager.Clear();
                        DrawRenderersByMaterial(ref commandBuffer);
                        break;
                    case MIDMode.ByShader:
                        MIDManager.Clear();
                        DrawRenderersByShader(ref commandBuffer);
                        break;
                    case MIDMode.ByShaderAndKeywords:
                        MIDManager.Clear();
                        break;
                }
            }
            context.ExecuteCommandBuffer(commandBuffer);
            CommandBufferPool.Release(commandBuffer);
        }

        void DrawRenderersByShader(ref CommandBuffer commandBuffer) {
            foreach (MeshRenderer meshRenderer in meshRenderers) {
                if (meshRenderer.sharedMaterials.Length > 1) {
                    Debug.Log("multi materials");
                    continue;
                }
                material.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(meshRenderer.sharedMaterial.shader));
                commandBuffer.DrawRenderer(meshRenderer, material);
            }
        }

        void DrawRenderersByMaterial(ref CommandBuffer commandBuffer) {
            foreach (MeshRenderer meshRenderer in meshRenderers) {
                if (meshRenderer.sharedMaterials.Length > 1) {
                    Debug.Log("multi materials");
                    continue;
                }
                material.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(meshRenderer.sharedMaterial));
                commandBuffer.DrawRenderer(meshRenderer, material);
            }

        }
    }

    class MIDManager {
        static HashSet<Material> materialsSet;
        public static Color GetColor(LocalKeyword[] localKeywords) {
            return Color.yellow;
        }
        public static Color GetColor(Material material) {
            RegisterMaterial(material);
            return Color.green;
        }
        public static Color GetColor(Shader shader) {
            return Color.blue;
        }
        public static void Clear() {
            if (materialsSet != null) {
                materialsSet.Clear();
            }

        }
        static void RegisterMaterial(Material material) {
            if (materialsSet == null) {
                materialsSet = new HashSet<Material>();
            }
            materialsSet.Add(material);
            //Debug.Log(materialsSet.Count);
        }

    }

    public enum MIDMode {
        Off,
        ByMaterial,     // renderer shows up with id color via different materials
        ByShader,        // renderer shows up with id color via different shaders
        ByShaderAndKeywords // renderer shows up with id color via different shaders and different shader keywords
    }
    public MIDMode midMode = MIDMode.Off;
    private RenderPassEvent renderPassEvent = RenderPassEvent.AfterRendering;
    public bool excludeSkybox = true;
    private Material material;
    private MIDPass mIDPass;
    public override void Create() {
        if (material == null) {
            material = CoreUtils.CreateEngineMaterial(Shader.Find("cf/utils/mid"));
        }
        mIDPass = new MIDPass(material);
        mIDPass.renderPassEvent = renderPassEvent;
    }
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
        if (renderingData.cameraData.cameraType == CameraType.SceneView) {
            mIDPass.mIDMode = midMode;
            MeshRenderer[] meshRenderers = GameObject.FindObjectsOfType<MeshRenderer>();
            mIDPass.meshRenderers = meshRenderers;
            renderer.EnqueuePass(mIDPass);
        }
    }
}
