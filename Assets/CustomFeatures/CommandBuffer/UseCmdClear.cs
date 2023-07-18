using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;


// camera commandbuffer runs only in play mode
[RequireComponent(typeof(Camera))]
[DisallowMultipleComponent]
public class UseCmdClear : MonoBehaviour {
    public enum ClearType {
        All,
        ColorAndStencil
    }
    public ClearType clearType;
    void Start() {
        Camera camera = GetComponent<Camera>();
        // compare to "new CommandBuffer()", this won't generate "no name commandbuffer tag"
        CommandBuffer commandBuffer = CommandBufferPool.Get();
        switch (clearType) {
            case ClearType.All:
                commandBuffer.ClearRenderTarget(RTClearFlags.All, Color.black, 1.0f, 0xF0);
                break;
            case ClearType.ColorAndStencil:
                commandBuffer.ClearRenderTarget(RTClearFlags.ColorStencil, Color.black, 1.0f, 0xF0);
                break;
            default:
                break;
        }
        // still only after or before skybox events will work
        camera.AddCommandBuffer(CameraEvent.AfterSkybox, commandBuffer);
    }
}
