Shader "Converted/Template"
{
    Properties
    {
        [Header(General)]
        _MainTex ("iChannel0", 2D) = "white" {}
        _SecondTex ("iChannel1", 2D) = "white" {}
        _ThirdTex ("iChannel2", 2D) = "white" {}
        _FourthTex ("iChannel3", 2D) = "white" {}
        _Mouse ("Mouse", Vector) = (0.5, 0.5, 0.5, 0.5)
        [ToggleUI] _GammaCorrect ("Gamma Correction", Float) = 1
        _Resolution ("Resolution (Change if AA is bad)", Range(1, 1024)) = 1

        [Header(Raymarching)]
        [ToggleUI] _WorldSpace ("World Space Marching", Float) = 0
        _Offset ("Offset (W=Scale)", Vector) = (0, 0, 0, 1)

        [Header(Extracted)]
        ATOMIC_COUNTER_ARRAY_STRIDE ("ATOMIC_COUNTER_ARRAY_STRIDE", Float) = 4
        ATOMIC_COUNTER_ARRAY_STRIDE ("ATOMIC_COUNTER_ARRAY_STRIDE", Float) = 4

    }
    SubShader
    {
        Pass
        {
            Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 ro_w : TEXCOORD1;
                float3 hitPos_w : TEXCOORD2;
            };

            // Built-in properties
            sampler2D _MainTex;   float4 _MainTex_TexelSize;
            sampler2D _SecondTex; float4 _SecondTex_TexelSize;
            sampler2D _ThirdTex;  float4 _ThirdTex_TexelSize;
            sampler2D _FourthTex; float4 _FourthTex_TexelSize;
            float4 _Mouse;
            float _GammaCorrect;
            float _Resolution;
            float _WorldSpace;
            float4 _Offset;

            // GLSL Compatability macros
            #define glsl_mod(x,y) (((x)-(y)*floor((x)/(y))))
            #define texelFetch(ch, uv, lod) tex2Dlod(ch, float4((uv).xy * ch##_TexelSize.xy + ch##_TexelSize.xy * 0.5, 0, lod))
            #define textureLod(ch, uv, lod) tex2Dlod(ch, float4(uv, 0, lod))
            #define iResolution float3(_Resolution, _Resolution, _Resolution)
            #define iFrame (floor(_Time.y / 60))
            #define iChannelTime float4(_Time.y, _Time.y, _Time.y, _Time.y)
            #define iDate float4(2020, 6, 18, 30)
            #define iSampleRate (44100)
            #define iChannelResolution float4x4(                      \
                _MainTex_TexelSize.z,   _MainTex_TexelSize.w,   0, 0, \
                _SecondTex_TexelSize.z, _SecondTex_TexelSize.w, 0, 0, \
                _ThirdTex_TexelSize.z,  _ThirdTex_TexelSize.w,  0, 0, \
                _FourthTex_TexelSize.z, _FourthTex_TexelSize.w, 0, 0)

            // Global access to uv data
            static v2f vertex_output;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv =  v.uv;

                if (_WorldSpace)
                {
                    o.ro_w = _WorldSpaceCameraPos;
                    o.hitPos_w = mul(unity_ObjectToWorld, v.vertex);
                }
                else
                {
                    o.ro_w = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos, 1));
                    o.hitPos_w = v.vertex;
                }

                return o;
            }

#pragma warning( disable: 3556 3571 )
            struct _MetaBall 
            {
                float _r;
                float2 _pos;
                float3 _col;
            };
#pragma pack_matrix(row_major)
            struct rm__MetaBall 
            {
                float _r;
                float2 _pos;
                float3 _col;
            };
#pragma pack_matrix(column_major)
            struct std__MetaBall 
            {
                float _r;
                float pad_0;
                float2 _pos;
                float3 _col;
            };
#pragma pack_matrix(row_major)
            struct std_rm__MetaBall 
            {
                float _r;
                float pad_1;
                float2 _pos;
                float3 _col;
            };
#pragma pack_matrix(column_major)
            struct std_fp__MetaBall 
            {
                float _r;
                float pad_2;
                float2 _pos;
                float3 _col;
                float pad_3;
            };
#pragma pack_matrix(row_major)
            struct std_rm_fp__MetaBall 
            {
                float _r;
                float pad_4;
                float2 _pos;
                float3 _col;
                float pad_5;
            };
#pragma pack_matrix(column_major)
            float2 vec2_ctor(float x0, float x1)
            {
                return float2(x0, x1);
            }

            float4 vec4_ctor(float3 x0, float x1)
            {
                return float4(x0, x1);
            }

            uniform;
            ENDCG
        }
    }
}
