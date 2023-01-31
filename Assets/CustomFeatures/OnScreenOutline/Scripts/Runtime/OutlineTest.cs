using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class OutlineTest : MonoBehaviour {

    public OutlineSettingObject outlineSetting;
    // Start is called before the first frame update
    public Slider mySlider;
    void Start() {

    }

    // Update is called once per frame
    void Update() {
        SetOutlineSettingWidth();
    }

    public void SetOutlineSettingBlur() {
        if (outlineSetting != null) {
            outlineSetting.outlineEffect = OutlineEffect.Blur;
        }
    }

    public void SetOutlineSettingSolid() {
        if (outlineSetting != null) {
            outlineSetting.outlineEffect = OutlineEffect.Solid;
        }
    }

    public void SetOutlineSettingSolidAA() {
        if (outlineSetting != null) {
            outlineSetting.outlineEffect = OutlineEffect.SolidAA;
        }
    }

    public void SetOutlineSettingWidth() {
        if (outlineSetting != null && mySlider != null) {
            //Debug.Log((int)mySlider.value);
            outlineSetting.OutlineWidth = (int)mySlider.value;
        }
    }
}
