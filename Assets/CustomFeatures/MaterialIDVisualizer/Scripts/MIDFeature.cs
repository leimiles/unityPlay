using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class MIDFeature : ScriptableRendererFeature {
    class MIDPass : ScriptableRenderPass {
        Material material;
        public MeshRenderer[] meshRenderers;
        MaterialPropertyBlock materialPropertyBlock;
        public MIDPass(Material material) {
            this.material = material;
            materialPropertyBlock = new MaterialPropertyBlock();
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
                        MIDManager.Clear();
                        break;
                    case MIDMode.ByMaterial:
                        //MIDManager.Clear();
                        DrawRenderersByMaterial(ref commandBuffer);
                        break;
                    case MIDMode.ByShader:
                        //MIDManager.Clear();
                        DrawRenderersByShader(ref commandBuffer);
                        break;
                    case MIDMode.ByShaderAndKeywords:
                        //MIDManager.Clear();
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
                meshRenderer.GetPropertyBlock(materialPropertyBlock);
                materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(meshRenderer.sharedMaterial.shader));
                //material.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(meshRenderer.sharedMaterial.shader));
                //commandBuffer.DrawRenderer(meshRenderer, material);
                meshRenderer.SetPropertyBlock(materialPropertyBlock);
                commandBuffer.DrawRenderer(meshRenderer, material);
            }
        }

        void DrawRenderersByMaterial(ref CommandBuffer commandBuffer) {
            foreach (MeshRenderer meshRenderer in meshRenderers) {
                if (meshRenderer.sharedMaterials.Length > 1) {
                    Debug.Log("multi materials");
                    continue;
                }
                meshRenderer.GetPropertyBlock(materialPropertyBlock);
                materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(meshRenderer.sharedMaterial));
                meshRenderer.SetPropertyBlock(materialPropertyBlock);
                commandBuffer.DrawRenderer(meshRenderer, material);
            }
        }
    }

    class MIDManager {
        //static HashSet<Material> materialsSet;
        public static Dictionary<Material, Color> materialsSet;
        public static Dictionary<Shader, Color> shadersSet;
        public static Color GetColor(LocalKeyword[] localKeywords) {
            return Color.yellow;
        }
        public static Color GetColor(Material material) {
            RegisterMaterial(material);
            return materialsSet[material];
        }
        public static Color GetColor(Shader shader) {
            RegisterShader(shader);
            return shadersSet[shader];
        }
        public static void Clear() {
            if (materialsSet != null) {
                materialsSet.Clear();
            }
            if (shadersSet != null) {
                shadersSet.Clear();
            }

        }
        static void RegisterMaterial(Material material) {
            if (materialsSet == null) {
                materialsSet = new Dictionary<Material, Color>();
            }
            if (!materialsSet.ContainsKey(material)) {
                Color newColor = new Color(Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f);
                materialsSet.Add(material, newColor);
            }
            //Debug.Log(materialsSet.Count);
        }
        static void RegisterShader(Shader shader) {
            if (shadersSet == null) {
                shadersSet = new Dictionary<Shader, Color>();
            }
            if (!shadersSet.ContainsKey(shader)) {
                Color newColor = new Color(Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f);
                shadersSet.Add(shader, newColor);
            }
            //Debug.Log(materialsSet.Count);
        }

    }

    public int MaterialsCount {
        get {
            if (MIDManager.materialsSet == null) {
                return 0;
            } else {
                return MIDManager.materialsSet.Count;
            }
        }
    }
    public int ShadersCount {
        get {
            if (MIDManager.shadersSet == null) {
                return 0;
            } else {
                return MIDManager.shadersSet.Count;
            }
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
            // todo opt
            MeshRenderer[] meshRenderers = GameObject.FindObjectsOfType<MeshRenderer>();
            mIDPass.meshRenderers = meshRenderers;
            renderer.EnqueuePass(mIDPass);
        }
    }
}
