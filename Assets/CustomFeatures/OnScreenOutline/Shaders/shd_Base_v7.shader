Shader "Framework/shd_Base_v7" {
    Properties {
        _BaseMap ("Texture", 2D) = "white" {}
        _Cutoff ("Cut Out", Range(0, 1)) = 0.5
    }
    SubShader {
        Tags { "RenderType"="Opaque" "Queue" = "Geometry+1" "RenderPipeline" = "UniversalPipeline"}
        LOD 100

        Pass {
            Name "Base"
            Tags { "LightMode" = "UniversalForward" }
            HLSLPROGRAM
            /*
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 3.5
            */
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"

            struct a2v {
                float4 positionOS : POSITION;
                float2 texcoord : TEXCOORD0;
            };
            struct v2f {
                float4 positionCS : SV_POSITION;
                float2 texcoord : TEXCOORD0;
            };
            
            v2f vert (a2v v) {
                v2f o;
                VertexPositionInputs vertexInput = GetVertexPositionInputs(v.positionOS.xyz);
                o.positionCS = vertexInput.positionCS;
                o.texcoord = TRANSFORM_TEX(v.texcoord, _BaseMap);
                return o;
            }

            half4 frag (v2f i) : SV_Target {
                half4 col = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.texcoord);
                clip(col.a - _Cutoff);
                return col;
            }
            ENDHLSL
        }
    }
}
