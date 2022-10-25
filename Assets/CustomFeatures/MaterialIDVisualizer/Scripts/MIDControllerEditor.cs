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
    void OnSceneGUI() {
        if (!Init()) {
            return;
        }
        // button section
        Handles.BeginGUI();
        GUILayout.BeginArea(new Rect(20, 20, 180, 120));
        var rect = EditorGUILayout.BeginVertical();
        GUI.color = Color.yellow;
        GUI.Box(rect, GUIContent.none);
        GUI.color = Color.white;
        GUILayout.BeginHorizontal();
        GUILayout.FlexibleSpace();
        GUILayout.Label("MID Mode");
        GUILayout.FlexibleSpace();
        GUILayout.EndHorizontal();

        GUI.backgroundColor = buttonStates[0] ? Color.red : Color.yellow;
        if (GUILayout.Button("Off")) {
            SetButtonState(0);
        }
        GUI.backgroundColor = buttonStates[1] ? Color.red : Color.yellow;
        if (GUILayout.Button("By Material")) {
            SetButtonState(1);
        }
        GUI.backgroundColor = buttonStates[2] ? Color.red : Color.yellow;
        if (GUILayout.Button("By Shader")) {
            SetButtonState(2);
        }
        GUI.backgroundColor = buttonStates[3] ? Color.red : Color.yellow;
        if (GUILayout.Button("By Shader And Keywords")) {
            Test();
            SetButtonState(3);
        }


        EditorGUILayout.EndVertical();
        GUILayout.EndArea();
        ShowStatstics();
        Handles.EndGUI();
        SetMIDMode();
    }

    void Test() {
    }

    void ShowStatstics() {
        if (mIDFeature == null) {
            return;
        }
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
                GUILayout.Label("Variant Count: " + mIDFeature.VariantsCount);
                break;
        }
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
                return true;
            } else {
                Debug.Log("can't find mid feature");
                return false;
            }
        } else {
            return true;
        }
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
