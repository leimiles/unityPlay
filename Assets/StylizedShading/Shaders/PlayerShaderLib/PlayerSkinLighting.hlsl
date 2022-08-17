#ifndef PLAYERSKINLIGHTING_HLSL_INCLUDED
#define PLAYERSKINLIGHTING_HLSL_INCLUDED

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"


half4 GlobalIllumination_Skin(BRDFData brdfData, half3 bakedGI, half occlusion, float3 positionWS, half3 normalWS, half3 viewDirectionWS, half specularAO)
{
    half3 reflectVector = reflect(-viewDirectionWS, normalWS);
    half fresnelTerm = Pow4(1.0 - saturate(dot(normalWS, viewDirectionWS)));

    half3 indirectDiffuse = bakedGI * occlusion;
    half3 indirectSpecular = GlossyEnvironmentReflection(reflectVector, positionWS, brdfData.perceptualRoughness, occlusion) * specularAO;
    half3 color = EnvironmentBRDF(brdfData, indirectDiffuse, indirectSpecular, fresnelTerm);
    return half4(brdfData.grazingTerm, brdfData.grazingTerm, brdfData.grazingTerm, 1.0);
}

half4 SkinPBR(InputData inputData, SurfaceData surfaceData, half specularAO)
{
    BRDFData brdfData;
    InitializeBRDFData(surfaceData, brdfData);

    AmbientOcclusionFactor aoFactor = CreateAmbientOcclusionFactor(inputData.normalizedScreenSpaceUV, surfaceData.occlusion);
    LightingData lightingData = CreateLightingData(inputData, surfaceData);

    lightingData.giColor = GlobalIllumination_Skin(brdfData, inputData.bakedGI, 1.0, inputData.positionWS, inputData.normalWS, inputData.viewDirectionWS, specularAO);
    /*
    #ifdef _ADDITIONAL_LIGHTS
        lightingData.vertexLightingColor += inputData.vertexLighting * brdfData.diffuse;
    #endif
    */
    return half4(lightingData.giColor, 1);
    //return CalculateFinalColor(lightingData, surfaceData.alpha);

}

#endif