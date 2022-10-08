using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;


// camera commandbuffer runs only in play mode
[RequireComponent(typeof(Camera))]
[DisallowMultipleComponent]
public class UseCmdDraw : MonoBehaviour {
    public Mesh mesh;
    public Material material;

    void Start() {
        Camera camera = GetComponent<Camera>();
        CommandBuffer commandBuffer = new CommandBuffer();
        commandBuffer.DrawMesh(mesh, Matrix4x4.identity, material, 0, 0);
        // not working when use other camera events
        camera.AddCommandBuffer(CameraEvent.AfterSkybox, commandBuffer);
    }
}
