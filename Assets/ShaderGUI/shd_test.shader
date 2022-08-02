Shader "funnyland/env/terrain/splatmap_8"
{
    Properties
    {


        //[HideInInspector][CurvedWorldBendSettings] _CurvedWorldBendSettings ("0|1|1", Vector) = (0, 0, 0, 0)


        //Terrain To Mesh Properties/////////////////////////////////////////////////////////////////////////////////////////////////////////
        [HideInInspector] [TerrainToMeshLayerCounter] _T2M_Layer_Count ("Layer Count", int) = 0

        [Space]
        [HideInInspector] [NoScaleOffset] _T2M_SplatMap_0 ("Splat Map #10 (RGBA)", 2D) = "black" { }

        [HideInInspector] _T2M_Layer_0_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_0_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_0_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_0_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_0_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_0_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_0_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_0_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_0_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_0_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_0_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_1_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_1_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_1_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_1_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_1_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_1_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_1_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_1_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_1_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_1_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_1_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_2_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_2_Diffuse ("Paint Map 2 (G)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_2_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_2_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_2_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_2_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_2_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_2_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_2_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_2_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_2_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_3_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_3_Diffuse ("Paint Map 3 (B)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_3_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_3_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_3_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_3_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_3_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_3_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_3_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_3_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_3_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)


        [HideInInspector] [NoScaleOffset] _T2M_SplatMap_1 ("Splat Map #1 (RGBA)", 2D) = "black" { }

        [HideInInspector] _T2M_Layer_4_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_4_Diffuse ("Paint Map 4 (A)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_4_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_4_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_4_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_4_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_4_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_4_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_4_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_4_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_4_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_5_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_5_Diffuse ("Paint Map 5 (R)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_5_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_5_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_5_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_5_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_5_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_5_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_5_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_5_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_5_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_6_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_6_Diffuse ("Paint Map 6 (G)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_6_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_6_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_6_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_6_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_6_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_6_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_6_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_6_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_6_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_7_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_7_Diffuse ("Paint Map 7 (B)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_7_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_7_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_7_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_7_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_7_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_7_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_7_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_7_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_7_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)


        [HideInInspector] [NoScaleOffset] _T2M_SplatMap_2 ("Splat Map #2 (RGBA)", 2D) = "black" { }

        [HideInInspector] _T2M_Layer_8_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_8_Diffuse ("Paint Map 8 (A)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_8_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_8_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_8_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_8_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_8_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_8_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_8_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_8_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_8_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_9_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_9_Diffuse ("Paint Map 9 (R)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_9_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_9_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_9_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_9_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_9_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_9_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_9_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_9_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_9_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_10_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_10_Diffuse ("Paint Map 10 (G)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_10_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_10_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_10_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_10_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_10_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_10_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_10_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_10_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_10_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_11_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_11_Diffuse ("Paint Map 11 (B)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_11_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_11_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_11_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_11_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_11_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_11_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_11_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_11_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_11_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)


        [HideInInspector] [NoScaleOffset] _T2M_SplatMap_3 ("Splat Map #3 (RGBA)", 2D) = "black" { }

        [HideInInspector] _T2M_Layer_12_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_12_Diffuse ("Paint Map 12 (A)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_12_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_12_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_12_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_12_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_12_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_12_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_12_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_12_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_12_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_13_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_13_Diffuse ("Paint Map 13 (R)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_13_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_13_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_13_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_13_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_13_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_13_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_13_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_13_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_13_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_14_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_14_Diffuse ("Paint Map 14 (G)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_14_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_14_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_14_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_14_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_14_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_14_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_14_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_14_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_14_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)

        [HideInInspector] _T2M_Layer_15_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_15_Diffuse ("Paint Map 15 (B)", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_15_NormalScale ("Strength", float) = 1
        [HideInInspector] [NoScaleOffset] _T2M_Layer_15_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_15_Mask ("Mask", 2D) = "white" { }
        [HideInInspector] _T2M_Layer_15_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_15_MapsUsage ("Maps Usage", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_15_MetallicOcclusionSmoothness ("Metallic (R), Occlusion (G), Smoothness(A)", Vector) = (0, 1, 0, 0)
        [HideInInspector] _T2M_Layer_15_SmoothnessFromDiffuseAlpha ("", float) = 0
        [HideInInspector] _T2M_Layer_15_MaskMapRemapMin ("Maskmap Remap Min", Vector) = (0, 0, 0, 0)
        [HideInInspector] _T2M_Layer_15_MaskMapRemapMax ("Maskmap Remap Max", Vector) = (1, 1, 1, 1)


        //Texture 2D Array
        [HideInInspector] [NoScaleOffset] _T2M_SplatMaps2DArray ("SplatMaps 2D Array", 2DArray) = "black" { }
        [HideInInspector] [NoScaleOffset] _T2M_DiffuseMaps2DArray ("DiffuseMaps 2D Array", 2DArray) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_NormalMaps2DArray ("NormalMaps 2D Array", 2DArray) = "bump" { }
        [HideInInspector] [NoScaleOffset] _T2M_MaskMaps2DArray ("MaskMaps 2D Array", 2DArray) = "white" { }

        //Holesmap
        [HideInInspector] [NoScaleOffset] _T2M_HolesMap ("Holes Map", 2D) = "white" { }

        //Fallback use only
        [HideInInspector] _Color ("Color", Color) = (1, 1, 1, 1)								//Not used
        [HideInInspector] [NoScaleOffset] _BaseMap ("Fallback Diffuse", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _BumpMap ("Fallback Normal", 2D) = "bump" { }

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }

    CustomEditor "Splat_8_GUI"
}
