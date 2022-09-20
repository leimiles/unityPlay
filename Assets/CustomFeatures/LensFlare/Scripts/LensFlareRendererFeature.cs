using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class LensFlareRendererFeature : ScriptableRendererFeature {
    class LensFlarePass : ScriptableRenderPass {
        private Material _material;
        private Mesh _mesh;
        /*
        constructor for the pass
        */
        public LensFlarePass(Material material, Mesh mesh) {
            _material = material;
            _mesh = mesh;
        }
        /*
        called every frame, actual functionality for this render pass
        */
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData) {
            // a new command buffer with a given name
            CommandBuffer commandBuffer = CommandBufferPool.Get(name: "LensFlarePass");
            /*
            Camera camera = renderingData.cameraData.camera;
            commandBuffer.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
            Vector3 scale = new Vector3(1, camera.aspect, 1);
            foreach (VisibleLight visibleLight in renderingData.lightData.visibleLights) {
                Light light = visibleLight.light;
                Vector3 position = camera.WorldToViewportPoint(light.transform.position) * 2 - Vector3.one;
                position.z = 0;

            }
            */
            commandBuffer.DrawMesh(_mesh, Matrix4x4.identity, _material, 0, 0);
            context.ExecuteCommandBuffer(commandBuffer);
            CommandBufferPool.Release(commandBuffer);
        }
    }

    public Material material;
    public Mesh mesh;
    private LensFlarePass _lensFlarePass;

    /*
    called when feature loads the first time
    called when feature enable or disable
    called when inspector of feature is changed
    */
    public override void Create() {
        _lensFlarePass = new LensFlarePass(material, mesh);
    }

    /*
    called once a frame per camera
    */
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
        if (material != null && mesh != null) {
            renderer.EnqueuePass(_lensFlarePass);
        }
    }
}
