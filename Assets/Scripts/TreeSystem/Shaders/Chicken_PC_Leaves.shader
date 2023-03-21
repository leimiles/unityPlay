Shader "Chicken/PC/Leaves"
{
    Properties
    {
        _BaseColor ("Main Color", Color) = (0, 1, 0, 1)
        _SecondColor ("Second Color", Color) = (0, 0, 0, 1)
        _Radius ("Spherical Radius", Range(0.001, 100)) = 15.0
        [HDR]_EmissionColor ("Emission Color", Color) = (0, 0, 0, 0)
        _MainTexture ("Main Texture", 2D) = "white" { }
        //_Cutoff ("Alpha Clip", Range(0, 1)) = 0.35
        //_WindForce ("Wind Force", Range(0, 1)) = 0.2
        //_WindWavesScale ("Wind Waves Scale", Range(0, 1)) = 0.2
        //_WindSpeed ("Wind Speed", Range(0, 1)) = 0.5
        _WindSpeed_WindWavesScale_WindForce_Cutoff ("WindSpeed, WindScale, WindForce, Cutoff ( < 1.0 )", Vector) = (0.5, 0.2, 0.2, 0.35)
        _TransNormal ("Trans Normal Distortion", Range(0, 1)) = 1.0
        _TransScattering ("Trans Scattering", Range(1, 50)) = 2
        _TransDirect ("Trans Direct", Range(0, 1)) = 0.35
        _TransAmbient ("Trans Ambient", Range(0, 1)) = 1.0
        _TransStrength ("Trans Strength", Range(0, 10)) = 0.5
    }

    SubShader
    {
        LOD 0



        Tags { "RenderPipeline" = "UniversalPipeline" "RenderType" = "TransparentCutout" "Queue" = "AlphaTest" }
        Cull Off
        HLSLINCLUDE
        #pragma target 3.0
        float3 mod3D289(float3 x)
        {
            return x - floor(x / 289.0) * 289.0;
        }
        float4 mod3D289(float4 x)
        {
            return x - floor(x / 289.0) * 289.0;
        }
        float4 permute(float4 x)
        {
            return mod3D289((x * 34.0 + 1.0) * x);
        }
        float4 taylorInvSqrt(float4 r)
        {
            return 1.79284291400159 - r * 0.85373472095314;
        }
        float snoise(float3 v)
        {
            const float2 C = float2(0.1667, 0.3333);
            float3 i = floor(v + dot(v, C.yyy));
            float3 x0 = v - i + dot(i, C.xxx);
            float3 g = step(x0.yzx, x0.xyz);
            float3 l = 1.0 - g;
            float3 i1 = min(g.xyz, l.zxy);
            float3 i2 = max(g.xyz, l.zxy);
            float3 x1 = x0 - i1 + C.xxx;
            float3 x2 = x0 - i2 + C.yyy;
            float3 x3 = x0 - 0.5;
            i = mod3D289(i);
            float4 p = permute(permute(permute(i.z + float4(0.0, i1.z, i2.z, 1.0)) + i.y + float4(0.0, i1.y, i2.y, 1.0)) + i.x + float4(0.0, i1.x, i2.x, 1.0));
            float4 j = p - 49.0 * floor(p / 49.0);  // mod(p,7*7)
            float4 x_ = floor(j / 7.0);
            float4 y_ = floor(j - 7.0 * x_);  // mod(j,N)
            float4 x = (x_ * 2.0 + 0.5) / 7.0 - 1.0;
            float4 y = (y_ * 2.0 + 0.5) / 7.0 - 1.0;
            float4 h = 1.0 - abs(x) - abs(y);
            float4 b0 = float4(x.xy, y.xy);
            float4 b1 = float4(x.zw, y.zw);
            float4 s0 = floor(b0) * 2.0 + 1.0;
            float4 s1 = floor(b1) * 2.0 + 1.0;
            float4 sh = -step(h, 0.0);
            float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
            float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
            float3 g0 = float3(a0.xy, h.x);
            float3 g1 = float3(a0.zw, h.y);
            float3 g2 = float3(a1.xy, h.z);
            float3 g3 = float3(a1.zw, h.w);
            float4 norm = taylorInvSqrt(float4(dot(g0, g0), dot(g1, g1), dot(g2, g2), dot(g3, g3)));
            g0 *= norm.x;
            g1 *= norm.y;
            g2 *= norm.z;
            g3 *= norm.w;
            float4 m = max(0.6 - float4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);
            m = m * m;
            m = m * m;
            float4 px = float4(dot(x0, g0), dot(x1, g1), dot(x2, g2), dot(x3, g3));
            return 42.0 * dot(m, px);
        }


        float4 FixedTess(float tessValue)
        {
            return tessValue;
        }

        float CalcDistanceTessFactor(float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos)
        {
            float3 wpos = mul(o2w, vertex).xyz;
            float dist = distance(wpos, cameraPos);
            float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
            return f;
        }

        float4 CalcTriEdgeTessFactors(float3 triVertexFactors)
        {
            float4 tess;
            tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
            tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
            tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
            tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
            return tess;
        }

        float CalcEdgeTessFactor(float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams)
        {
            float dist = distance(0.5 * (wpos0 + wpos1), cameraPos);
            float len = distance(wpos0, wpos1);
            float f = max(len * scParams.y / (edgeLen * dist), 1.0);
            return f;
        }

        float DistanceFromPlane(float3 pos, float4 plane)
        {
            float d = dot(float4(pos, 1.0f), plane);
            return d;
        }

        bool WorldViewFrustumCull(float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6])
        {
            float4 planeTest;
            planeTest.x = ((DistanceFromPlane(wpos0, planes[0]) > - cullEps) ? 1.0f : 0.0f) +
            ((DistanceFromPlane(wpos1, planes[0]) > - cullEps) ? 1.0f : 0.0f) +
            ((DistanceFromPlane(wpos2, planes[0]) > - cullEps) ? 1.0f : 0.0f);
            planeTest.y = ((DistanceFromPlane(wpos0, planes[1]) > - cullEps) ? 1.0f : 0.0f) +
            ((DistanceFromPlane(wpos1, planes[1]) > - cullEps) ? 1.0f : 0.0f) +
            ((DistanceFromPlane(wpos2, planes[1]) > - cullEps) ? 1.0f : 0.0f);
            planeTest.z = ((DistanceFromPlane(wpos0, planes[2]) > - cullEps) ? 1.0f : 0.0f) +
            ((DistanceFromPlane(wpos1, planes[2]) > - cullEps) ? 1.0f : 0.0f) +
            ((DistanceFromPlane(wpos2, planes[2]) > - cullEps) ? 1.0f : 0.0f);
            planeTest.w = ((DistanceFromPlane(wpos0, planes[3]) > - cullEps) ? 1.0f : 0.0f) +
            ((DistanceFromPlane(wpos1, planes[3]) > - cullEps) ? 1.0f : 0.0f) +
            ((DistanceFromPlane(wpos2, planes[3]) > - cullEps) ? 1.0f : 0.0f);
            return !all(planeTest);
        }

        float4 DistanceBasedTess(float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos)
        {
            float3 f;
            f.x = CalcDistanceTessFactor(v0, minDist, maxDist, tess, o2w, cameraPos);
            f.y = CalcDistanceTessFactor(v1, minDist, maxDist, tess, o2w, cameraPos);
            f.z = CalcDistanceTessFactor(v2, minDist, maxDist, tess, o2w, cameraPos);

            return CalcTriEdgeTessFactors(f);
        }

        float4 EdgeLengthBasedTess(float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams)
        {
            float3 pos0 = mul(o2w, v0).xyz;
            float3 pos1 = mul(o2w, v1).xyz;
            float3 pos2 = mul(o2w, v2).xyz;
            float4 tess;
            tess.x = CalcEdgeTessFactor(pos1, pos2, edgeLength, cameraPos, scParams);
            tess.y = CalcEdgeTessFactor(pos2, pos0, edgeLength, cameraPos, scParams);
            tess.z = CalcEdgeTessFactor(pos0, pos1, edgeLength, cameraPos, scParams);
            tess.w = (tess.x + tess.y + tess.z) / 3.0f;
            return tess;
        }

        float4 EdgeLengthBasedTessCull(float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6])
        {
            float3 pos0 = mul(o2w, v0).xyz;
            float3 pos1 = mul(o2w, v1).xyz;
            float3 pos2 = mul(o2w, v2).xyz;
            float4 tess;

            if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
            {
                tess = 0.0f;
            }
            else
            {
                tess.x = CalcEdgeTessFactor(pos1, pos2, edgeLength, cameraPos, scParams);
                tess.y = CalcEdgeTessFactor(pos2, pos0, edgeLength, cameraPos, scParams);
                tess.z = CalcEdgeTessFactor(pos0, pos1, edgeLength, cameraPos, scParams);
                tess.w = (tess.x + tess.y + tess.z) / 3.0f;
            }
            return tess;
        }
        /*
        float3 windDirection(float3 windOffset, float direction)
        {
            // wind direction happens around Y axis
            float rad = radians(360.0 * direction);
            float4 c0 = float4(cos(rad), 0, -1.0 * sin(rad), 0.0);
            float4 c1 = float4(0.0, 1.0, 0.0, 0.0);
            float4 c2 = float4(sin(rad), 0.0, cos(rad), 0.0);
            float4 c3 = float4(0.0, 0.0, 0.0, 1.0);

            float4x4 orientMat = float4x4(c0, c1, c2, c3);

            return mul(orientMat, float4(windOffset, 1.0));
        }
        */

        ENDHLSL

        Pass
        {

            Name "Forward"
            Tags { "LightMode" = "UniversalForward" }

            Blend One Zero, One Zero
            ZWrite On

            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma multi_compile_fog

            #pragma multi_compile_fragment LOD_FADE_CROSSFADE

            #if defined(LOD_FADE_CROSSFADE)
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

            //#define LOD_FADE_CROSSFADE 1

            CBUFFER_START(UnityPerMaterial)
                //half _WindSpeed;
                //half _WindWavesScale;
                //half _WindForce;
                //half _Cutoff;
                half4 _WindSpeed_WindWavesScale_WindForce_Cutoff;
                half4 _BaseColor;
                half4 _SecondColor;
                half4 _EmissionColor;
                half _Radius;
                half _TransNormal;
                half _TransScattering;
                half _TransAmbient;
                half _TransDirect;
                half _TransStrength;
            CBUFFER_END

            struct Attributes
            {
                float4 positionOS : POSITION;
                half2 uv0 : TEXCOORD0;
                half3 normalOS : NORMAL;
                //half4 tangentOS : TANGENT;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 lightmapUVOrVertexSH : TEXCOORD1;
                half4 normalWSAndCenterLength : TEXCOORD2;
                half4 viewDirWSAndFogFactor : TEXCOORD3;
                float3 positionWS : TEXCOORD4;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            TEXTURE2D(_MainTexture);       SAMPLER(sampler_MainTexture);


            Varyings vert(Attributes input)
            {
                Varyings output = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

                float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
                float time = _TimeParameters.x * (_WindSpeed_WindWavesScale_WindForce_Cutoff.x * 5.0);
                float perlinNoise = snoise((positionWS + time) * _WindSpeed_WindWavesScale_WindForce_Cutoff.y);

                // wind force
                perlinNoise = perlinNoise * _WindSpeed_WindWavesScale_WindForce_Cutoff.z * 0.1;

                // world pos
                positionWS = TransformObjectToWorld(input.positionOS.xyz);

                // use fixed center based
                half lengthToPivot = length(input.positionOS.xyz);
                lengthToPivot = saturate(lengthToPivot / _Radius);
                // fade with height?
                //perlinNoise *= input.positionOS.y;
                //perlinNoise *= lengthToPivot;
                positionWS.xyz += half3(perlinNoise.x, perlinNoise.x, perlinNoise.x);
                //positionWS.xyz += perlinNoise.xxx;

                // manually transform
                float3 positionVS = TransformWorldToView(positionWS);
                float4 positionCS = TransformWorldToHClip(positionWS);
                output.positionCS = positionCS;
                output.positionWS = positionWS;

                VertexNormalInputs vni = GetVertexNormalInputs(input.normalOS);
                output.normalWSAndCenterLength.xyz = vni.normalWS;
                output.normalWSAndCenterLength.w = smoothstep(0.25, 0.30, lengthToPivot);

                output.uv0 = input.uv0;

                OUTPUT_SH(vni.normalWS.xyz, output.lightmapUVOrVertexSH.xyz);
                //half3 vertexLight = VertexLighting(positionWS, vni.normalWS);
                output.viewDirWSAndFogFactor.xyz = SafeNormalize(_WorldSpaceCameraPos.xyz - positionWS);
                output.viewDirWSAndFogFactor.w = ComputeFogFactor(positionCS.z);

                return output;
            }

            half4 frag(Varyings input) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(IN);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

                /*
                #ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(input.positionCS.xyz, unity_LODFade.x);
                #endif
                */

                half4 mainColor = SAMPLE_TEXTURE2D(_MainTexture, sampler_MainTexture, input.uv0);
                clip(mainColor.a - _WindSpeed_WindWavesScale_WindForce_Cutoff.w);

                InputData inputData;
                inputData.positionWS = input.positionWS;
                inputData.viewDirectionWS = input.viewDirWSAndFogFactor.xyz;
                inputData.shadowCoord = 0;  // shadow is not needed for now
                inputData.normalWS = normalize(input.normalWSAndCenterLength.xyz);
                inputData.fogCoord = input.viewDirWSAndFogFactor.w;
                inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, input.lightmapUVOrVertexSH.xyz, input.normalWSAndCenterLength.xyz);

                half3 Albedo = lerp(_BaseColor.rgb, _SecondColor.rgb, input.normalWSAndCenterLength.w) * mainColor.rgb;

                half4 brdfColor = UniversalFragmentPBR(
                    inputData,
                    Albedo * mainColor.rgb,
                    0.0,
                    0.0,
                    0.0,
                    1,
                    0.0,
                    mainColor.a);

                Light mainLight = GetMainLight();

                float3 mainLightAtten = mainLight.color * mainLight.distanceAttenuation;
                half3 mainLightDir = mainLight.direction + inputData.normalWS * _TransNormal;

                half mainVdotL = pow(saturate(dot(inputData.viewDirectionWS, -mainLightDir)), _TransScattering);
                half3 mainTranslucency = mainLightAtten * (mainVdotL * _TransDirect + inputData.bakedGI * _TransAmbient);
                mainTranslucency = Albedo * mainTranslucency * _TransStrength;
                brdfColor.rgb += mainTranslucency;
                brdfColor.rgb = MixFog(brdfColor.rgb, input.viewDirWSAndFogFactor.w);

                return brdfColor;
            }

            ENDHLSL
        }

        Pass
        {
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }

            ZWrite On
            ZTest LEqual

            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma multi_compile_fog

            #pragma multi_compile_fragment LOD_FADE_CROSSFADE

            #if defined(LOD_FADE_CROSSFADE)
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

            CBUFFER_START(UnityPerMaterial)
                //half _WindSpeed;
                //half _WindWavesScale;
                //half _WindForce;
                //half _Cutoff;
                half4 _WindSpeed_WindWavesScale_WindForce_Cutoff;
                half4 _BaseColor;
                half4 _SecondColor;
                half4 _EmissionColor;
                half _Radius;
                half _TransNormal;
                half _TransScattering;
                half _TransAmbient;
                half _TransDirect;
                half _TransStrength;
            CBUFFER_END

            struct Attributes
            {
                float4 positionOS : POSITION;
                half2 uv0 : TEXCOORD0;
                half3 normalOS : NORMAL;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 lightmapUVOrVertexSH : TEXCOORD1;
                half4 normalWSAndCenterLength : TEXCOORD2;
                half4 viewDirWSAndFogFactor : TEXCOORD3;
                float3 positionWS : TEXCOORD4;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            TEXTURE2D(_MainTexture);       SAMPLER(sampler_MainTexture);


            Varyings vert(Attributes input)
            {
                Varyings output = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

                float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
                float time = _TimeParameters.x * (_WindSpeed_WindWavesScale_WindForce_Cutoff.x * 5.0);
                float perlinNoise = snoise((positionWS + time) * _WindSpeed_WindWavesScale_WindForce_Cutoff.y);

                // wind force
                perlinNoise = perlinNoise * _WindSpeed_WindWavesScale_WindForce_Cutoff.z * 0.1;

                // world pos
                positionWS = TransformObjectToWorld(input.positionOS.xyz);

                // use fixed center based
                half lengthToPivot = length(input.positionOS.xyz);
                lengthToPivot = saturate(lengthToPivot / _Radius);

                positionWS.xyz += half3(perlinNoise.x, perlinNoise.x, perlinNoise.x);

                // manually transform
                float3 positionVS = TransformWorldToView(positionWS);
                float4 positionCS = TransformWorldToHClip(positionWS);
                output.positionCS = positionCS;
                output.positionWS = positionWS;

                VertexNormalInputs vni = GetVertexNormalInputs(input.normalOS);
                output.normalWSAndCenterLength.xyz = vni.normalWS;
                output.normalWSAndCenterLength.w = smoothstep(0.25, 0.30, lengthToPivot);

                output.uv0 = input.uv0;

                OUTPUT_SH(vni.normalWS.xyz, output.lightmapUVOrVertexSH.xyz);
                output.viewDirWSAndFogFactor.xyz = SafeNormalize(_WorldSpaceCameraPos.xyz - positionWS);
                output.viewDirWSAndFogFactor.w = ComputeFogFactor(positionCS.z);

                return output;
            }

            half4 frag(Varyings input) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(IN);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);
                half4 mainColor = SAMPLE_TEXTURE2D(_MainTexture, sampler_MainTexture, input.uv0);
                clip(mainColor.a - _WindSpeed_WindWavesScale_WindForce_Cutoff.w);
                return 0;
            }

            ENDHLSL
        }
    }
}
