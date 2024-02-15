using UnityEngine;

namespace Dynamic_Mesh
{
    public class QuadMesh : MonoBehaviour
    {
        [SerializeField] private MeshFilter meshFilter;
        
        public void Start()
        {
            Mesh mesh = new Mesh();
            
            // Координаты вершин
            Vector3[] vertices = new Vector3[4];
            vertices[0] = new Vector3(0, 0);
            vertices[1] = new Vector3(0, 100);
            vertices[2] = new Vector3(100, 100);
            vertices[3] = new Vector3(100, 0);

            
            // индексы вершин - откуда куда идет линия (по часовой)
            int[] quad = new int[6];
            quad[0] = 0;
            quad[1] = 1;
            quad[2] = 2;

            quad[3] = 0;
            quad[4] = 2;
            quad[5] = 3;
            
            // Координаты прорисовки материала
            Vector2[] uv = new Vector2[4];
            uv[0] = new Vector2(0,0); 
            uv[1] = new Vector2(0, 1); 
            uv[2] = new Vector2(1, 1);
            uv[3] = new Vector2(1, 0);
            

            mesh.vertices = vertices;
            mesh.uv = uv;
            mesh.triangles = quad;

            meshFilter.mesh = mesh;
        }
    }
}
