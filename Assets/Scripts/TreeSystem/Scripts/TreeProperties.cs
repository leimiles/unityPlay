using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[DisallowMultipleComponent]
public class TreeProperties : MonoBehaviour {
    [SerializeField]
    Color color1 = Color.white;
    [SerializeField]
    Color color2 = Color.black;

    private MeshRenderer _renderer;
    private MaterialPropertyBlock _materialPropertyBlock;

    int color1PropertyID;
    int color2PropertyID;

    void Start() {
        Init();
        SetProperties();
    }

#if UNITY_EDITOR
    void Update() {
        SetProperties();
    }
#endif

    void Init() {
        _renderer = GetComponent<MeshRenderer>();
        _materialPropertyBlock = new MaterialPropertyBlock();
        color1PropertyID = Shader.PropertyToID("_Color1");
        color2PropertyID = Shader.PropertyToID("_Color2");
    }

    void SetProperties() {
        if (_materialPropertyBlock == null) {
            _materialPropertyBlock = new MaterialPropertyBlock();
        } else {
            _renderer.GetPropertyBlock(_materialPropertyBlock);
            _materialPropertyBlock.SetColor(color1PropertyID, color1);
            _materialPropertyBlock.SetColor(color2PropertyID, color2);
            _renderer.SetPropertyBlock(_materialPropertyBlock);
        }
    }
}
