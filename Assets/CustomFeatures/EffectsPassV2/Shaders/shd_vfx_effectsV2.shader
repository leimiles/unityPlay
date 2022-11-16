Shader "funnyland/vfx/effectsV2"
{
    Properties
    {
        [HDR]_Color ("Color", Color) = (1, 0, 0, 0)
        [HideInInspector][PerRendererData]_attackedColor_Intensity ("Attacked Color Intensity", Range(0.0, 1.0)) = 1.0
    }

    SubShader
    {
        Tags { "RenderPipeline" = "UniversalPipeline" "RenderType" = "Overlay" "Queue" = "Overlay" }

        Pass
        {
            Blend One OneMinusSrcAlpha
            Name "Attacked"
            Tags { "LightMode" = "UniversalForward" }

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct attributes
            {
                float3 positionOS : POSITION;
                half3 normalOS : NORMAL;
            };

            CBUFFER_START(UnityPerMaterial)
                half4 _Color;
                half _attackedColor_Intensity;
            CBUFFER_END

            struct varyings
            {
                float4 positionCS : SV_POSITION;
                half3 normalWS : TEXCOORD0;
                half3 viewDirWS : TEXCOORD1;
            };

            void fresnelEffect(half3 Normal, half3 ViewDir, half Power, out half Out)
            {
                Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
            }

            varyings vert(attributes input)
            {
                varyings o = (varyings)0;
                VertexPositionInputs vpi = GetVertexPositionInputs(input.positionOS);
                o.positionCS = vpi.positionCS;
                VertexNormalInputs vni = GetVertexNormalInputs(input.normalOS);
                o.normalWS = vni.normalWS;
                o.viewDirWS = GetWorldSpaceNormalizeViewDir(vpi.positionWS);
                return o;
            }

            half4 frag(varyings i) : SV_Target
            {
                _Color = _Color * _attackedColor_Intensity;
                return half4(_Color.rgb, _attackedColor_Intensity);
            }
            ENDHLSL
        }
    }
}
