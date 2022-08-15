#ifndef PLAYERSHADING_HLSL_INCLUDED
#define PLAYERSHADING_HLSL_INCLUDED

#include "PlayerSkinLighting.hlsl"

struct Attributes
{
    float4 positionOS : POSITION;
    float2 uv0 : TEXCOORD0;
    half3 normalOS : NORMAL;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings
{
    float4 positionCS : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float3 positionWS : TEXCOORD1;
    half3 normalWS : TEXCOORD2;
    half3 viewDirWS : TEXCOORD3;
    float4 shadowCoord : TEXCOORD4;
    half4 vertexLightAndFog : TEXCOORD5;
    half3 sh : COLOR0;
};

Varyings vert(Attributes v)
{
    Varyings o = (Varyings)0;
    // position
    VertexPositionInputs vpi = GetVertexPositionInputs(v.positionOS.xyz);
    o.positionCS = vpi.positionCS;
    o.positionWS = vpi.positionWS;
    // uv
    o.uv0 = TRANSFORM_TEX(v.uv0, _BaseMap);
    // normal
    VertexNormalInputs vni = GetVertexNormalInputs(v.normalOS);
    o.normalWS = vni.normalWS;
    // view
    o.viewDirWS = SafeNormalize(GetWorldSpaceNormalizeViewDir(vpi.positionWS));
    // shadow
    //o.shadowCoord = TransformWorldToShadowCoord(vpi.positionWS);
    vpi.positionWS += vni.normalWS.xyz * _SkinShadowSampleBias;
    o.shadowCoord = GetShadowCoord(vpi);
    // fog
    o.vertexLightAndFog.rgb = VertexLighting(vpi.positionWS, vni.normalWS);
    o.vertexLightAndFog.w = ComputeFogFactor(vpi.positionCS.z);
    // sh
    o.sh = SampleSH(vni.normalWS);

    return o;
}

void InitializeInputData(Varyings input, out InputData inputData)
{
    inputData = (InputData)0;
    inputData.positionWS = input.positionWS;
    inputData.positionCS = input.positionCS;
    inputData.normalWS = input.normalWS;
    inputData.viewDirectionWS = input.viewDirWS;
    inputData.shadowCoord = input.shadowCoord;
    inputData.fogCoord = input.vertexLightAndFog.w;
    inputData.vertexLighting = input.vertexLightAndFog.rgb;
    inputData.bakedGI = input.sh;
    inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);;
    inputData.shadowMask = 0;
    inputData.tangentToWorld = 0;
}

void InitializeSkinSurfaceData(float2 uv, out SurfaceData surfaceData)
{
    surfaceData = (SurfaceData)0;
    surfaceData.albedo = SampleAlbedoAlpha(uv, TEXTURE2D_ARGS(_BaseMap, sampler_BaseMap)) * _BaseColor;
}

half4 frag(Varyings input) : SV_Target
{
    half4 baseColor = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.uv0);
    InputData inputData;
    InitializeInputData(input, inputData);
    SurfaceData surfaceData;
    InitializeSkinSurfaceData(input.uv0, surfaceData);
    #ifdef _ADDITIONAL_LIGHTS_VERTEX
        return half4(1.0, 0.0, 0.0, 1.0);
    #endif
    //return half4(inputdata.normalizedScreenSpaceUV.rg, 1, 1);
    //return half4(inputdata.vertexLighting, 1);
    //return half4(surfaceData.albedo, 1.0h);
    //AmbientOcclusionFactor ao = CreateAmbientOcclusionFactor(inputdata.normalizedScreenSpaceUV, 0.5);
    //return half4(ao.indirectAmbientOcclusion, ao.indirectAmbientOcclusion, ao.indirectAmbientOcclusion, 1.0) * baseColor;
    half4 color = SkinPBR(inputData, surfaceData);
    return color;
}
#endif