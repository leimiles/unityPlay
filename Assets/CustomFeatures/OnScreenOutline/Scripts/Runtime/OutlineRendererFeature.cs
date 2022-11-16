using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class OutlineRendererFeature : ScriptableRendererFeature {
    [SerializeField]
    public OutlineSettingObject featureSettings;
    private OutlineRendererPass outlineRendererPass;

    private bool IsShaderReady() {
        bool status = false;
        if (featureSettings.OutlineShader != null) {
            status = true;
        }
        return status;
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
        if (IsShaderReady()) {
            outlineRendererPass.Setup(renderer);
            renderer.EnqueuePass(outlineRendererPass);
        } else {
            Debug.Log("Shader is not ready for renderer feature.");
        }
    }



    public override void Create() {
        if (featureSettings == null) {
            return;
        } else {
            outlineRendererPass = new OutlineRendererPass(this, featureSettings.renderPassEvent);
        }
    }
}

