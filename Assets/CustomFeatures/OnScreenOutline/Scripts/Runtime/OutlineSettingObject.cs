using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[CreateAssetMenu(fileName = "Outline Setting", menuName = "SoFunny/Outline/Outline Settings")]
public class OutlineSettingObject : ScriptableObject {
    public Shader OutlineShader;
    public RenderPassEvent renderPassEvent = RenderPassEvent.AfterRenderingSkybox;
    public LayerMask layerMask;
    //public static string[] _layerMaskNames = { "Default", "Outline_Always", "Outline_Occlude", "Outline_OccludeInvert" };
    public Color OutlineColor = Color.red;
    [Range(1, 32)]
    public int OutlineWidth = 2;
    public OutlineEffect outlineEffect = OutlineEffect.Solid;

    [HideInInspector]
    public static int MaxSamples = 32;

    public readonly RenderTargetIdentifier maskTexture = new RenderTargetIdentifier("_MaskTex");
    public readonly RenderTargetIdentifier tempTexture = new RenderTargetIdentifier("_TempTex");
    private Material outlineMaterial = null;

    public Material OutlineMaterial {
        get {
            if (outlineMaterial == null) {
                outlineMaterial = new Material(OutlineShader) {
                    name = "OutlineMat",
                    hideFlags = HideFlags.HideAndDontSave
                };
            }
            return outlineMaterial;
        }
    }


    private MaterialPropertyBlock propertyBlock;
    public MaterialPropertyBlock GetPropertyBlock() {
        if (propertyBlock is null) {
            propertyBlock = new MaterialPropertyBlock();
        }
        propertyBlock.SetFloat(Shader.PropertyToID("_Width"), OutlineWidth);
        propertyBlock.SetColor(Shader.PropertyToID("_Color"), OutlineColor);
        propertyBlock.SetFloat(Shader.PropertyToID("_Intensity"), 100);
        return propertyBlock;
    }
}

public enum OutlineEffect {
    Solid,
    SolidAA,
    Blur
}
