using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class OutlineRendererPass : ScriptableRenderPass {

    private readonly OutlineRendererFeature outlineRendererFeature;
    private readonly List<ShaderTagId> shaderTagIds = new List<ShaderTagId>();
    private ScriptableRenderer scriptableRenderer;

    public OutlineRendererPass(OutlineRendererFeature outlineRendererFeature, RenderPassEvent renderPassEvent) {
        this.outlineRendererFeature = outlineRendererFeature;

        //shaderTagIds.Add(new ShaderTagId("OutlineOccluder"));
        shaderTagIds.Add(new ShaderTagId("Outline"));

        this.renderPassEvent = renderPassEvent;
        this.profilingSampler = new ProfilingSampler("Outline Pass Screen");
    }

    public void Setup(ScriptableRenderer renderer) {
        this.scriptableRenderer = renderer;
    }

    public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
        var camData = renderingData.cameraData;
        if (this.outlineRendererFeature.featureSettings.layerMask != 0) {
            var cmd = CommandBufferPool.Get("Outline Pass Screen");
            var filteringSettings = new FilteringSettings(RenderQueueRange.all, this.outlineRendererFeature.featureSettings.layerMask);
            var drawingSettings = CreateDrawingSettings(shaderTagIds, ref renderingData, camData.defaultOpaqueSortFlags);
            var renderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);
            using (new ProfilingScope(cmd, this.profilingSampler)) {
                using (var outlineRenderer = new OutlineRenderer(cmd, this.outlineRendererFeature.featureSettings, this.scriptableRenderer.cameraColorTargetHandle, this.scriptableRenderer.cameraDepthTargetHandle, camData.cameraTargetDescriptor)) {
                    // set render target to mask texture and clear
                    outlineRenderer.ClearAndSetTarget();
                    context.ExecuteCommandBuffer(cmd);
                    context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings, ref renderStateBlock);
                    cmd.Clear();
                    outlineRenderer.RenderOutline();
                }
            }
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }

}


public class OutlineRenderer : System.IDisposable {
    private readonly CommandBuffer cmd;
    private readonly TextureDimension dimentionRT;
    private readonly RenderTargetIdentifier renderTarget;
    private readonly RenderTargetIdentifier depthTarget;
    private OutlineSettingObject outlineSetting;

