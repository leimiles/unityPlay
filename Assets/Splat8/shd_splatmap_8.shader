Shader "funnyland/env/splatmap_8"
{
    Properties
    {
        //Terrain To Mesh Properties/////////////////////////////////////////////////////////////////////////////////////////////////////////
        [HideInInspector] _T2M_Layer_Count ("Layer Count", float) = 0

        [Space]
        [HideInInspector] [NoScaleOffset] _T2M_SplatMap_0 ("Splat Map #10 (RGBA)", 2D) = "black" { }
        [HideInInspector] [NoScaleOffset] _T2M_SplatMap_1 ("Splat Map #10 (RGBA)", 2D) = "black" { }

        [HideInInspector] _T2M_Layer_0_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_0_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_0_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] _T2M_Layer_0_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_0_Metallic ("Metallic", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_0_Occlusion ("Occlusion", Range(0, 1)) = 1
        [HideInInspector] _T2M_Layer_0_Smoothness ("Smoothness", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_0_SmoothnessFromDiffuseA ("Smoothness From Diffuse A", Range(0, 1)) = 0

        [HideInInspector] _T2M_Layer_7_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_7_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_7_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] _T2M_Layer_7_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_7_Metallic ("Metallic", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_7_Occlusion ("Occlusion", Range(0, 1)) = 1
        [HideInInspector] _T2M_Layer_7_Smoothness ("Smoothness", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_7_SmoothnessFromDiffuseA ("Smoothness From Diffuse A", Range(0, 1)) = 0

        [HideInInspector] _T2M_Layer_6_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_6_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_6_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] _T2M_Layer_6_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_6_Metallic ("Metallic", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_6_Occlusion ("Occlusion", Range(0, 1)) = 1
        [HideInInspector] _T2M_Layer_6_Smoothness ("Smoothness", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_6_SmoothnessFromDiffuseA ("Smoothness From Diffuse A", Range(0, 1)) = 0

        [HideInInspector] _T2M_Layer_5_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_5_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_5_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] _T2M_Layer_5_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_5_Metallic ("Metallic", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_5_Occlusion ("Occlusion", Range(0, 1)) = 1
        [HideInInspector] _T2M_Layer_5_Smoothness ("Smoothness", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_5_SmoothnessFromDiffuseA ("Smoothness From Diffuse A", Range(0, 1)) = 0

        [HideInInspector] _T2M_Layer_4_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_4_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_4_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] _T2M_Layer_4_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_4_Metallic ("Metallic", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_4_Occlusion ("Occlusion", Range(0, 1)) = 1
        [HideInInspector] _T2M_Layer_4_Smoothness ("Smoothness", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_4_SmoothnessFromDiffuseA ("Smoothness From Diffuse A", Range(0, 1)) = 0

        [HideInInspector] _T2M_Layer_3_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_3_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_3_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] _T2M_Layer_3_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_3_Metallic ("Metallic", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_3_Occlusion ("Occlusion", Range(0, 1)) = 1
        [HideInInspector] _T2M_Layer_3_Smoothness ("Smoothness", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_3_SmoothnessFromDiffuseA ("Smoothness From Diffuse A", Range(0, 1)) = 0

        [HideInInspector] _T2M_Layer_2_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_2_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_2_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] _T2M_Layer_2_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_2_Metallic ("Metallic", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_2_Occlusion ("Occlusion", Range(0, 1)) = 1
        [HideInInspector] _T2M_Layer_2_Smoothness ("Smoothness", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_2_SmoothnessFromDiffuseA ("Smoothness From Diffuse A", Range(0, 1)) = 0

        [HideInInspector] _T2M_Layer_1_ColorTint ("Color Tint", Color) = (1, 1, 1, 1)
        [HideInInspector] [NoScaleOffset] _T2M_Layer_1_Diffuse ("Paint Map 1 (R)", 2D) = "white" { }
        [HideInInspector] [NoScaleOffset] _T2M_Layer_1_NormalMap ("Bump", 2D) = "bump" { }
        [HideInInspector] _T2M_Layer_1_uvScaleOffset ("UV Scale", Vector) = (1, 1, 0, 0)
        [HideInInspector] _T2M_Layer_1_Metallic ("Metallic", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_1_Occlusion ("Occlusion", Range(0, 1)) = 1
        [HideInInspector] _T2M_Layer_1_Smoothness ("Smoothness", Range(0, 1)) = 0
        [HideInInspector] _T2M_Layer_1_SmoothnessFromDiffuseA ("Smoothness From Diffuse A", Range(0, 1)) = 0
    }

    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "TransparentCutout" "RenderPipeline" = "UniversalPipeline" "UniversalMaterialType" = "Lit" "IgnoreProjector" = "False" "TerrainCompatible" = "True" }
        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode" = "UniversalForward" }

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5

            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            CBUFFER_START(UnityPerMaterial)
                half4 _T2M_Layer_0_ColorTint;
                half4 _T2M_Layer_1_ColorTint;
                half4 _T2M_Layer_2_ColorTint;
                half4 _T2M_Layer_3_ColorTint;
                half4 _T2M_Layer_4_ColorTint;
                half4 _T2M_Layer_5_ColorTint;
                half4 _T2M_Layer_6_ColorTint;
                half4 _T2M_Layer_7_ColorTint;
                float4 _T2M_Layer_0_uvScaleOffset;
                float4 _T2M_Layer_1_uvScaleOffset;
                float4 _T2M_Layer_2_uvScaleOffset;
                float4 _T2M_Layer_3_uvScaleOffset;
                float4 _T2M_Layer_4_uvScaleOffset;
                float4 _T2M_Layer_5_uvScaleOffset;
                float4 _T2M_Layer_6_uvScaleOffset;
                float4 _T2M_Layer_7_uvScaleOffset;
            CBUFFER_END

            TEXTURE2D(_T2M_SplatMap_0);SAMPLER(sampler_T2M_SplatMap_0);
            TEXTURE2D(_T2M_SplatMap_1);SAMPLER(sampler_T2M_SplatMap_1);

            TEXTURE2D(_T2M_Layer_0_Diffuse);SAMPLER(sampler_T2M_Layer_0_Diffuse);
            TEXTURE2D(_T2M_Layer_1_Diffuse);SAMPLER(sampler_T2M_Layer_1_Diffuse);
            TEXTURE2D(_T2M_Layer_2_Diffuse);SAMPLER(sampler_T2M_Layer_2_Diffuse);
            TEXTURE2D(_T2M_Layer_3_Diffuse);SAMPLER(sampler_T2M_Layer_3_Diffuse);
            TEXTURE2D(_T2M_Layer_4_Diffuse);SAMPLER(sampler_T2M_Layer_4_Diffuse);
            TEXTURE2D(_T2M_Layer_5_Diffuse);SAMPLER(sampler_T2M_Layer_5_Diffuse);
            TEXTURE2D(_T2M_Layer_6_Diffuse);SAMPLER(sampler_T2M_Layer_6_Diffuse);
            TEXTURE2D(_T2M_Layer_7_Diffuse);SAMPLER(sampler_T2M_Layer_7_Diffuse);


            struct a2v
            {
                float4 positionOS : POSITION;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f
            {
                float4 positionCS : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };

            v2f vert(a2v v)
            {
                v2f o = (v2f)0;
                VertexPositionInputs vpi = GetVertexPositionInputs(v.positionOS.xyz);
                o.positionCS = vpi.positionCS;
                o.uv0 = v.uv0;
                return o;
            }

            void calculate_Splat_Weight(half4 splat0, half4 splat1, out half4 weight0, out half4 weight1)
            {
                weight0 = splat0;
                weight1 = splat1;
            }

            half4 getFinalColor(half4 weight0, half4 weight1, half4 layer_0_Color, half4 layer_1_Color, half4 layer_2_Color, half4 layer_3_Color, half4 layer_4_Color, half4 layer_5_Color, half4 layer_6_Color, half4 layer_7_Color)
            {
                half4 finalColor0 = 0;
                finalColor0 += weight0.r * layer_0_Color;
                finalColor0 += weight0.g * layer_1_Color;
                finalColor0 += weight0.b * layer_2_Color;
                finalColor0 += weight0.a * layer_3_Color;

                half4 finalColor1 = 0;
                finalColor1 += weight1.r * layer_4_Color;
                finalColor1 += weight1.g * layer_5_Color;
                finalColor1 += weight1.b * layer_6_Color;
                finalColor1 += weight1.a * layer_7_Color;

                half4 finalColor = finalColor0;
                
                /*
                // paint layer 4
                finalColor = saturate(finalColor - weight1.r);
                finalColor += (layer_4_Color * weight1.r);
                // paint layer 5
                finalColor = saturate(finalColor - weight1.g);
                finalColor += (layer_5_Color * weight1.g);
                // paint layer 6
                finalColor = saturate(finalColor - weight1.b);
                finalColor += (layer_6_Color * weight1.b);
                // paint layer 7
                finalColor = saturate(finalColor - weight1.a);
                finalColor += (layer_7_Color * weight1.a);
                */

                finalColor = lerp(finalColor, layer_4_Color, weight1.r);
                finalColor = lerp(finalColor, layer_5_Color, weight1.g);
                finalColor = lerp(finalColor, layer_6_Color, weight1.b);
                finalColor = lerp(finalColor, layer_7_Color, weight1.a);

                return finalColor;
            }

            half4 frag(v2f i) : SV_TARGET
            {
                half4 splat0 = SAMPLE_TEXTURE2D(_T2M_SplatMap_0, sampler_T2M_SplatMap_0, i.uv0);
                half4 splat1 = SAMPLE_TEXTURE2D(_T2M_SplatMap_1, sampler_T2M_SplatMap_1, i.uv0);

                half4 weight0;
                half4 weight1;
                calculate_Splat_Weight(splat0, splat1, weight0, weight1);

                half4 diffuse0 = SAMPLE_TEXTURE2D(_T2M_Layer_0_Diffuse, sampler_T2M_Layer_0_Diffuse, i.uv0 * _T2M_Layer_0_uvScaleOffset.xy);
                half4 diffuse1 = SAMPLE_TEXTURE2D(_T2M_Layer_1_Diffuse, sampler_T2M_Layer_1_Diffuse, i.uv0 * _T2M_Layer_1_uvScaleOffset.xy);
                half4 diffuse2 = SAMPLE_TEXTURE2D(_T2M_Layer_2_Diffuse, sampler_T2M_Layer_2_Diffuse, i.uv0 * _T2M_Layer_2_uvScaleOffset.xy);
                half4 diffuse3 = SAMPLE_TEXTURE2D(_T2M_Layer_3_Diffuse, sampler_T2M_Layer_3_Diffuse, i.uv0 * _T2M_Layer_3_uvScaleOffset.xy);
                half4 diffuse4 = SAMPLE_TEXTURE2D(_T2M_Layer_4_Diffuse, sampler_T2M_Layer_4_Diffuse, i.uv0 * _T2M_Layer_4_uvScaleOffset.xy);
                half4 diffuse5 = SAMPLE_TEXTURE2D(_T2M_Layer_5_Diffuse, sampler_T2M_Layer_5_Diffuse, i.uv0 * _T2M_Layer_5_uvScaleOffset.xy);
                half4 diffuse6 = SAMPLE_TEXTURE2D(_T2M_Layer_6_Diffuse, sampler_T2M_Layer_6_Diffuse, i.uv0 * _T2M_Layer_6_uvScaleOffset.xy);
                half4 diffuse7 = SAMPLE_TEXTURE2D(_T2M_Layer_7_Diffuse, sampler_T2M_Layer_7_Diffuse, i.uv0 * _T2M_Layer_7_uvScaleOffset.xy);

                half4 finalColor = getFinalColor(
                    weight0,
                    weight1,
                    _T2M_Layer_0_ColorTint * diffuse0,
                    _T2M_Layer_1_ColorTint * diffuse1,
                    _T2M_Layer_2_ColorTint * diffuse2,
                    _T2M_Layer_3_ColorTint * diffuse3,
                    _T2M_Layer_4_ColorTint * diffuse4,
                    _T2M_Layer_5_ColorTint * diffuse5,
                    _T2M_Layer_6_ColorTint * diffuse6,
                    _T2M_Layer_7_ColorTint * diffuse7
                );

                return finalColor;
            }

            ENDHLSL
        }
    }

    CustomEditor "Splat_8_GUI"
}

