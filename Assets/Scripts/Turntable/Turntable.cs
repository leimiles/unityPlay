using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public class Turntable : MonoBehaviour {
    // Start is called before the first frame update
    public static float speed = 40.0f;
    // Update is called once per frame
    void Update() {
        this.transform.Rotate(Vector3.up * -1.0f * Time.deltaTime * speed, Space.Self);
    }
}
