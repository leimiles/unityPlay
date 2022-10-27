using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[CustomEditor(typeof(MIDController))]
public class MIDControllerEditor : Editor {
    bool[] buttonStates = new bool[] { true, false, false, false };
    MIDFeature mIDFeature;
    Rect mainRect;
    Rect detailRect;
    Rect detailsGroupRect;
    int detailsPadding;
    Color button_Clicked;
    Color button_Released;
    Color details_GuiBackgroun;
    GUIContent detialsButton;
    GUIStyle detailsButtonStyles;
    Color guiBackground;
    bool isInit = false;
    void OnSceneGUI() {
        if (isInit) {
            SetButtonState((int)mIDFeature.midMode);
            Handles.BeginGUI();
            ShowMainSection();
            ShowDetailsSection();
            Handles.EndGUI();
        } else {
            Init();
        }
    }

    void ShowMainSection() {
        GUILayout.BeginArea(mainRect);
        var rect = EditorGUILayout.BeginVertical();
        GUI.color = guiBackground;
        GUI.Box(rect, GUIContent.none);
        GUI.color = Color.white;
        GUILayout.BeginHorizontal();
        GUILayout.FlexibleSpace();
        GUILayout.Label("MID Mode");
        GUILayout.FlexibleSpace();
        GUILayout.EndHorizontal();
        GUI.backgroundColor = buttonStates[0] ? button_Clicked : button_Released;
        if (GUILayout.Button("Off")) {
            SetMIDMode(MIDFeature.MIDMode.Off);
            MIDManager.Clear();
        }
        GUI.backgroundColor = buttonStates[1] ? button_Clicked : button_Released;
        if (GUILayout.Button("By Material")) {
            SetMIDMode(MIDFeature.MIDMode.ByMaterial);
        }
        GUI.backgroundColor = buttonStates[2] ? button_Clicked : button_Released;
        if (GUILayout.Button("By Shader")) {
            SetMIDMode(MIDFeature.MIDMode.ByShader);
        }
        GUI.backgroundColor = buttonStates[3] ? button_Clicked : button_Released;
        if (GUILayout.Button("By Shader And Keywords")) {
            SetMIDMode(MIDFeature.MIDMode.ByShaderAndKeywords);
        }
        GUI.backgroundColor = Color.gray;
        EditorGUILayout.EndVertical();
        GUILayout.EndArea();
    }

    void ShowDetailsSection() {
        GUILayout.BeginArea(detailRect);
        GUILayout.BeginVertical();
        ShowDetails();
        GUILayout.EndVertical();
        GUILayout.EndArea();
    }

    void ShowDetails() {
        if (mIDFeature == null) {
            return;
        }
        GUI.backgroundColor = details_GuiBackgroun;
        switch (mIDFeature.midMode) {
            case MIDFeature.MIDMode.Off:
                break;
            case MIDFeature.MIDMode.ByMaterial:
                if (MIDManager.materialsSet == null) {
                    return;
                }
                //GUILayout.Label("Materials Count: " + MIDManager.materialsSet.Count);
                break;
            case MIDFeature.MIDMode.ByShader:
                if (MIDManager.shadersSet == null) {
                    return;
                }
                GUILayout.Label("Shaders Count: " + MIDManager.shadersSet.Count);
                if (MIDManager.shadersSet != null && MIDManager.shadersSet.Count > 0) {
                    int i = 0;
                    foreach (Shader shader in MIDManager.shadersSet.Keys) {
                        detailsGroupRect.y = detailsPadding * i + detailsPadding;
                        detailsGroupRect.height = 14;
                        detialsButton.text = shader.name + " ( " + MIDManager.shadersSetToObjects[shader].Count.ToString() + " ) ";
                        detailsGroupRect.width = detialsButton.text.Length * 4.2f;
                        GUI.contentColor = button_Clicked;
                        if (GUI.Button(detailsGroupRect, detialsButton, detailsButtonStyles)) {
                            Selection.objects = MIDManager.shadersSetToObjects[shader].ToArray();
                        }
                        GUI.contentColor = button_Released;
                        i++;
                    }
                }
                break;
            case MIDFeature.MIDMode.ByShaderAndKeywords:
                if (MIDManager.variantsSet == null) {
                    return;
                }
                //GUILayout.Label("Variants Count: " + MIDManager.variantsSet.Count);
                break;
        }
        GUI.backgroundColor = guiBackground;

    }

    void SetMIDMode(MIDFeature.MIDMode mode) {
        if (mIDFeature.midMode == mode) {
            MIDManager.SwapColor(mode);
        }
        mIDFeature.midMode = mode;
        SetButtonState((int)mode);
    }

    void Init() {
        MIDController mIDController = target as MIDController;
        if (mIDController.mIDFeature != null) {
            mIDFeature = mIDController.mIDFeature;
            InitGUI();
            isInit = true;
        } else {
            Debug.Log("can't find mid feature");
            isInit = false;
        }
    }

    void InitGUI() {
        mainRect = new Rect(20, 20, 220, 120);
        detailRect = new Rect(20, 150, Screen.width - 30, Screen.height - 200);
        detailsGroupRect = new Rect(0, 0, 1, 1);
        detailsPadding = 16;
        guiBackground = Color.gray;
        details_GuiBackgroun = new Color(1, 1, 1, 0.1f);        // need a transparent background
        button_Clicked = Color.green;
        button_Released = Color.white;
        detialsButton = new GUIContent("", "mid feature");
        detailsButtonStyles = EditorStyles.textArea;
        detailsButtonStyles.fontSize = 8;
        detailsButtonStyles.stretchWidth = true;
        detailsButtonStyles.alignment = TextAnchor.MiddleLeft;
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
