using UnityEngine;

namespace Dynamic_Mesh
{
    public class PolygonMesh : MonoBehaviour
    {
        [SerializeField] private MeshFilter meshFilter;
        
        
        public void Start()
        {
            Mesh mesh = new Mesh();
            
            // Координаты точек
            Vector3[] vertices = new Vector3[3];
            vertices[0] = new Vector3(0, 0);
            vertices[1] = new Vector3(0, 100);
            vertices[2] = new Vector3(100, 100);

            
            // индексы откуда куда идет линия
            int[] polygon = new int[3];
            polygon[0] = 0;
            polygon[1] = 1;
            polygon[2] = 2;
            
            // Координаты прорисовки материала
            Vector2[] uv = new Vector2[3];
            uv[0] = new Vector2(0,0); 
            uv[1] = new Vector2(0, 1); 
            uv[2] = new Vector2(1, 1); 
            

            mesh.vertices = vertices;
            mesh.uv = uv;
            mesh.triangles = polygon;

            meshFilter.mesh = mesh;
        }
    }
}
