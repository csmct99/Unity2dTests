﻿Shader "Unlit/Hologram"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_TintColor ("Tint", Color) = (1,1,1,1)
		_Alpha ("Alpha", Range(0.0, 1.0)) = 0.25
		_CutoutThresh ("Threshold", Range(0.0, 1.0)) = 0.5
	}
	SubShader
	{
		Tags {"Queue" = "Transparent" "RenderType"="Transparent" } // Or Opaque
		LOD 100

		ZWrite Off //Dont write to depth buffer. Transparent = off, solid = on
		Blend SrcAlpha OneMinusSrcAlpha //Blend using alpha channel

		Pass
		{
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
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _TintColor;
			float _Alpha;
			float _CutoutThresh;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv) + _TintColor;
				col.a = _Alpha;

				clip(col.b - _CutoutThresh);

				return col;
			}
			ENDCG
		}
	}
}
