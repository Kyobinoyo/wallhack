// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Created by Kyobinoyo
Shader "Kyobinoyo/CubeOutline"
{
	Properties
	{
		_OutlineColor("Outline Color", Color) = (1,0,0,0)
		_Width("Width", Range( 0 , 0.95)) = 0.95
		_Height("Height", Range( 0 , 0.95)) = 0.95
		_DistortionNormalMap("Distortion Normal Map", 2D) = "bump" {}
		_DistStrengh("DistStrengh", Range( 0 , 1)) = 0.1
		_DisSpeed("Dis Speed", Range( 0 , 1)) = 0.5
		_Bloom("Bloom", Float) = 1
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Pass
		{
			ColorMask 0
			ZTest Equal
			ZWrite On
		}

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		ZTest Greater
		Stencil
		{
			Ref 1
		}
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _DistortionNormalMap;
		uniform float _DisSpeed;
		uniform float _DistStrengh;
		uniform float _Width;
		uniform float _Height;
		uniform float4 _OutlineColor;
		uniform float _Bloom;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (_DisSpeed).xx;
			float2 panner19 = ( _Time.y * temp_cast_0 + i.uv_texcoord);
			float2 appendResult10_g1 = (float2(_Width , _Height));
			float2 temp_output_11_0_g1 = ( abs( (( ( UnpackNormal( tex2D( _DistortionNormalMap, panner19 ) ) * ( _DistStrengh / 10.0 ) ) + float3( i.uv_texcoord ,  0.0 ) ).xy*2.0 + -1.0) ) - appendResult10_g1 );
			float2 break16_g1 = ( 1.0 - ( temp_output_11_0_g1 / fwidth( temp_output_11_0_g1 ) ) );
			float temp_output_7_0 = ( 1.0 - saturate( min( break16_g1.x , break16_g1.y ) ) );
			o.Emission = ( saturate( ( temp_output_7_0 * _OutlineColor ) ) * _Bloom ).rgb;
			o.Alpha = 1;
			float SquareMask31 = temp_output_7_0;
			clip( SquareMask31 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
0;453;1477;270;2683.34;268.2319;2.482265;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-2412.115,-417.067;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-2470.777,-279.0187;Inherit;False;Property;_DisSpeed;Dis Speed;5;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;23;-2369.36,-186.1904;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;19;-2147.942,-350.1563;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2074.406,-115.229;Inherit;False;Property;_DistStrengh;DistStrengh;4;0;Create;True;0;0;0;False;0;False;0.1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1905.585,-378.4459;Inherit;True;Property;_DistortionNormalMap;Distortion Normal Map;3;0;Create;True;0;0;0;False;0;False;-1;b8960a088bdbdad478c88078ffab9d8c;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;29;-1781.625,-108.9622;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1568.146,-129.5098;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1524.343,-334.8416;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1356.898,67.74459;Inherit;False;Property;_Height;Height;2;0;Create;True;0;0;0;False;0;False;0.95;0;0;0.95;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-1321.748,-293.775;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1356.898,-19.25542;Inherit;False;Property;_Width;Width;1;0;Create;True;0;0;0;False;0;False;0.95;0;0;0.95;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1;-1065.899,-1.255421;Inherit;True;Rectangle;-1;;1;6b23e0c975270fb4084c354b2c83366a;0;3;1;FLOAT2;0,0;False;2;FLOAT;0.5;False;3;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-827.724,257.411;Inherit;False;Property;_OutlineColor;Outline Color;0;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;7;-792.899,-4.255421;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-582.0168,132.0191;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-316.7881,240.3004;Inherit;False;Property;_Bloom;Bloom;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;10;-332.7739,3.788513;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;-577.7728,-11.21433;Inherit;False;SquareMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-47.10864,16.64249;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-18.42011,248.5006;Inherit;False;31;SquareMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;222.5682,-37.48822;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Kyobinoyo/CubeOutline;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;2;False;-1;False;0;False;-1;0;False;-1;True;5;Custom;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;True;1;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;7;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;24;0
WireConnection;19;2;21;0
WireConnection;19;1;23;0
WireConnection;18;1;19;0
WireConnection;29;0;26;0
WireConnection;25;0;18;0
WireConnection;25;1;29;0
WireConnection;27;0;25;0
WireConnection;27;1;28;0
WireConnection;1;1;27;0
WireConnection;1;2;3;0
WireConnection;1;3;4;0
WireConnection;7;0;1;0
WireConnection;9;0;7;0
WireConnection;9;1;8;0
WireConnection;10;0;9;0
WireConnection;31;0;7;0
WireConnection;12;0;10;0
WireConnection;12;1;11;0
WireConnection;0;2;12;0
WireConnection;0;10;32;0
ASEEND*/
//CHKSM=5C60902B1586CA522DFAB12ED7E6AC0A9703C31E