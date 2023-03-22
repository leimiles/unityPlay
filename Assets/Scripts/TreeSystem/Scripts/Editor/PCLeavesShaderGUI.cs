using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public static class PCLeavesShaderStyle {
    public struct PCLeavesShaderProperties {
        public PCLeavesShaderProperties(MaterialProperty[] properties) {

        }

    }

}


public class PCLeavesShaderGUI : BaseShaderGUI {
    PCLeavesShaderStyle.PCLeavesShaderProperties pCLeavesShaderProperties;
    public override void FindProperties(MaterialProperty[] properties) {
        base.FindProperties(properties);
        pCLeavesShaderProperties = new PCLeavesShaderStyle.PCLeavesShaderProperties(properties);
    }

}
