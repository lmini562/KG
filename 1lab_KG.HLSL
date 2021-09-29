Shader "Custom/1"
{
	Properties
	{
	_MainTex("Enhorn Texture", 2D) = "white" {}
	_Color("Tint", Color) = (1, 1, 1, 1)
	_MainBGTex("Background", 2D) = "white" {}
	_BGColor("Background Color", Color) = (0, 0, 0, 1)
	}
		SubShader
	{
	CGPROGRAM
	#pragma surface surf Standard fullForwardShadows
	#pragma target 3.0
	sampler2D _MainTex, _MainBGTex;
	fixed4 _Color, _BGColor;
	struct Input {
	float2 uv_MainTex, uv_MainBGTex;
	};
	void surf(Input i, inout SurfaceOutputStandard s) {
	fixed4 color = tex2D(_MainTex, i.uv_MainTex);
	fixed4 bg = tex2D(_MainBGTex, i.uv_MainTex);
	color *= _Color;
	bg *= _BGColor;
	s.Albedo = color.rgb * color.a + (1 - color.a) * bg.rgb;
	}
	ENDCG
	}
}
