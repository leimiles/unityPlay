using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[CustomEditor(typeof(MIDController))]
public class MIDControllerEditor : Editor {
    static bool[] buttonStates;
    MIDFeature mIDFeature;
    Rect mainRect;
    Rect detailRect;
    Color clicked;
    Color Released;
    Color guiForeground;
    Color guiBackground;
    bool isInit = false;
    void OnSceneGUI() {
        if (!isInit) {
            isInit = Init();
        }
        /*
        if (!Init()) {
            return;
        }
        // button section
        Handles.BeginGUI();
        GUILayout.BeginArea(new Rect(20, 20, 220, 120));
        var rect = EditorGUILayout.BeginVertical();
        GUI.color = Color.gray;
        GUI.Box(rect, GUIContent.none);
        GUI.color = Color.white;
        GUILayout.BeginHorizontal();
        GUILayout.FlexibleSpace();
        GUILayout.Label("MID Mode");
        GUILayout.FlexibleSpace();
        GUILayout.EndHorizontal();

        GUI.backgroundColor = buttonStates[0] ? Color.red : Color.gray;
        if (GUILayout.Button("Off")) {
            SetButtonState(0);
        }
        GUI.backgroundColor = buttonStates[1] ? Color.red : Color.gray;
        if (GUILayout.Button("By Material")) {
            SetButtonState(1);
        }
        GUI.backgroundColor = buttonStates[2] ? Color.red : Color.gray;
        if (GUILayout.Button("By Shader")) {
            SetButtonState(2);
        }
        GUI.backgroundColor = buttonStates[3] ? Color.red : Color.gray;
        if (GUILayout.Button("By Shader And Keywords")) {
            SetButtonState(3);
        }

        GUI.backgroundColor = Color.gray;

        EditorGUILayout.EndVertical();
        GUILayout.EndArea();
        Handles.EndGUI();
        Handles.BeginGUI();
        GUILayout.BeginArea(new Rect(20, 150, Screen.width, Screen.height - 200));
        ShowStatstics();
        GUILayout.EndArea();
        Handles.EndGUI();
        SetMIDMode();
        */
    }

    void ShowStatstics() {
        if (mIDFeature == null) {
            return;
        }
        Color temp = GUI.backgroundColor;
        GUI.backgroundColor = new Color(1, 1, 1, 0.4f);
        switch (mIDFeature.midMode) {
            case MIDFeature.MIDMode.Off:
                break;
            case MIDFeature.MIDMode.ByMaterial:
                GUILayout.Label("Material Count: " + mIDFeature.MaterialsCount);
                break;
            case MIDFeature.MIDMode.ByShader:
                GUILayout.Label("Shader Count: " + mIDFeature.ShadersCount);
                break;
            case MIDFeature.MIDMode.ByShaderAndKeywords:
                GUILayout.Label("Variant Count: " + mIDFeature.VariantsCount + " (lightmap keywords might not be collected.) ");
                if (MIDFeature.MIDManager.variantsSet != null && MIDFeature.MIDManager.variantsSet.Keys.Count > 0) {
                    int count = MIDFeature.MIDManager.variantsSet.Keys.Count;
                    foreach (string variantsSetName in MIDFeature.MIDManager.variantsSet.Keys) {
                        GUIContent buttonGUI = new GUIContent(variantsSetName, "");
                        GUIStyle style = EditorStyles.textArea;
                        style.fontSize = 8;
                        style.stretchWidth = true;
                        style.alignment = TextAnchor.MiddleLeft;
                        /*
                        if (GUILayout.Button(buttonGUI, style, GUILayout.ExpandWidth(false))) {
                            Selection.objects = MIDFeature.MIDManager.GetGameObjectsByVariantsSet(variantsSetName);
                        }
                        */
                    }
                }
                break;
        }
        GUI.backgroundColor = temp;
    }

    void SetMIDMode() {
        for (int i = 0; i < buttonStates.Length; i++) {
            if (buttonStates[i] == true) {
                mIDFeature.midMode = (MIDFeature.MIDMode)i;
            }
        }
    }

    bool Init() {
        if (buttonStates == null) {
            buttonStates = new bool[] { true, false, false, false };
        }
        if (mIDFeature == null) {
            MIDController mIDController = target as MIDController;
            if (mIDController.mIDFeature != null) {
                mIDFeature = mIDController.mIDFeature;
                InitGUI();
                return true;
            } else {
                Debug.Log("can't find mid feature");
            }
        }
        return false;
    }

    void InitGUI() {
        mainRect = new Rect(20, 20, 220, 120);
        detailRect = new Rect(20, 150, Screen.width - 30, Screen.height - 200);
    }

    void SetButtonState(int index) {
        if (buttonStates == null) {
            return;
        }
        if (!buttonStates[index]) {
            for (int i = 0; i < buttonStates.Length; i++) {
                buttonStates[i] = false;
            }
            buttonStates[index] = true;
        }

    }

}
