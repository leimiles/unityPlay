Shader "Framework/shd_OutlineFill_v3"
{
    HLSLINCLUDE
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

    TEXTURE2D(_MaskTex);
    SAMPLER(sampler_MaskTex);

    TEXTURE2D(_MainTex);
    SAMPLER(sampler_MainTex);
    float2 _MainTex_TexelSize;

    float4 _Color;
    float _Intensity;
    int _Width;
    float _GaussSamplesTest[32];

    struct v2f
    {
        float4 positionCS : SV_POSITION;
        float2 uv : TEXCOORD0;
        UNITY_VERTEX_OUTPUT_STEREO
    };


    struct Attributes
    {
        uint vertexID : SV_VertexID;
        UNITY_VERTEX_INPUT_INSTANCE_ID
    };

    v2f VertexSimple(Attributes input)
    {
        v2f output = (v2f)0;

        UNITY_SETUP_INSTANCE_ID(input);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

        output.positionCS = GetFullScreenTriangleVertexPosition(input.vertexID);
        output.uv = GetFullScreenTriangleTexCoord(input.vertexID);

        return output;
    }

    float GetIntensity(float2 uv, float2 offset)
    {
        float intensity = 0;

        for (int i = -_Width; i <= _Width; ++i)
        {
            intensity += SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv + i * offset).r * _GaussSamplesTest[abs(i)];
        }

        return intensity;
    }

    float PD(float value)
    {
        float2 pd = float2(ddx(value), ddy(value));
        return sqrt(dot(pd, pd));
    }

    float PD2(float value)
    {
        return fwidth(value);
    }

    float StepThresholdPD(float value, float pd)
    {
        return saturate(value / max(0.00001, pd) + 0.5);
    }

    float StepAA(float value)
    {
        return StepThresholdPD(value, PD2(value));
    }
	
    float StepAA(float thresh, float value)
    {
        return StepAA(value - thresh);
    }

    float4 FragmentScreen(v2f i) : SV_Target
    {
        UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
        float2 uv = UnityStereoTransformScreenSpaceTex(i.uv);
        float intensity = GetIntensity(uv, float2(_MainTex_TexelSize.x, 0));
        return float4(intensity, intensity, intensity, 1);
    }

    float4 FragmentOutline(v2f i) : SV_Target
    {
        UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
        float2 uv = UnityStereoTransformScreenSpaceTex(i.uv);
        if (SAMPLE_TEXTURE2D(_MaskTex, sampler_MaskTex, uv).r > 0)
        {
            discard;
        }
        float intensity = GetIntensity(uv, float2(0, _MainTex_TexelSize.y));
        //return float4(_Color.rgb, saturate(_Color.a * intensity));
        // use blur effect
        #if _OUTLINE_BLUR
            //return float4(1, 0, 0, 1);
            //intensity *= _Intensity;
            return float4(_Color.rgb, saturate(_Color.a * intensity));
            // use solid aa effect
        #elif _OUTLINE_AA
            //return float4(0, 1, 0, 1);
            intensity = StepAA(0.05, intensity);
            return float4(_Color.rgb, saturate(_Color.a * intensity));
            // use normal solid effect
        #else
            //return float4(0, 0, 1, 1);
            intensity = step(0.01, intensity);
            return float4(_Color.rgb, saturate(_Color.a * intensity));
        #endif
    }

    ENDHLSL


    SubShader
    {
        Tags { "RenderPipeline" = "UniversalPipeline" }
        Cull Off
        ZWrite Off
        ZTest Always
        Lighting Off

        Pass
        {
            Name "ScreenProcess"

            HLSLPROGRAM
            /*
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5
            */
            //#pragma target 3.5
            #pragma multi_compile_instancing
            #pragma vertex VertexSimple
            #pragma fragment FragmentScreen
            ENDHLSL
        }

        Pass
        {
            Name "DrawOutline"
            Blend SrcAlpha OneMinusSrcAlpha


            HLSLPROGRAM
            /*
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5
            */
            //#pragma target 3.5
            #pragma multi_compile_instancing
            #pragma shader_feature_local _OUTLINE_AA
            #pragma shader_feature_local _OUTLINE_BLUR
            #pragma vertex VertexSimple
            #pragma fragment FragmentOutline

            ENDHLSL
        }
    }
}
