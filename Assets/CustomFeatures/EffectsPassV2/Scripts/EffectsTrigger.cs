using UnityEngine;

[DisallowMultipleComponent]
public class EffectsTrigger : MonoBehaviour {
    Renderer[] renderers;

    [SerializeField]
    [Range(0.0f, 1.0f)]
    public float _AttackedColorIntensity = 0.0f;

    [SerializeField]
    [Range(0.0f, 1.0f)]
    public float _OccludeeColorIntensity = 0.5f;

    [SerializeField]
    [ColorUsageAttribute(true, true)]
    public Color _OccludeeColor = Color.red;

    [SerializeField]
    [Range(0.0f, 0.1f)]
    public float _OutlineWidth = 0.008f;

    [SerializeField]
    [ColorUsageAttribute(true, true)]
    public Color _OutlineColor = Color.red;
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

