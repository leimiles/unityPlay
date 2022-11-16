using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class EffectsTrigger : MonoBehaviour {
    Renderer[] renderers;

    [SerializeField]
    [Range(0.0f, 1.0f)]
    public float _AttackedColorIntensity;
    void Start() {
        renderers = gameObject.GetComponentsInChildren<Renderer>();
    }
    void OnEnable() {
        if (EffectsManager.state) {
            EffectsManager.AddTrigger(this);
            //Debug.Log(EffectsManager.Count());
        }
    }
    void OnDisable() {
        if (EffectsManager.state && EffectsManager.Exists(this)) {
            EffectsManager.RemoveTrigger(this);
            //Debug.Log(EffectsManager.Count());
        }
    }
    public Renderer[] GetRenderers() {
        return renderers;
    }
}


