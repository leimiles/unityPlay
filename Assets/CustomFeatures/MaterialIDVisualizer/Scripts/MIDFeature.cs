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
                    Debug.Log(meshRenderer.name + " has multi materials");
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
                    Debug.Log(meshRenderer.name + " has multi materials");
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
                    Debug.Log(meshRenderer.name + " has multi materials");
                    continue;
                }
                meshRenderer.GetPropertyBlock(materialPropertyBlock);
                Color shaderColor = MIDManager.GetColor(meshRenderer.sharedMaterial.shader);
                string fullVariantName = MIDManager.GetFullVariantName(meshRenderer.sharedMaterial);
                materialPropertyBlock.SetColor(Shader.PropertyToID("_Color"), MIDManager.GetColor(shaderColor, fullVariantName, meshRenderer.gameObject));
                meshRenderer.SetPropertyBlock(materialPropertyBlock);
                commandBuffer.DrawRenderer(meshRenderer, material);
            }


        }
    }

    public class MIDManager {
        public static Dictionary<Material, Color> materialsSet;
        public static Dictionary<Shader, Color> shadersSet;
        public static Dictionary<string, Color> variantsSet;
        public static Dictionary<string, List<GameObject>> variantsSetToObjects;
        public static Color GetColor(Material material) {
            RegisterMaterial(material);
            return materialsSet[material];
        }
        public static Color GetColor(Shader shader) {
            RegisterShader(shader);
            return shadersSet[shader];
        }

        public static Color GetColor(Color shaderColor, string shaderVariantsName, GameObject renderer = null) {
            RigisterShaderVariant(shaderVariantsName, renderer);
            return shaderColor * new Color(shaderColor.r, variantsSet[shaderVariantsName].g, shaderColor.b);
        }

        public static string GetFullVariantName(Material material) {
            string shaderName = material.shader.name;
            List<LocalKeyword> localKeywords = new List<LocalKeyword>(material.enabledKeywords);
            localKeywords.Sort((n1, n2) => n1.name.CompareTo(n2.name));
            List<GlobalKeyword> globalKeywords = new List<GlobalKeyword>(Shader.enabledGlobalKeywords);
            globalKeywords.Sort((n1, n2) => n1.name.CompareTo(n2.name));
            string fullVariantsName = shaderName + "| ";
            foreach (GlobalKeyword globalKeyword in globalKeywords) {
                fullVariantsName += globalKeyword.name;
                fullVariantsName += "| ";
            }
            foreach (LocalKeyword localKeyword in localKeywords) {
                fullVariantsName += localKeyword.name;
                fullVariantsName += "| ";
            }
            return fullVariantsName;
        }

        static void RigisterShaderVariant(string shaderVariants, GameObject renderer) {
            if (variantsSet == null) {
                variantsSet = new Dictionary<string, Color>();
                variantsSetToObjects = new Dictionary<string, List<GameObject>>();
            }
            if (!variantsSet.ContainsKey(shaderVariants)) {
                //Color newColor = new Color(Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f);
                Color newColor = new Color(Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f, Random.Range(0.0f, 1.0f) * 0.5f + 0.5f);
                variantsSet.Add(shaderVariants, newColor);
                variantsSetToObjects[shaderVariants] = new List<GameObject>();
                variantsSetToObjects[shaderVariants].Add(renderer);
            } else {
                variantsSetToObjects[shaderVariants].Add(renderer);
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
            if (variantsSet != null) {
                variantsSet.Clear();
                variantsSetToObjects.Clear();
            }
        }

        public static GameObject[] GetGameObjectsByVariantsSet(string variantsSetName) {
            if (variantsSetToObjects != null) {
                return variantsSetToObjects[variantsSetName].ToArray();
            } else {
                return null;
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
    //public bool excludeSkybox = true;
    public bool On_SkinnedMesh = false;
    public bool On_MultiSubMeshes = false;
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
