using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestOnOff : MonoBehaviour {
    // Start is called before the first frame update

    Rect[] rects;
    public GameObject[] gameObjects;
    int buttonMargin = 40;
    int buttonWidth = 120;
    int buttonHeight = 30;
    void Start() {
        if (gameObjects.Length > 0) {
            rects = new Rect[gameObjects.Length];

            for (int i = 0; i < gameObjects.Length; i++) {
                rects[i] = new Rect(10, buttonMargin * i + buttonHeight, buttonWidth, buttonHeight);
            }
        }
    }

    // Update is called once per frame
    void Update() {
    }

    void OnGUI() {
        DrawOnOffButtons();
    }

    void DrawOnOffButtons() {
        for (int i = 0; i < gameObjects.Length; i++) {
            if (GUI.Button(rects[i], gameObjects[i].name)) {
                if (gameObjects[i].activeSelf == true) {
                    gameObjects[i].SetActive(false);
                } else {
                    gameObjects[i].SetActive(true);
                }
            }
        }
    }
}
