Shader "funnyland/chr/player"
{
    Properties
    {
        _BaseMap ("Base Map", 2D) = "white" { }
        _EmissionMap ("Emission Map", 2D) = "black" {}
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

            #include "./ShaderLibrary/PlayerInput.hlsl"
            #include "./ShaderLibrary/PlayerShading.hlsl"
            ENDHLSL
        }
    }
}
