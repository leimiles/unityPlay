using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class EffectsManager {
    static List<EffectsTrigger> effectsTriggers;
    public static List<EffectsTrigger> EffectsTriggers {
        get {
            return effectsTriggers;
        }
    }
    public static bool state = false;

    public static void Init(ScriptableRendererFeature feature) {
        if (effectsTriggers == null) {
            effectsTriggers = new List<EffectsTrigger>();
        }
        state = true;
    }
    public static void AddTrigger(EffectsTrigger effectsTrigger) {
        effectsTriggers.Add(effectsTrigger);
    }

    public static void RemoveTrigger(EffectsTrigger effectsTrigger) {
        effectsTriggers.Remove(effectsTrigger);
    }

    public static int Count() {
        return effectsTriggers.Count;
    }

    public static bool Exists(EffectsTrigger effectsTrigger) {
        return effectsTriggers.Contains(effectsTrigger);
    }
}
