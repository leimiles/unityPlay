using System.Collections;
using System.Collections.Generic;
using Unity.Profiling;
using UnityEngine;

namespace UnityEngine.Miles.Test {
    public class WaveCubes : MonoBehaviour {
        public GameObject cubeAchetype = null;
        [Range(10, 100)]
        public int xHalfCount = 40;
        [Range(10, 100)]
        public int zHalfCount = 40;

        private List<Transform> cubesList;

        static readonly ProfilerMarker<int> profilerMarker = new ProfilerMarker<int>("WaveCubes Update", "Objects Count");

        void Start() {
            cubesList = new List<Transform>();
            for (var z = -zHalfCount; z <= zHalfCount; z++) {
                for (var x = -xHalfCount; x < xHalfCount; x++) {
                    var cube = Instantiate(cubeAchetype);
                    cube.transform.position = new Vector3(x * 1.1f, 0, z * 1.1f);
                    cubesList.Add(cube.transform);
                }
            }
        }

        void Update() {
            using (profilerMarker.Auto(cubesList.Count)) {
                WaveTransform();
            }
        }

        void WaveTransform() {
            for (var i = 0; i < cubesList.Count; i++) {
                var distance = Vector3.Distance(cubesList[i].position, Vector3.zero);
                cubesList[i].localPosition += Vector3.up * Mathf.Sin(Time.time * 3.0f + distance * 0.2f);
            }
        }
    }
}
