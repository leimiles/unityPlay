Shader "funnyland/env/sky"
{
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

            #pragma vertex vertex_program
            #pragma fragment fragment_program
            #pragma target 3.0
            #include "UnityCG.cginc"
            struct Attributes
            {
                float4 vertex : POSITION;
            };

            struct Varyings
            {
                float4 Position : SV_POSITION;
            };

            Varyings vertex_program(Attributes v)
            {
                Varyings Output = (Varyings)0;
                Output.Position = UnityObjectToClipPos(v.vertex);
                return Output;
            }

            float4 fragment_program(Varyings Input) : SV_Target
            {
                return float4(1, 1, 1, 1.0);
            }

            ENDHLSL
        }
    }
}