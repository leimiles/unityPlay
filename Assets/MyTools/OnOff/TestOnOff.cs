using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TestOnOff : MonoBehaviour {
    // Start is called before the first frame update
    public Text fpsText;
    public float deltaTime;
    float fps;
    Rect[] rects;
    public GameObject[] gameObjects;
    float buttonMargin = 40;
    int buttonWidth = 120;
    int buttonHeight = 30;
    float buttonScale = 1.0f;
    GUIStyle buttonStyle;
    void Start() {
        buttonScale = Screen.height / 1200;
        buttonMargin *= buttonScale;
        if (gameObjects.Length > 0) {
            rects = new Rect[gameObjects.Length];
            for (int i = 0; i < gameObjects.Length; i++) {
                rects[i] = new Rect(10, buttonMargin * i + buttonHeight, buttonWidth, buttonHeight);
                rects[i].width *= buttonScale;
                rects[i].height *= buttonScale;
            }
        }
    }

    // Update is called once per frame
    void Update() {
        Framerate();
    }

    void OnGUI() {
        buttonStyle = new GUIStyle(GUI.skin.button);
        buttonStyle.fontSize += (int)(buttonScale * 13);
        DrawOnOffButtons();
    }
    void DrawOnOffButtons() {
        for (int i = 0; i < gameObjects.Length; i++) {
            if (GUI.Button(rects[i], gameObjects[i].name, buttonStyle)) {
                if (gameObjects[i].activeSelf == true) {
                    gameObjects[i].SetActive(false);
                } else {
                    gameObjects[i].SetActive(true);
                }
            }
        }
    }

    void Framerate() {
        deltaTime += (Time.deltaTime - deltaTime) * 0.1f;
        fps = 1.0f / deltaTime;
        fpsText.text = Mathf.Ceil(fps).ToString();
    }
}