    public void RenderOutline() {
        var material = outlineSetting.OutlineMaterial;
        var propertyBlock = outlineSetting.GetPropertyBlock();

        cmd.SetGlobalFloatArray(Shader.PropertyToID("_GaussSamplesTest"), GetGaussSamples(outlineSetting.OutlineWidth));
        cmd.SetRenderTarget(outlineSetting.tempTexture, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
        BlitMask(outlineSetting.maskTexture, 0, material, propertyBlock);
        cmd.SetRenderTarget(renderTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);

        if (outlineSetting.outlineEffect == OutlineEffect.SolidAA) {
            material.EnableKeyword("_OUTLINE_AA");
            material.DisableKeyword("_OUTLINE_BLUR");
        } else if (outlineSetting.outlineEffect == OutlineEffect.Blur) {
            material.EnableKeyword("_OUTLINE_BLUR");
            material.DisableKeyword("_OUTLINE_AA");

        } else if (outlineSetting.outlineEffect == OutlineEffect.Solid) {
            material.DisableKeyword("_OUTLINE_BLUR");
            material.DisableKeyword("_OUTLINE_AA");
        }

        BlitOutline(outlineSetting.tempTexture, 1, material, propertyBlock);

    }
    private void BlitMask(RenderTargetIdentifier source, int shaderPass, Material material, MaterialPropertyBlock propertyBlock) {
        cmd.SetGlobalTexture(Shader.PropertyToID("_MainTex"), source);
        if (SystemInfo.graphicsShaderLevel >= 35 && SystemInfo.supportsInstancing) {
            cmd.DrawProcedural(Matrix4x4.identity, material, shaderPass, MeshTopology.Triangles, 3, 1, propertyBlock);
        } else {
            Debug.Log("something wrong here...");
        }
    }

    private void BlitOutline(RenderTargetIdentifier source, int shaderPass, Material material, MaterialPropertyBlock propertyBlock) {
        cmd.SetGlobalTexture(Shader.PropertyToID("_MainTex"), source);
        if (SystemInfo.graphicsShaderLevel >= 35 && SystemInfo.supportsInstancing) {
            cmd.DrawProcedural(Matrix4x4.identity, material, shaderPass, MeshTopology.Triangles, 3, 1, propertyBlock);
        } else {
            Debug.Log("something wrong here...");
        }
    }

    public OutlineRenderer(CommandBuffer cmd, OutlineSettingObject outlineSetting, RenderTargetIdentifier dstRT, RenderTargetIdentifier dstDepth, RenderTextureDescriptor descriptorRT) {
        if (cmd is null) {
            throw new System.ArgumentNullException(nameof(cmd));
        }
        if (descriptorRT.width <= 0) {
            descriptorRT.width = -1;
        }
        if (descriptorRT.height <= 0) {
            descriptorRT.height = -1;
        }

        if (descriptorRT.dimension == TextureDimension.None || descriptorRT.dimension == TextureDimension.Unknown) {
            descriptorRT.dimension = TextureDimension.Tex2D;
        }
        descriptorRT.shadowSamplingMode = ShadowSamplingMode.None;
        descriptorRT.depthBufferBits = 0;
        descriptorRT.colorFormat = RenderTextureFormat.R8;
        descriptorRT.msaaSamples = 1;

        cmd.GetTemporaryRT(Shader.PropertyToID("_MaskTex"), descriptorRT, FilterMode.Bilinear);
        cmd.GetTemporaryRT(Shader.PropertyToID("_TempTex"), descriptorRT, FilterMode.Bilinear);


        this.dimentionRT = descriptorRT.dimension;
        this.renderTarget = dstRT;
        this.depthTarget = dstDepth;
        this.cmd = cmd;
        this.outlineSetting = outlineSetting;
    }
    public void Dispose() {
        cmd.ReleaseTemporaryRT(Shader.PropertyToID("_TempTex"));
        cmd.ReleaseTemporaryRT(Shader.PropertyToID("_MaskTex"));
    }
    public void ClearAndSetTarget() {
        if (dimentionRT == TextureDimension.Tex2DArray) {
            cmd.SetRenderTarget(outlineSetting.maskTexture, 0, CubemapFace.Unknown, -1);
        } else {
            // cmd.SetRenderTarget(outlineSetting.maskTexture, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);      // this method can't use depth buffer
            // cmd.SetRenderTarget(outlineSetting.maskTexture, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, this.depthTarget, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
            cmd.SetRenderTarget(outlineSetting.maskTexture, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, this.depthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
        }

        cmd.ClearRenderTarget(false, true, Color.clear);
    }

    private float[][] _gaussSamples;
    public float[] GetGaussSamples(int width) {
        var index = Mathf.Clamp(width, 1, OutlineSettingObject.MaxSamples) - 1;

        if (_gaussSamples is null) {
            _gaussSamples = new float[OutlineSettingObject.MaxSamples][];
        }
        if (_gaussSamples[index] is null) {
            _gaussSamples[index] = GetGaussSamples(width, null);
        }
        //DebugArray(_gaussSamples[index]);
        return _gaussSamples[index];
    }
    private void DebugArray(float[] array) {
        string content = " | ";
        foreach (var t in array) {
            content += t.ToString();
            content += " | ";
        }
        UnityEngine.Debug.Log(content);
    }

    public static float[] GetGaussSamples(int width, float[] samples) {
        var stdDev = width * 0.5f;
        if (samples is null) {
            samples = new float[OutlineSettingObject.MaxSamples];
        }
        for (var i = 0; i < width; i++) {
            samples[i] = Gauss(i, stdDev);
        }
        return samples;
    }

    public static float Gauss(float x, float stdDev) {
        var stdDev2 = stdDev * stdDev * 2;
        var a = 1 / Mathf.Sqrt(Mathf.PI * stdDev2);
        var gauss = a * Mathf.Pow((float)System.Math.E, -x * x / stdDev2);
        return gauss;
    }
}


