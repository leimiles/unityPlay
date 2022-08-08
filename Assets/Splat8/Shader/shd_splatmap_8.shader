Shader "funnyland/env/splatmap_8"
{
    Properties
    {
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

            #define _NORMALMAP

            #pragma vertex Vert
            #pragma fragment Frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

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

            TEXTURE2D(_T2M_Layer_0_NormalMap);SAMPLER(sampler_T2M_Layer_0_NormalMap);
            TEXTURE2D(_T2M_Layer_1_NormalMap);SAMPLER(sampler_T2M_Layer_1_NormalMap);
            TEXTURE2D(_T2M_Layer_2_NormalMap);SAMPLER(sampler_T2M_Layer_2_NormalMap);
            TEXTURE2D(_T2M_Layer_3_NormalMap);SAMPLER(sampler_T2M_Layer_3_NormalMap);
            TEXTURE2D(_T2M_Layer_4_NormalMap);SAMPLER(sampler_T2M_Layer_4_NormalMap);
            TEXTURE2D(_T2M_Layer_5_NormalMap);SAMPLER(sampler_T2M_Layer_5_NormalMap);
            TEXTURE2D(_T2M_Layer_6_NormalMap);SAMPLER(sampler_T2M_Layer_6_NormalMap);
            TEXTURE2D(_T2M_Layer_7_NormalMap);SAMPLER(sampler_T2M_Layer_7_NormalMap);


            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv0 : TEXCOORD0;
                half3 normalOS : NORMAL;
                half4 tangentOS : TANGENT;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 positionWS : TEXCOORD1;
                float2 uv0 : TEXCOORD0;
                half3 normalWS : TEXCOORD2;
                half4 tangentWS : TEXCOORD3;
                half3 viewDirWS : TEXCOORD4;
                half4 fogFactorAndVertexLight : TEXCOORD5;
                float4 shadowCoord : TEXCOORD6;
                half3 sh : TEXCOORD7;
            };

            struct TerrainInputData { };

            struct TerrainSurfaceData
            {
                half3 diffuse;
                half3 normalTS;
                half3 sepcular;
                half metallic;
                half smoothness;
                half3 emission;
                half occlusion;
                half clearCoatMask;
                half clearCoatSmoothness;
            };

            struct SplatmapColors
            {
                half4 color0;
                half4 color1;
            };

            struct SplatWeightData
            {
                half4 weight0;
                half4 weight1;
                // ...

            };

            Varyings Vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                VertexPositionInputs vpi = GetVertexPositionInputs(v.positionOS.xyz);
                o.positionCS = vpi.positionCS;
                o.positionWS = vpi.positionWS;
                VertexNormalInputs vni = GetVertexNormalInputs(v.normalOS, v.tangentOS);
                half3 vertexLight = VertexLighting(vpi.positionWS, vni.normalWS);
                half fogFactor = ComputeFogFactor(vpi.positionCS.z);
                o.fogFactorAndVertexLight = half4(vertexLight, fogFactor);

                o.normalWS = vni.normalWS;
                real sign = v.tangentOS.w * GetOddNegativeScale();
                o.tangentWS = half4(vni.tangentWS.xyz, sign);

                o.viewDirWS = GetWorldSpaceNormalizeViewDir(vpi.positionWS);
                o.uv0 = v.uv0;
                o.shadowCoord = GetShadowCoord(vpi);
                o.sh = SampleSH(vni.normalWS);
                return o;
            }


            void InitSplatWeightData(SplatmapColors splatmapColors, out SplatWeightData splatWeightData)
            {
                splatWeightData = (SplatWeightData)0;
                splatWeightData.weight0 = splatmapColors.color0;
                splatWeightData.weight1 = splatmapColors.color1;
            }

            half3 GetBlendedColor(half4 weight0, half4 weight1, half3 layer_0_Color, half3 layer_1_Color, half3 layer_2_Color, half3 layer_3_Color, half3 layer_4_Color, half3 layer_5_Color, half3 layer_6_Color, half3 layer_7_Color)
            {
                half3 finalColor0 = 0;
                finalColor0 += weight0.r * layer_0_Color;
                finalColor0 += weight0.g * layer_1_Color;
                finalColor0 += weight0.b * layer_2_Color;
                finalColor0 += weight0.a * layer_3_Color;
                /*
                half3 finalColor1 = 0;
                finalColor1 += weight1.r * layer_4_Color;
                finalColor1 += weight1.g * layer_5_Color;
                finalColor1 += weight1.b * layer_6_Color;
                finalColor1 += weight1.a * layer_7_Color;
                */

                half3 finalColor = finalColor0;

                finalColor = lerp(finalColor, layer_4_Color, weight1.r);
                finalColor = lerp(finalColor, layer_5_Color, weight1.g);
                finalColor = lerp(finalColor, layer_6_Color, weight1.b);
                finalColor = lerp(finalColor, layer_7_Color, weight1.a);

                return finalColor;
            }

            void InitializeTerrainSufaceData(float2 uv, SplatWeightData splatWeightData, out TerrainSurfaceData data)
            {
                data = (TerrainSurfaceData)0;
                half4 diffuse0 = SAMPLE_TEXTURE2D(_T2M_Layer_0_Diffuse, sampler_T2M_Layer_0_Diffuse, uv * _T2M_Layer_0_uvScaleOffset.xy);
                half4 diffuse1 = SAMPLE_TEXTURE2D(_T2M_Layer_1_Diffuse, sampler_T2M_Layer_1_Diffuse, uv * _T2M_Layer_1_uvScaleOffset.xy);
                half4 diffuse2 = SAMPLE_TEXTURE2D(_T2M_Layer_2_Diffuse, sampler_T2M_Layer_2_Diffuse, uv * _T2M_Layer_2_uvScaleOffset.xy);
                half4 diffuse3 = SAMPLE_TEXTURE2D(_T2M_Layer_3_Diffuse, sampler_T2M_Layer_3_Diffuse, uv * _T2M_Layer_3_uvScaleOffset.xy);
                half4 diffuse4 = SAMPLE_TEXTURE2D(_T2M_Layer_4_Diffuse, sampler_T2M_Layer_4_Diffuse, uv * _T2M_Layer_4_uvScaleOffset.xy);
                half4 diffuse5 = SAMPLE_TEXTURE2D(_T2M_Layer_5_Diffuse, sampler_T2M_Layer_5_Diffuse, uv * _T2M_Layer_5_uvScaleOffset.xy);
                half4 diffuse6 = SAMPLE_TEXTURE2D(_T2M_Layer_6_Diffuse, sampler_T2M_Layer_6_Diffuse, uv * _T2M_Layer_6_uvScaleOffset.xy);
                half4 diffuse7 = SAMPLE_TEXTURE2D(_T2M_Layer_7_Diffuse, sampler_T2M_Layer_7_Diffuse, uv * _T2M_Layer_7_uvScaleOffset.xy);
                half3 finalColor = GetBlendedColor(
                    splatWeightData.weight0,
                    splatWeightData.weight1,
                    _T2M_Layer_0_ColorTint.rgb * diffuse0.rgb,
                    _T2M_Layer_1_ColorTint.rgb * diffuse1.rgb,
                    _T2M_Layer_2_ColorTint.rgb * diffuse2.rgb,
                    _T2M_Layer_3_ColorTint.rgb * diffuse3.rgb,
                    _T2M_Layer_4_ColorTint.rgb * diffuse4.rgb,
                    _T2M_Layer_5_ColorTint.rgb * diffuse5.rgb,
                    _T2M_Layer_6_ColorTint.rgb * diffuse6.rgb,
                    _T2M_Layer_7_ColorTint.rgb * diffuse7.rgb
                );
                data.diffuse = finalColor;

                half3 normalTS0 = SampleNormal(uv * _T2M_Layer_0_uvScaleOffset.xy, TEXTURE2D_ARGS(_T2M_Layer_0_NormalMap, sampler_T2M_Layer_0_NormalMap));
                half3 normalTS1 = SampleNormal(uv * _T2M_Layer_1_uvScaleOffset.xy, TEXTURE2D_ARGS(_T2M_Layer_1_NormalMap, sampler_T2M_Layer_1_NormalMap));
                half3 normalTS2 = SampleNormal(uv * _T2M_Layer_2_uvScaleOffset.xy, TEXTURE2D_ARGS(_T2M_Layer_2_NormalMap, sampler_T2M_Layer_2_NormalMap));
                half3 normalTS3 = SampleNormal(uv * _T2M_Layer_3_uvScaleOffset.xy, TEXTURE2D_ARGS(_T2M_Layer_3_NormalMap, sampler_T2M_Layer_3_NormalMap));
                half3 normalTS4 = SampleNormal(uv * _T2M_Layer_4_uvScaleOffset.xy, TEXTURE2D_ARGS(_T2M_Layer_4_NormalMap, sampler_T2M_Layer_4_NormalMap));
                half3 normalTS5 = SampleNormal(uv * _T2M_Layer_5_uvScaleOffset.xy, TEXTURE2D_ARGS(_T2M_Layer_5_NormalMap, sampler_T2M_Layer_5_NormalMap));
                half3 normalTS6 = SampleNormal(uv * _T2M_Layer_6_uvScaleOffset.xy, TEXTURE2D_ARGS(_T2M_Layer_6_NormalMap, sampler_T2M_Layer_6_NormalMap));
                half3 normalTS7 = SampleNormal(uv * _T2M_Layer_7_uvScaleOffset.xy, TEXTURE2D_ARGS(_T2M_Layer_7_NormalMap, sampler_T2M_Layer_7_NormalMap));

                half3 finalNormal = GetBlendedColor(
                    splatWeightData.weight0,
                    splatWeightData.weight1,
                    normalTS0,
                    normalTS1,
                    normalTS2,
                    normalTS3,
                    normalTS4,
                    normalTS5,
                    normalTS6,
                    normalTS7
                );
                data.normalTS = finalNormal;
                data.clearCoatMask = 0.5;
                data.clearCoatSmoothness = 0.5;
                data.emission = 0;
                data.metallic = 0;
                data.occlusion = 1;
                data.sepcular = 0;
                data.smoothness = 0.5;
            }

            void InitializeInputData(Varyings input, half3 normalTS, out TerrainInputData terrainInputData)
            {
                terrainInputData = (TerrainInputData)0;
            }

            half4 Frag(Varyings i) : SV_TARGET
            {
                SplatmapColors splatmapColors;
                splatmapColors.color0 = SAMPLE_TEXTURE2D(_T2M_SplatMap_0, sampler_T2M_SplatMap_0, i.uv0);
                splatmapColors.color1 = SAMPLE_TEXTURE2D(_T2M_SplatMap_1, sampler_T2M_SplatMap_1, i.uv0);

                SplatWeightData splatWeightData;
                InitSplatWeightData(splatmapColors, splatWeightData);

                TerrainSurfaceData terrainSurfaceData;
                InitializeTerrainSufaceData(i.uv0, splatWeightData, terrainSurfaceData);
                return 1;
            }

            ENDHLSL
        }
    }

    CustomEditor "Splat_8_GUI"
}

