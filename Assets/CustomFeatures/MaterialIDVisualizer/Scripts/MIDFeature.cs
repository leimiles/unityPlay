using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class MIDFeature : ScriptableRendererFeature {
    public enum MIDMode {
        Off,
        ByMaterial,     // renderer shows up with id color via different materials
        ByShader,        // renderer shows up with id color via different shaders
        ByShaderAndKeywords // renderer shows up with id color via different shaders and different shader keywords
    }
    public MIDMode midMode = MIDMode.Off;
    private RenderPassEvent renderPassEvent = RenderPassEvent.AfterRendering;
    //public bool excludeSkybox = true;
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
            if (midMode != MIDMode.Off) {
                if (mIDPass.renderers == null) {
                    mIDPass.renderers = GameObject.FindObjectsOfType<Renderer>();
                }
                renderer.EnqueuePass(mIDPass);
            } else {
                if (mIDPass.renderers != null) {
                    mIDPass.renderers = null;
                }
            }
            mIDPass.mIDMode = midMode;
        }
    }
}
