Shader "funnyland/chr/skin"
{
    Properties
    {
        _BaseColor ("Base Color", Color) = (1, 1, 1, 1)
        _BaseMap ("Base Map", 2D) = "white" { }
        _EmissionMap ("Emission Map", 2D) = "black" { }
        _SpecularAO ("Specular AO", Range(0.0, 1)) = 1
        _SkinShadowSampleBias ("SkinShadow Bias", Range(0.0, 1)) = 1
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" "IgnoreProjector" = "True" "ShaderModel" = "4.5" }
        LOD 300
        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode" = "UniversalForward" }
            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5
            #pragma vertex vert
            #pragma fragment frag

            #pragma multi_compile _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION



            #include "./PlayerShaderLib/PlayerSkinInput.hlsl"
            #include "./PlayerShaderLib/PlayerSkinShading.hlsl"
            ENDHLSL
        }
    }

    //CustomEditor "PlayerSkinShaderGUI"

}
