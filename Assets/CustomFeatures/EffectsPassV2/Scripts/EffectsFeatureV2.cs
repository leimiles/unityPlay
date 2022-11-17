using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class EffectsFeatureV2 : ScriptableRendererFeature {
    EffectsPassV2 effectsPassV2;
    public Material effect_Material;
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
        if (effect_Material != null && EffectsManager.state) {
            effectsPassV2.SetMateial(effect_Material);
            renderer.EnqueuePass(effectsPassV2);
        }
    }

    public override void Create() {
        effectsPassV2 = new EffectsPassV2();
        effectsPassV2.renderPassEvent = RenderPassEvent.AfterRenderingTransparents;
        EffectsManager.Init();
    }
}
