Shader "Custom/RemapShader" {
    Properties {
        _MainTex1 ("Texture 1", 2D) = "white" {}
        _MainTex2 ("Texture 2", 2D) = "white" {}
        _RemapRange ("Remap Range", Vector) = (0, 1, 0, 1)
        _RemapTarget ("Remap Target", Vector) = (0, 1, 0, 1)
    }
 
    SubShader {
        Tags { "Queue" = "Transparent" }
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
 
            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };
 
            sampler2D _MainTex1;
            sampler2D _MainTex2;
            float4 _RemapRange;
            float4 _RemapTarget;
 
            v2f vert (appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
 
            fixed4 frag (v2f i) : SV_Target {
                fixed4 color1 = tex2D(_MainTex1, i.uv);
                fixed4 color2 = tex2D(_MainTex2, i.uv);
                
                // Remap the colors
                float3 remappedColor = lerp(_RemapRange.xy, _RemapRange.zw, color2.rgb / color1.rgb);
                
                // Output the remapped color
                return fixed4(remappedColor, 1.0);
            }
            ENDCG
        }
    }
}
