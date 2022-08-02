using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class Splat_8_GUI : ShaderGUI {
    MaterialEditor materialEditor { get; set; }
    MaterialProperty layerCount { get; set; }
    MaterialProperty controlMap0 { get; set; }
    MaterialProperty controlMap1 { get; set; }

    GUIContent controlMap0_GUI = new GUIContent("Control Map0", "Splat Map0");
    GUIContent controlMap1_GUI = new GUIContent("Control Map1", "Splat Map1");

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties) {
        //base.OnGUI(materialEditor, properties);
        this.materialEditor = materialEditor;
        FindProperties(properties);
        DrawIntegerProperty(layerCount);
        DrawTexturePropertyWithoutScaleAndOffset(controlMap0, controlMap0_GUI);
        DrawTexturePropertyWithoutScaleAndOffset(controlMap1, controlMap1_GUI);
    }
    void FindProperties(MaterialProperty[] properties) {
        layerCount = FindProperty("_T2M_Layer_Count", properties, true);
        controlMap0 = FindProperty("_T2M_SplatMap_0", properties, true);
        controlMap1 = FindProperty("_T2M_SplatMap_1", properties, true);

    }
    void DrawIntegerProperty(MaterialProperty property) {
        if (property == null) {
            return;
        }
        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField("Layer Count: ");
        property.floatValue = EditorGUILayout.IntField((int)property.floatValue, GUILayout.Width(30.0f));
        property.floatValue = 8.0f;
        EditorGUILayout.EndHorizontal();
    }
    void DrawTexturePropertyWithoutScaleAndOffset(MaterialProperty property, GUIContent texture_GUI) {
        if (property == null) {
            return;
        }
        materialEditor.TexturePropertySingleLine(texture_GUI, property);
    }
    void DrawTexturePropertyWithScaleAndOffset(MaterialProperty property, GUIContent texture_GUI) {
        if (property == null) {
            return;
        }
    }
}
