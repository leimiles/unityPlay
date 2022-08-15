#ifndef PLAYERSKINLIGHTING_HLSL_INCLUDED
#define PLAYERSKINLIGHTING_HLSL_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

half4 SkinPBR(InputData inputData, SurfaceData surfaceData)
{
    #ifdef _ADDITIONAL_LIGHTS_VERTEX
        lightingData.vertexLightingColor += inputData.vertexLighting * brdfData.diffuse;
    #endif
    LightingData lightingData = CreateLightingData(inputData, surfaceData);
    //lightingData.additionalLightsColor
    return half4(lightingData.vertexLightingColor, 1);
    //return half4(lightingData.additionalLightsColor, 1.0h);
    //return CalculateFinalColor(lightingData, 1.0h);
}

#endif