using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.Rendering;

public class Splat_8_GUI : ShaderGUI {
    MaterialEditor materialEditor { get; set; }
    MaterialProperty[] properties { get; set; }
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties) {
        //base.OnGUI(materialEditor, properties);
        this.materialEditor = materialEditor;
        this.properties = properties;
        EditorGUILayout.LabelField("Splat 8 GUI", EditorStyles.boldLabel);
        DrawIntegerProperty("_T2M_Layer_Count");
        EditorGUILayout.Space();
        EditorGUILayout.LabelField("Splat maps", EditorStyles.boldLabel);

        EditorGUILayout.BeginHorizontal();
        for (int i = 0; i < 2; i++) {
            DrawTextureProperty("_T2M_SplatMap_" + i);
        }
        EditorGUILayout.EndHorizontal();

        EditorGUILayout.Space();

        EditorGUILayout.LabelField("Layers", EditorStyles.boldLabel);

        for (int i = 0; i < 8; i++) {
            EditorGUILayout.LabelField("Layer map " + i, EditorStyles.boldLabel);
            EditorGUILayout.BeginHorizontal();
            DrawTextureProperty("_T2M_Layer_" + i + "_NormalMap");
            DrawTexturePropertyWithColor("_T2M_Layer_" + i + "_Diffuse", "_T2M_Layer_" + i + "_ColorTint");
            EditorGUILayout.EndHorizontal();
            EditorGUILayout.LabelField("Metallic and Occlusion: ");
            EditorGUILayout.BeginHorizontal();
            DrawFloatProperty("_T2M_Layer_" + i + "_Metallic");
            DrawFloatProperty("_T2M_Layer_" + i + "_Occlusion");
            EditorGUILayout.EndHorizontal();
            EditorGUILayout.LabelField("Smoothness and SmoothnessFromDiffuseA: ");
            EditorGUILayout.BeginHorizontal();
            DrawFloatProperty("_T2M_Layer_" + i + "_Smoothness");
            DrawFloatProperty("_T2M_Layer_" + i + "_SmoothnessFromDiffuseA");
            EditorGUILayout.EndHorizontal();
            //DrawFloatProperty("_T2M_Layer_" + i + "_SmoothnessFromDiffuseAlpha");
            //DrawVectorProperty("_T2M_Layer_" + i + "_MetallicOcclusionSmoothness");
            DrawVectorProperty("_T2M_Layer_" + i + "_uvScaleOffset");
        }

    }

    void DrawVectorPropertyOneByOne(string propertyName) {
        MaterialProperty prop = FindProperty(propertyName, this.properties);
        if (prop == null) {
            return;
        }
        materialEditor.VectorProperty(prop, prop.displayName);
    }

    void DrawFloatProperty(string propertyName) {
        MaterialProperty prop = FindProperty(propertyName, this.properties);
        if (prop == null) {
            return;
        }
        materialEditor.FloatProperty(prop, string.Empty);
    }

    void DrawVectorProperty(string propertyName) {
        MaterialProperty prop = FindProperty(propertyName, this.properties);
        if (prop == null) {
            return;
        }
        materialEditor.VectorProperty(prop, prop.displayName);
    }


    void DrawTexturePropertyWithColor(string texturePropertyName, string colorPropertyName) {
        MaterialProperty textureProperty = FindProperty(texturePropertyName, this.properties);
        if (textureProperty == null) {
            return;
        }
        MaterialProperty colorProperty = FindProperty(colorPropertyName, this.properties);
        if (colorProperty == null) {
            return;
        }
        GUIContent texture_GUI = new GUIContent(textureProperty.displayName);
        materialEditor.TexturePropertyTwoLines(texture_GUI, textureProperty, colorProperty, null, null);
    }

    void DrawTextureProperty(string propertyName) {
        MaterialProperty prop = FindProperty(propertyName, this.properties);
        if (prop == null) {
            return;
        }
        GUIContent texture_GUI = new GUIContent(prop.displayName);
        materialEditor.TexturePropertySingleLine(texture_GUI, prop);
    }

    void DrawIntegerProperty(string propertyName) {
        MaterialProperty prop = FindProperty(propertyName, this.properties);
        if (prop == null) {
            return;
        }
        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField(prop.displayName);
        prop.floatValue = EditorGUILayout.IntField((int)prop.floatValue, GUILayout.Width(100.0f));
        //prop.floatValue = 8.0f;
        EditorGUILayout.EndHorizontal();
    }
}
