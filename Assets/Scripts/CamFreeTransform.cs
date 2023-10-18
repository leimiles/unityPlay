using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class CamFreeTransform : MonoBehaviour {
    public float speed = 25f;
    public float rotationSpeed = 2000f;

    private Vector2 mousePos;
    private bool _isFirstMove;

    private Vector2 mousePosMove;
    private bool _isFirstMoveMove;


    private void Start() {
        Application.targetFrameRate = 60;
        mousePos = new Vector2(Screen.width - 400f, 400f);
        _isFirstMove = true;
        ScreenSet();
        /*
        int height = ()Screen.height * 2.33f;
        Screen.SetResolution(720, height)
        */
    }

    void ScreenSet() {
        Application.targetFrameRate = 60;
        Screen.orientation = ScreenOrientation.LandscapeLeft;
        float height;
        float width;
        if (Screen.height > Screen.width) {
            height = Screen.height;
            width = Screen.width;
        } else {
            height = Screen.width;
            width = Screen.height;
        }
        float ratio = height / width;
        int heightFixed = 720;
        int widthFixed = (int)(720.0f * ratio);
        Screen.SetResolution(widthFixed, heightFixed, FullScreenMode.FullScreenWindow);

    }

    void Update() {
        /*GameObject controlSphereMoveGUI = GameObject.Find("controlSphereMove");
        GameObject controlSphereRotateGUI = GameObject.Find("controlSphereRotate");*/
        if (Input.touchCount == 0) {
            mousePos = new Vector2(Screen.width - 400f, 400f);
            _isFirstMove = true;

            mousePosMove = new Vector2(400f, 400f);
            _isFirstMoveMove = true;
        }
        if (Input.touchCount == 1) {
            if (Input.GetTouch(0).position.x > Screen.width / 2) {
                _isFirstMoveMove = true;
            } else {
                _isFirstMove = true;
            }
        }
        if (Input.touchCount > 0) {
            /*            bool moveButton = false;
                        bool rotateButton = false;*/
            /*controlSphereMoveGUI.transform.position = Camera.main.ScreenToWorldPoint(new Vector3(400f, 400f, Camera.main.nearClipPlane + 0.03f));
            controlSphereRotateGUI.transform.position = Camera.main.ScreenToWorldPoint(new Vector3(Screen.width - 400f, 400f, Camera.main.nearClipPlane + 0.03f));*/
            for (int i = 0; i < 2; i++) {
                if (Input.GetTouch(i).position.x < Screen.width / 2) {
                    //moveButton = true;
                    if (_isFirstMoveMove == true) {
                        mousePosMove = Input.GetTouch(i).position;
                        _isFirstMoveMove = false;
                    }
                    if (_isFirstMoveMove == false) {
                        float xDistance = Input.GetTouch(i).position.x - mousePosMove.x;
                        transform.Translate(xDistance / 500f * Time.deltaTime * speed, 0, 0);
                        float zDistance = Input.GetTouch(i).position.y - mousePosMove.y;
                        transform.Translate(0, 0, zDistance / 500f * Time.deltaTime * speed);
                    }
                }
                if (Input.GetTouch(i).position.x > Screen.width / 2) {
                    //rotateButton = true;
                    if (_isFirstMove == true) {
                        mousePos = Input.GetTouch(i).position;
                        _isFirstMove = false;
                    }
                    if (_isFirstMove == false) {
                        float xDistance = Input.GetTouch(i).position.x - mousePos.x;
                        transform.Rotate(0, xDistance / 200f * Time.deltaTime * rotationSpeed, 0, Space.World);
                        float yDistance = -Input.GetTouch(i).position.y + mousePos.y;
                        transform.Rotate(yDistance / 200f * Time.deltaTime * rotationSpeed, 0, 0, Space.Self);

                        mousePos = Input.GetTouch(i).position;
                    }
                }
            }
        }
    }

    private void OnDrawGizmos() {
        Gizmos.DrawSphere(Camera.main.ScreenToWorldPoint(new Vector3(400f, 400f, Camera.main.nearClipPlane + 0.03f)), 0.03f);
        Gizmos.DrawSphere(Camera.main.ScreenToWorldPoint(new Vector3(Screen.width - 400f, 400f, Camera.main.nearClipPlane + 0.03f)), 0.03f);
    }
}
