Shader "Chicken/PC/Leaves"
{
    Properties
    {
        _WindSpeed ("Wind Speed", Range(0, 1)) = 0.5
        _WindWavesScale ("Wind Waves Scale", Range(0, 1)) = 0.25
        _WindForce ("Wind Force", Range(0, 1)) = 0.3
        _WindDirection ("Wind Direction", Range(0, 1)) = 0
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

        float3 windDirection(float3 windOffset, half direction)
        {
            // wind direction happens around Y axis
            half rad = radians(360.0 * direction);
            float4 c0 = float4(cos(rad), 0, -1.0 * sin(rad), 0.0);
            float4 c1 = float4(0.0, 1.0, 0.0, 0.0);
            float4 c2 = float4(sin(rad), 0.0, cos(rad), 0.0);
            float4 c3 = float4(0.0, 0.0, 0.0, 1.0);

            float4x4 orientMat = float4x4(c0, c1, c2, c3);

            return mul(orientMat, float4(windOffset, 1.0));
        }
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

            CBUFFER_START(UnityPerMaterial)
                half _WindSpeed;
                half _WindWavesScale;
                half _WindForce;
                half _WindDirection;
            CBUFFER_END

            struct Attributes
            {
                float4 positionOS : POSITION;
                half2 uv0 : TEXCOORD0;
                half2 uv1 : TEXCOORD1;
                half3 normalOS : NORMAL;
                //half4 tangentOS : TANGENT;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                half4 uv0Anduv1 : TEXCOORD0;
                half4 normalWSAndFogFactor : TEXCOORD1;
                float4 shadowCoord : TEXCOORD2;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };


            Varyings vert(Attributes input)
            {
                Varyings output = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_TRANSFER_INSTANCE_ID(input, output);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

                float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
                VertexNormalInputs vni = GetVertexNormalInputs(input.normalOS);
                output.normalWSAndFogFactor.xyz = vni.normalWS;
                float time = _TimeParameters.x * _WindSpeed * 10.0;
                float perlinNoise = snoise((positionWS + time) * _WindWavesScale) * 0.01;

                // fixed foliage base
                // perlinNoise = perlinNoise * pow(input.uv0.y, 2.0);

                // wind force
                perlinNoise = perlinNoise * _WindForce * 30.0;

                input.positionOS.xyz += windDirection(perlinNoise.xxx, _WindDirection);

                VertexPositionInputs vpi = GetVertexPositionInputs(input.positionOS.xyz);
                output.positionCS = vpi.positionCS;
                return output;
            }

            half4 frag(Varyings input) : SV_TARGET
            {
                return 0.5;
            }

            ENDHLSL
        }

        /*
            // 关闭 shadow caster
            Pass
            {

            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }

            ZWrite On
            ZTest LEqual

            HLSLPROGRAM
            #pragma target 4.5
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #define _TRANSLUCENCY_ASE 1
            #pragma multi_compile_instancing
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #pragma multi_compile_fog
            #define ASE_FOG 1
            #define _ALPHATEST_ON 1
            #define ASE_SRP_VERSION 70200

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x

            #pragma vertex vert
            #pragma fragment frag

            #define SHADERPASS_SHADOWCASTER

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

            #pragma shader_feature_local _WIND_ON
            #pragma shader_feature_local _FIXTHEBASEOFFOLIAGE_ON


            struct VertexInput
            {
                float4 vertex : POSITION;
                float3 ase_normal : NORMAL;
                float4 ase_texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct VertexOutput
            {
                float4 clipPos : SV_POSITION;
                #if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
                    float3 worldPos : TEXCOORD0;
                #endif
                #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
                    float4 shadowCoord : TEXCOORD1;
                #endif
                float4 ase_texcoord2 : TEXCOORD2;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            CBUFFER_START(UnityPerMaterial)
                float4 _Color1;
                float4 _Texture00_ST;
                float4 _Color2;
                float4 _SnowMask_ST;
                float _WindSpeed;
                float _WindWavesScale;
                float _WindForce;
                float _Color2Level;
                float _Color2Fade;
                float _SnowAmount;
                float _SnowFade;
                float _Smoothness;
                float _Cutoff;
                #ifdef _TRANSMISSION_ASE
                    float _TransmissionShadow;
                #endif
                #ifdef _TRANSLUCENCY_ASE
                    float _TransStrength;
                    float _TransNormal;
                    float _TransScattering;
                    float _TransDirect;
                    float _TransAmbient;
                    float _TransShadow;
                #endif
                #ifdef TESSELLATION_ON
                    float _TessPhongStrength;
                    float _TessValue;
                    float _TessMin;
                    float _TessMax;
                    float _TessEdgeLength;
                    float _TessMaxDisp;
                #endif
            CBUFFER_END
            sampler2D _Texture00;


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
                const float2 C = float2(1.0 / 6.0, 1.0 / 3.0);
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


            float3 _LightDirection;

            VertexOutput VertexFunction(VertexInput v)
            {
                VertexOutput o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
                float mulTime34 = _TimeParameters.x * (_WindSpeed * 5);
                float simplePerlin3D35 = snoise((ase_worldPos + mulTime34) * _WindWavesScale);
                float temp_output_231_0 = (simplePerlin3D35 * 0.01);
                float2 uv0357 = v.ase_texcoord.xy * float2(1, 1) + float2(0, 0);
                #ifdef _FIXTHEBASEOFFOLIAGE_ON
                    float staticSwitch376 = (temp_output_231_0 * pow(uv0357.y, 2.0));
                #else
                    float staticSwitch376 = temp_output_231_0;
                #endif
                #ifdef _WIND_ON
                    float staticSwitch341 = (staticSwitch376 * (_WindForce * 30));
                #else
                    float staticSwitch341 = 0.0;
                #endif
                float Wind191 = staticSwitch341;
                float3 temp_cast_0 = (Wind191).xxx;

                o.ase_texcoord2.xy = v.ase_texcoord.xy;

                //setting value to unused interpolator channels and avoid initialization warnings
                o.ase_texcoord2.zw = 0;
                #ifdef ASE_ABSOLUTE_VERTEX_POS
                    float3 defaultVertexValue = v.vertex.xyz;
                #else
                    float3 defaultVertexValue = float3(0, 0, 0);
                #endif
                float3 vertexValue = temp_cast_0;
                #ifdef ASE_ABSOLUTE_VERTEX_POS
                    v.vertex.xyz = vertexValue;
                #else
                    v.vertex.xyz += vertexValue;
                #endif

                v.ase_normal = v.ase_normal;

                float3 positionWS = TransformObjectToWorld(v.vertex.xyz);
                #if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
                    o.worldPos = positionWS;
                #endif
                float3 normalWS = TransformObjectToWorldDir(v.ase_normal);

                float4 clipPos = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, _LightDirection));

                #if UNITY_REVERSED_Z
                    clipPos.z = min(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
                #else
                    clipPos.z = max(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
                #endif
                #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
                    VertexPositionInputs vertexInput = (VertexPositionInputs)0;
                    vertexInput.positionWS = positionWS;
                    vertexInput.positionCS = clipPos;
                    o.shadowCoord = GetShadowCoord(vertexInput);
                #endif
                o.clipPos = clipPos;
                return o;
            }

            #if defined(TESSELLATION_ON)
                struct VertexControl
                {
                    float4 vertex : INTERNALTESSPOS;
                    float3 ase_normal : NORMAL;
                    float4 ase_texcoord : TEXCOORD0;

                    UNITY_VERTEX_INPUT_INSTANCE_ID
                };

                struct TessellationFactors
                {
                    float edge[3] : SV_TessFactor;
                    float inside : SV_InsideTessFactor;
                };

                VertexControl vert(VertexInput v)
                {
                    VertexControl o;
                    UNITY_SETUP_INSTANCE_ID(v);
                    UNITY_TRANSFER_INSTANCE_ID(v, o);
                    o.vertex = v.vertex;
                    o.ase_normal = v.ase_normal;
                    o.ase_texcoord = v.ase_texcoord;
                    return o;
                }

                TessellationFactors TessellationFunction(InputPatch < VertexControl, 3 > v)
                {
                    TessellationFactors o;
                    float4 tf = 1;
                    float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
                    float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
                    #if defined(ASE_FIXED_TESSELLATION)
                        tf = FixedTess(tessValue);
                    #elif defined(ASE_DISTANCE_TESSELLATION)
                        tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos);
                    #elif defined(ASE_LENGTH_TESSELLATION)
                        tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams);
                    #elif defined(ASE_LENGTH_CULL_TESSELLATION)
                        tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes);
                    #endif
                    o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
                    return o;
                }

                [domain("tri")]
                [partitioning("fractional_odd")]
                [outputtopology("triangle_cw")]
                [patchconstantfunc("TessellationFunction")]
                [outputcontrolpoints(3)]
                VertexControl HullFunction(InputPatch < VertexControl, 3 > patch, uint id : SV_OutputControlPointID)
                {
                    return patch[id];
                }

                [domain("tri")]
                VertexOutput DomainFunction(TessellationFactors factors, OutputPatch < VertexControl, 3 > patch, float3 bary : SV_DomainLocation)
                {
                    VertexInput o = (VertexInput) 0;
                    o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
                    o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
                    o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
                    #if defined(ASE_PHONG_TESSELLATION)
                        float3 pp[3];
                        for (int i = 0; i < 3; ++i)
                        pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
                        float phongStrength = _TessPhongStrength;
                        o.vertex.xyz = phongStrength * (pp[0] * bary.x + pp[1] * bary.y + pp[2] * bary.z) + (1.0f - phongStrength) * o.vertex.xyz;
                    #endif
                    UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
                    return VertexFunction(o);
                }
            #else
                VertexOutput vert(VertexInput v)
                {
                    return VertexFunction(v);
                }
            #endif

            half4 frag(VertexOutput IN) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(IN);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

                #if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
                    float3 WorldPosition = IN.worldPos;
                #endif
                float4 ShadowCoords = float4(0, 0, 0, 0);

                #if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
                    #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
                        ShadowCoords = IN.shadowCoord;
                    #elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                        ShadowCoords = TransformWorldToShadowCoord(WorldPosition);
                    #endif
                #endif

                float2 uv_Texture00 = IN.ase_texcoord2.xy * _Texture00_ST.xy + _Texture00_ST.zw;
                float4 tex2DNode1 = tex2D(_Texture00, uv_Texture00);
                float Alpha263 = tex2DNode1.a;

                float Alpha = Alpha263;
                float AlphaClipThreshold = _Cutoff;

                #ifdef _ALPHATEST_ON
                    clip(Alpha - AlphaClipThreshold);
                #endif

                #ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(IN.clipPos.xyz, unity_LODFade.x);
                #endif
                return 0;
            }

            ENDHLSL
            }
        */

        /*
            // 关闭 depth only
            Pass
            {

            Name "DepthOnly"
            Tags { "LightMode" = "DepthOnly" }

            ZWrite On
            ColorMask 0

            HLSLPROGRAM
            #define _TRANSLUCENCY_ASE 1
            #pragma multi_compile_instancing
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #pragma multi_compile_fog
            #define ASE_FOG 1
            #define _ALPHATEST_ON 1
            #define ASE_SRP_VERSION 70200
            #pragma target 4.5
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x

            #pragma vertex vert
            #pragma fragment frag

            #define SHADERPASS_DEPTHONLY

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

            #pragma shader_feature_local _WIND_ON
            #pragma shader_feature_local _FIXTHEBASEOFFOLIAGE_ON


            struct VertexInput
            {
                float4 vertex : POSITION;
                float3 ase_normal : NORMAL;
                float4 ase_texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct VertexOutput
            {
                float4 clipPos : SV_POSITION;
                #if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
                    float3 worldPos : TEXCOORD0;
                #endif
                #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
                    float4 shadowCoord : TEXCOORD1;
                #endif
                float4 ase_texcoord2 : TEXCOORD2;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            CBUFFER_START(UnityPerMaterial)
                float4 _Color1;
                float4 _Texture00_ST;
                float4 _Color2;
                float4 _SnowMask_ST;
                float _WindSpeed;
                float _WindWavesScale;
                float _WindForce;
                float _Color2Level;
                float _Color2Fade;
                float _SnowAmount;
                float _SnowFade;
                float _Smoothness;
                float _Cutoff;
                #ifdef _TRANSMISSION_ASE
                    float _TransmissionShadow;
                #endif
                #ifdef _TRANSLUCENCY_ASE
                    float _TransStrength;
                    float _TransNormal;
                    float _TransScattering;
                    float _TransDirect;
                    float _TransAmbient;
                    float _TransShadow;
                #endif
                #ifdef TESSELLATION_ON
                    float _TessPhongStrength;
                    float _TessValue;
                    float _TessMin;
                    float _TessMax;
                    float _TessEdgeLength;
                    float _TessMaxDisp;
                #endif
            CBUFFER_END
            sampler2D _Texture00;


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
                const float2 C = float2(1.0 / 6.0, 1.0 / 3.0);
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


            VertexOutput VertexFunction(VertexInput v)
            {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
                float mulTime34 = _TimeParameters.x * (_WindSpeed * 5);
                float simplePerlin3D35 = snoise((ase_worldPos + mulTime34) * _WindWavesScale);
                float temp_output_231_0 = (simplePerlin3D35 * 0.01);
                float2 uv0357 = v.ase_texcoord.xy * float2(1, 1) + float2(0, 0);
                #ifdef _FIXTHEBASEOFFOLIAGE_ON
                    float staticSwitch376 = (temp_output_231_0 * pow(uv0357.y, 2.0));
                #else
                    float staticSwitch376 = temp_output_231_0;
                #endif
                #ifdef _WIND_ON
                    float staticSwitch341 = (staticSwitch376 * (_WindForce * 30));
                #else
                    float staticSwitch341 = 0.0;
                #endif
                float Wind191 = staticSwitch341;
                float3 temp_cast_0 = (Wind191).xxx;

                o.ase_texcoord2.xy = v.ase_texcoord.xy;

                //setting value to unused interpolator channels and avoid initialization warnings
                o.ase_texcoord2.zw = 0;
                #ifdef ASE_ABSOLUTE_VERTEX_POS
                    float3 defaultVertexValue = v.vertex.xyz;
                #else
                    float3 defaultVertexValue = float3(0, 0, 0);
                #endif
                float3 vertexValue = temp_cast_0;
                #ifdef ASE_ABSOLUTE_VERTEX_POS
                    v.vertex.xyz = vertexValue;
                #else
                    v.vertex.xyz += vertexValue;
                #endif

                v.ase_normal = v.ase_normal;
                float3 positionWS = TransformObjectToWorld(v.vertex.xyz);
                float4 positionCS = TransformWorldToHClip(positionWS);

                #if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
                    o.worldPos = positionWS;
                #endif

                #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
                    VertexPositionInputs vertexInput = (VertexPositionInputs)0;
                    vertexInput.positionWS = positionWS;
                    vertexInput.positionCS = positionCS;
                    o.shadowCoord = GetShadowCoord(vertexInput);
                #endif
                o.clipPos = positionCS;
                return o;
            }

            #if defined(TESSELLATION_ON)
                struct VertexControl
                {
                    float4 vertex : INTERNALTESSPOS;
                    float3 ase_normal : NORMAL;
                    float4 ase_texcoord : TEXCOORD0;

                    UNITY_VERTEX_INPUT_INSTANCE_ID
                };

                struct TessellationFactors
                {
                    float edge[3] : SV_TessFactor;
                    float inside : SV_InsideTessFactor;
                };

                VertexControl vert(VertexInput v)
                {
                    VertexControl o;
                    UNITY_SETUP_INSTANCE_ID(v);
                    UNITY_TRANSFER_INSTANCE_ID(v, o);
                    o.vertex = v.vertex;
                    o.ase_normal = v.ase_normal;
                    o.ase_texcoord = v.ase_texcoord;
                    return o;
                }

                TessellationFactors TessellationFunction(InputPatch < VertexControl, 3 > v)
                {
                    TessellationFactors o;
                    float4 tf = 1;
                    float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
                    float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
                    #if defined(ASE_FIXED_TESSELLATION)
                        tf = FixedTess(tessValue);
                    #elif defined(ASE_DISTANCE_TESSELLATION)
                        tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos);
                    #elif defined(ASE_LENGTH_TESSELLATION)
                        tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams);
                    #elif defined(ASE_LENGTH_CULL_TESSELLATION)
                        tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes);
                    #endif
                    o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
                    return o;
                }

                [domain("tri")]
                [partitioning("fractional_odd")]
                [outputtopology("triangle_cw")]
                [patchconstantfunc("TessellationFunction")]
                [outputcontrolpoints(3)]
                VertexControl HullFunction(InputPatch < VertexControl, 3 > patch, uint id : SV_OutputControlPointID)
                {
                    return patch[id];
                }

                [domain("tri")]
                VertexOutput DomainFunction(TessellationFactors factors, OutputPatch < VertexControl, 3 > patch, float3 bary : SV_DomainLocation)
                {
                    VertexInput o = (VertexInput) 0;
                    o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
                    o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
                    o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
                    #if defined(ASE_PHONG_TESSELLATION)
                        float3 pp[3];
                        for (int i = 0; i < 3; ++i)
                        pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
                        float phongStrength = _TessPhongStrength;
                        o.vertex.xyz = phongStrength * (pp[0] * bary.x + pp[1] * bary.y + pp[2] * bary.z) + (1.0f - phongStrength) * o.vertex.xyz;
                    #endif
                    UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
                    return VertexFunction(o);
                }
            #else
                VertexOutput vert(VertexInput v)
                {
                    return VertexFunction(v);
                }
            #endif

            half4 frag(VertexOutput IN) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(IN);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

                #if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
                    float3 WorldPosition = IN.worldPos;
                #endif
                float4 ShadowCoords = float4(0, 0, 0, 0);

                #if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
                    #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
                        ShadowCoords = IN.shadowCoord;
                    #elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
                        ShadowCoords = TransformWorldToShadowCoord(WorldPosition);
                    #endif
                #endif

                float2 uv_Texture00 = IN.ase_texcoord2.xy * _Texture00_ST.xy + _Texture00_ST.zw;
                float4 tex2DNode1 = tex2D(_Texture00, uv_Texture00);
                float Alpha263 = tex2DNode1.a;

                float Alpha = Alpha263;
                float AlphaClipThreshold = _Cutoff;

                #ifdef _ALPHATEST_ON
                    clip(Alpha - AlphaClipThreshold);
                #endif

                #ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(IN.clipPos.xyz, unity_LODFade.x);
                #endif
                return 0;
            }
            ENDHLSL
            }
        */
    }
}
