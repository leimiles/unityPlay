using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RenderTextureTest {
    public static void ShowCurrentRT() {
        if (RenderTexture.active == null) {
            Debug.Log("no active RT");
        } else {
            Debug.Log("active RT is " + RenderTexture.active.name);
        }
    }
}
