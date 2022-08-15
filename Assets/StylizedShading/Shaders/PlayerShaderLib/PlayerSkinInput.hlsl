#ifndef PLAYERINPUT_HLSL_INCLUDED
#define PLAYERINPUT_HLSL_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"

CBUFFER_START(UnityPerMaterial)
    half4 _BaseColor;
    float4 _BaseMap_ST;
    float4 _EmissionMap_ST;
CBUFFER_END

// no need, declared in surfaceinput.hlsl
//TEXTURE2D(_BaseMap);       SAMPLER(sampler_BaseMap);
//TEXTURE2D(_EmissionMap);       SAMPLER(sampler_EmissionMap);

half _SkinShadowSampleBias = 1.0h;

#endif