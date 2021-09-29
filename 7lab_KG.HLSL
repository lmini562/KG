Shader "Unlit/GradientShade"
{
		Properties
		{
		   _Color("Color", Color) = (0,0,0,1)
		   _SecondaryColor("SecondaryColor", Color) = (1,1,1,1)
	       _ColorA("Color A", Range(0, 1)) = 0
		   _ColorB("Color B", Range(0, 1)) = 1
		}
			SubShader
		{
		   Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
		Pass
			{
 		       CGPROGRAM

		       #include "UnityCG.cginc"
		       #pragma vertex vert
		       #pragma fragment frag

		       float4 _Color;
		       float4 _SecondaryColor;
		       float _ColorA;
		       float _ColorB;
		       struct appdata 
			   {
		           float4 vertex : POSITION;
		           float3 normal : NORMAL;
		           float2 uv0 : TEXCOORD0;
		       };
		    struct v2f 
		    {
		        float4 position : SV_POSITION;
		        float3 normal : TEXCOORD0;
		        float2 uv : TEXCOORD1;
		    };
		    v2f vert(appdata v) 
		    {
		       v2f o;
		       o.position = UnityObjectToClipPos(v.vertex);
		       o.normal = UnityObjectToWorldNormal(v.normal);
		       o.uv = v.uv0;
		       return o;
		    }
			
		    float InverseLerp(float a, float b, float c) 
			{
		       return (c - a) / (b - a);
		    }

		    float4 frag(v2f i) : SV_TARGET
			{
		       float t = InverseLerp(_ColorA, _ColorB, i.uv.x);
		       float4 col = lerp(_Color, _SecondaryColor, t);
		       return col;
		    }
		ENDCG
		}
		}
}
