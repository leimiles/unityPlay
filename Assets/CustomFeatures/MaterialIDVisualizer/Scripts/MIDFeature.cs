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
                switch (mIDMode) {
                    case MIDMode.Off:
                        MIDManager.Clear();
                        break;
                    case MIDMode.ByMaterial:
                        DrawRenderersByMaterial(ref commandBuffer);
                        break;
                    case MIDMode.ByShader:
                        DrawRenderersByShader(ref commandBuffer);
                        break;
                    case MIDMode.ByShaderAndKeywords:
                        DrawRenderersByShaderAndKeywords(ref commandBuffer);
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
        void DrawRenderersByShaderAndKeywords(ref CommandBuffer commandBuffer) {
            foreach (MeshRenderer meshRenderer in meshRenderers) {
                if (meshRenderer.sharedMaterials.Length > 1) {
                    Debug.Log("multi materials");
                    continue;
                }
                meshRenderer.GetPropertyBlock(materialPropertyBlock);
                Color shaderColor = MIDManager.GetColor(meshRenderer.sharedMaterial.shader);
                MIDManager.KeywordsSet keywordsSet = new MIDManager.KeywordsSet(meshRenderer.sharedMaterial);
                materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(shaderColor, keywordsSet.FullVariantName));
                meshRenderer.SetPropertyBlock(materialPropertyBlock);
                commandBuffer.DrawRenderer(meshRenderer, material);
            }
        }
    }

    class MIDManager {
        public class KeywordsSet {
            string shaderName;
            string fullVariantsName;
            List<GlobalKeyword> globalKeywords;
            List<LocalKeyword> localKeywords;
            public KeywordsSet(Material material) {
                this.shaderName = material.shader.name;
                this.localKeywords = new List<LocalKeyword>(material.enabledKeywords);
                this.localKeywords.Sort((n1, n2) => n1.name.CompareTo(n2.name));
                this.globalKeywords = new List<GlobalKeyword>(Shader.enabledGlobalKeywords);
                this.globalKeywords.Sort((n1, n2) => n1.name.CompareTo(n2.name));
                SetFullName();
            }

            void SetFullName() {
                fullVariantsName = this.shaderName + "|";
                foreach (GlobalKeyword globalKeyword in this.globalKeywords) {
                    fullVariantsName += globalKeyword.name;
                    fullVariantsName += "|";
                }
                foreach (LocalKeyword localKeyword in this.localKeywords) {
                    fullVariantsName += localKeyword.name;
                    fullVariantsName += "|";
                }
            }
            public string FullVariantName {
                get {
                    return fullVariantsName;
                }
            }
        }

        public static Dictionary<Material, Color> materialsSet;
        public static Dictionary<Shader, Color> shadersSet;
        public static Dictionary<string, Color> variantsSet;
        public static List<KeywordsSet> keywordsSets;

        public static Color GetColor(Material material) {
            RegisterMaterial(material);
            return materialsSet[material];
        }
        public static Color GetColor(Shader shader) {
            RegisterShader(shader);
            return shadersSet[shader];
        }

        public static Color GetColor(Color shaderColor, string shaderVariants) {
            RigisterShaderVariant(shaderVariants);
            return shaderColor * variantsSet[shaderVariants];
        }

        static void RigisterShaderVariant(string shaderVariants) {
            if (variantsSet == null) {
                variantsSet = new Dictionary<string, Color>();
            }
            if (!variantsSet.ContainsKey(shaderVariants)) {
                Color newColor = new Color(Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f);
                variantsSet.Add(shaderVariants, newColor);
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
        }
        static void RegisterShader(Shader shader) {
            if (shadersSet == null) {
                shadersSet = new Dictionary<Shader, Color>();
            }
            if (!shadersSet.ContainsKey(shader)) {
                Color newColor = new Color(Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f);
                shadersSet.Add(shader, newColor);
            }
        }
        public static void Clear() {
            if (materialsSet != null) {
                materialsSet.Clear();
            }
            if (shadersSet != null) {
                shadersSet.Clear();
            }
            if (keywordsSets != null) {
                keywordsSets.Clear();
            }
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
    public int VariantsCount {
        get {
            if (MIDManager.variantsSet == null) {
                return 0;
            } else {
                return MIDManager.variantsSet.Count;
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
