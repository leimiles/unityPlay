Shader "funnyland/env/sky"
{
    Properties
    {
        [NoScaleOffset] _MainCube ("Cubemap (HDR)", Cube) = "black" { }
    }
    SubShader
    {
        Tags { "Queue" = "Background" "RenderType" = "Background" "PreviewType" = "Skybox" "IgnoreProjector" = "True" }
        Cull Back     // Render side
        Fog
        {
            Mode Off
        }// Don't use fog
        ZWrite Off    // Don't draw to depth buffer

        Pass
        {
            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 4.5

            struct Attributes
            {
                float4 positionOS : POSITION;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 xyz : TEXCOORD0;
            };

            TEXTURECUBE(_MainCube); SAMPLER(sampler_MainCube);

            Varyings vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                VertexPositionInputs vpi = GetVertexPositionInputs(v.positionOS.xyz);
                o.positionCS = vpi.positionCS;
                o.xyz = v.positionOS.xyz;
                return o;
            }

            half4 frag(Varyings input) : SV_Target
            {
                half4 encodedIrradiance = SAMPLE_TEXTURECUBE(_MainCube, sampler_MainCube, input.xyz);
                return encodedIrradiance;
            }

            ENDHLSL
        }
    }
}