using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LayerCullDistancesTest : MonoBehaviour {
    // Start is called before the first frame update
    void Start() {
        Camera camera = GetComponent<Camera>();
        float[] distances = new float[32];
        distances[10] = 15;
        camera.layerCullDistances = distances;
    }

    // Update is called once per frame
    void Update() {

    }
}
