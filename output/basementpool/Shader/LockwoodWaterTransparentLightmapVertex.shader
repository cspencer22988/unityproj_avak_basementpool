Shader "Lockwood/WaterTransparentLightmapVertex" {
	Properties {
		_BumpMap ("Normals ", 2D) = "bump" {}
		_CubeMap ("Environment ", Cube) = "white" {}
		_BumpTiling ("Bump Tiling", Vector) = (1,1,-2,3)
		_BumpDirection ("Bump Direction & Speed", Vector) = (1,1,-1,1)
		_DistortParam ("Wave Distortion", Float) = 1
		_BaseColor ("Base color", Vector) = (0.54,0.95,0.99,0.5)
		_ReflectionColor ("Reflection color", Vector) = (0.54,0.95,0.99,0.5)
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			Cull Off
			GpuProgramID 15633
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _BumpTiling;
					uniform highp vec4 _BumpDirection;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  mediump vec3 tmpvar_2;
					  mediump vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  tmpvar_3 = ((tmpvar_5.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
					  tmpvar_2 = (tmpvar_5 - _WorldSpaceCameraPos);
					  tmpvar_4 = tmpvar_1;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_COLOR0 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform highp vec4 _BaseColor;
					uniform highp vec4 _ReflectionColor;
					uniform highp float _DistortParam;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec4 baseColor_1;
					  mediump vec3 reflectVector_2;
					  mediump vec3 worldNormal_3;
					  mediump vec3 bump_4;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = (((texture2D (_BumpMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0) + ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0));
					  bump_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (((bump_4.xxy * _DistortParam) * vec3(1.0, 0.0, 1.0)) + vec3(0.0, 1.0, 0.0));
					  worldNormal_3 = tmpvar_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = normalize(worldNormal_3);
					  worldNormal_3 = tmpvar_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = normalize(xlv_TEXCOORD0);
					  mediump vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_7, tmpvar_8)
					   * tmpvar_7)));
					  reflectVector_2.yz = tmpvar_9.yz;
					  reflectVector_2.x = -(tmpvar_9.x);
					  baseColor_1 = _BaseColor;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
					  lowp vec4 color_11;
					  color_11 = tmpvar_10;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = textureCube (_CubeMap, reflectVector_2);
					  baseColor_1.xyz = ((baseColor_1.xyz * tmpvar_12.xyz) * (unity_Lightmap_HDR.x * color_11.xyz));
					  baseColor_1.w = _ReflectionColor.w;
					  baseColor_1.w = (baseColor_1.w * xlv_COLOR0.w);
					  gl_FragData[0] = baseColor_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _BumpTiling;
					uniform highp vec4 _BumpDirection;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  mediump vec3 tmpvar_2;
					  mediump vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  tmpvar_3 = ((tmpvar_5.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
					  tmpvar_2 = (tmpvar_5 - _WorldSpaceCameraPos);
					  tmpvar_4 = tmpvar_1;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_COLOR0 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform highp vec4 _BaseColor;
					uniform highp vec4 _ReflectionColor;
					uniform highp float _DistortParam;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec4 baseColor_1;
					  mediump vec3 reflectVector_2;
					  mediump vec3 worldNormal_3;
					  mediump vec3 bump_4;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = (((texture2D (_BumpMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0) + ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0));
					  bump_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (((bump_4.xxy * _DistortParam) * vec3(1.0, 0.0, 1.0)) + vec3(0.0, 1.0, 0.0));
					  worldNormal_3 = tmpvar_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = normalize(worldNormal_3);
					  worldNormal_3 = tmpvar_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = normalize(xlv_TEXCOORD0);
					  mediump vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_7, tmpvar_8)
					   * tmpvar_7)));
					  reflectVector_2.yz = tmpvar_9.yz;
					  reflectVector_2.x = -(tmpvar_9.x);
					  baseColor_1 = _BaseColor;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
					  lowp vec4 color_11;
					  color_11 = tmpvar_10;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = textureCube (_CubeMap, reflectVector_2);
					  baseColor_1.xyz = ((baseColor_1.xyz * tmpvar_12.xyz) * (unity_Lightmap_HDR.x * color_11.xyz));
					  baseColor_1.w = _ReflectionColor.w;
					  baseColor_1.w = (baseColor_1.w * xlv_COLOR0.w);
					  gl_FragData[0] = baseColor_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _BumpTiling;
					uniform highp vec4 _BumpDirection;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  mediump vec3 tmpvar_2;
					  mediump vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
					  tmpvar_3 = ((tmpvar_5.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
					  tmpvar_2 = (tmpvar_5 - _WorldSpaceCameraPos);
					  tmpvar_4 = tmpvar_1;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_COLOR0 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform highp vec4 _BaseColor;
					uniform highp vec4 _ReflectionColor;
					uniform highp float _DistortParam;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec4 baseColor_1;
					  mediump vec3 reflectVector_2;
					  mediump vec3 worldNormal_3;
					  mediump vec3 bump_4;
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = (((texture2D (_BumpMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0) + ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0));
					  bump_4 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (((bump_4.xxy * _DistortParam) * vec3(1.0, 0.0, 1.0)) + vec3(0.0, 1.0, 0.0));
					  worldNormal_3 = tmpvar_6;
					  mediump vec3 tmpvar_7;
					  tmpvar_7 = normalize(worldNormal_3);
					  worldNormal_3 = tmpvar_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = normalize(xlv_TEXCOORD0);
					  mediump vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_7, tmpvar_8)
					   * tmpvar_7)));
					  reflectVector_2.yz = tmpvar_9.yz;
					  reflectVector_2.x = -(tmpvar_9.x);
					  baseColor_1 = _BaseColor;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
					  lowp vec4 color_11;
					  color_11 = tmpvar_10;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = textureCube (_CubeMap, reflectVector_2);
					  baseColor_1.xyz = ((baseColor_1.xyz * tmpvar_12.xyz) * (unity_Lightmap_HDR.x * color_11.xyz));
					  baseColor_1.w = _ReflectionColor.w;
					  baseColor_1.w = (baseColor_1.w * xlv_COLOR0.w);
					  gl_FragData[0] = baseColor_1;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _BumpTiling;
					uniform 	vec4 _BumpDirection;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD1;
					in mediump vec4 in_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = _Time.xxxx * _BumpDirection + u_xlat0.xzxz;
					    u_xlat0 = u_xlat0 * _BumpTiling;
					    vs_TEXCOORD1 = u_xlat0;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform 	vec4 _BaseColor;
					uniform 	vec4 _ReflectionColor;
					uniform 	float _DistortParam;
					uniform lowp sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform mediump sampler2D unity_Lightmap;
					in mediump vec3 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_1.xyz = u_xlat10_0.xxy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.zw).xy;
					    u_xlat16_1.xyz = u_xlat10_0.xxy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_DistortParam);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vec3(0.0, 1.0, 0.0);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
					    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
					    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_2.xyz = vec3(u_xlat16_16) * vs_TEXCOORD0.xyz;
					    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
					    u_xlat16_0.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_16)) + u_xlat16_2.xyz;
					    u_xlat16_0.w = (-u_xlat16_0.x);
					    u_xlat10_3.xyz = texture(_CubeMap, u_xlat16_0.wyz).xyz;
					    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz * _BaseColor.xyz;
					    u_xlat0.w = vs_COLOR0.w * _ReflectionColor.w;
					    SV_Target0 = u_xlat0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _BumpTiling;
					uniform 	vec4 _BumpDirection;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD1;
					in mediump vec4 in_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = _Time.xxxx * _BumpDirection + u_xlat0.xzxz;
					    u_xlat0 = u_xlat0 * _BumpTiling;
					    vs_TEXCOORD1 = u_xlat0;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform 	vec4 _BaseColor;
					uniform 	vec4 _ReflectionColor;
					uniform 	float _DistortParam;
					uniform lowp sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform mediump sampler2D unity_Lightmap;
					in mediump vec3 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_1.xyz = u_xlat10_0.xxy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.zw).xy;
					    u_xlat16_1.xyz = u_xlat10_0.xxy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_DistortParam);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vec3(0.0, 1.0, 0.0);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
					    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
					    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_2.xyz = vec3(u_xlat16_16) * vs_TEXCOORD0.xyz;
					    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
					    u_xlat16_0.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_16)) + u_xlat16_2.xyz;
					    u_xlat16_0.w = (-u_xlat16_0.x);
					    u_xlat10_3.xyz = texture(_CubeMap, u_xlat16_0.wyz).xyz;
					    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz * _BaseColor.xyz;
					    u_xlat0.w = vs_COLOR0.w * _ReflectionColor.w;
					    SV_Target0 = u_xlat0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _BumpTiling;
					uniform 	vec4 _BumpDirection;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD1;
					in mediump vec4 in_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					out mediump vec4 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat0 = _Time.xxxx * _BumpDirection + u_xlat0.xzxz;
					    u_xlat0 = u_xlat0 * _BumpTiling;
					    vs_TEXCOORD1 = u_xlat0;
					    vs_TEXCOORD0.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform 	vec4 _BaseColor;
					uniform 	vec4 _ReflectionColor;
					uniform 	float _DistortParam;
					uniform lowp sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform mediump sampler2D unity_Lightmap;
					in mediump vec3 vs_TEXCOORD0;
					in mediump vec4 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_1.xyz = u_xlat10_0.xxy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.zw).xy;
					    u_xlat16_1.xyz = u_xlat10_0.xxy * vec3(2.0, 2.0, 2.0) + u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_DistortParam);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.0, 0.0, 1.0) + vec3(0.0, 1.0, 0.0);
					    u_xlat16_1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
					    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx;
					    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat16_16 = inversesqrt(u_xlat16_16);
					    u_xlat16_2.xyz = vec3(u_xlat16_16) * vs_TEXCOORD0.xyz;
					    u_xlat16_16 = dot(u_xlat16_2.xyz, u_xlat16_1.xyz);
					    u_xlat16_16 = u_xlat16_16 + u_xlat16_16;
					    u_xlat16_0.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_16)) + u_xlat16_2.xyz;
					    u_xlat16_0.w = (-u_xlat16_0.x);
					    u_xlat10_3.xyz = texture(_CubeMap, u_xlat16_0.wyz).xyz;
					    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat10_3.xyz;
					    u_xlat0.xyz = u_xlat16_3.xyz * _BaseColor.xyz;
					    u_xlat0.w = vs_COLOR0.w * _ReflectionColor.w;
					    SV_Target0 = u_xlat0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
			}
		}
		Pass {
			Name "META"
			Tags { "LIGHTMODE" = "META" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Cull Off
			GpuProgramID 90266
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp vec4 tmpvar_2;
					  highp vec4 vertex_3;
					  vertex_3 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_4;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_4 = 0.0001;
					    } else {
					      tmpvar_4 = 0.0;
					    };
					    vertex_3.z = tmpvar_4;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_5;
					    if ((vertex_3.z > 0.0)) {
					      tmpvar_5 = 0.0001;
					    } else {
					      tmpvar_5 = 0.0;
					    };
					    vertex_3.z = tmpvar_5;
					  };
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = vertex_3.xyz;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _BaseColor;
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tex_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_1.w = tmpvar_4.w;
					  tex_1.xyz = (tmpvar_4.xyz * _BaseColor.xyz);
					  tmpvar_2 = tex_1.xyz;
					  mediump vec4 res_5;
					  res_5 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = tmpvar_2;
					    res_5.w = tmpvar_6.w;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_5.xyz = tmpvar_7;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_8;
					    if (bool(unity_UseLinearSpace)) {
					      emission_8 = tmpvar_3;
					    } else {
					      emission_8 = (tmpvar_3 * ((tmpvar_3 * 
					        ((tmpvar_3 * 0.305306) + 0.6821711)
					      ) + 0.01252288));
					    };
					    mediump vec4 tmpvar_9;
					    tmpvar_9.w = 1.0;
					    tmpvar_9.xyz = emission_8;
					    res_5 = tmpvar_9;
					  };
					  gl_FragData[0] = res_5;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp vec4 tmpvar_2;
					  highp vec4 vertex_3;
					  vertex_3 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_4;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_4 = 0.0001;
					    } else {
					      tmpvar_4 = 0.0;
					    };
					    vertex_3.z = tmpvar_4;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_5;
					    if ((vertex_3.z > 0.0)) {
					      tmpvar_5 = 0.0001;
					    } else {
					      tmpvar_5 = 0.0;
					    };
					    vertex_3.z = tmpvar_5;
					  };
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = vertex_3.xyz;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _BaseColor;
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tex_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_1.w = tmpvar_4.w;
					  tex_1.xyz = (tmpvar_4.xyz * _BaseColor.xyz);
					  tmpvar_2 = tex_1.xyz;
					  mediump vec4 res_5;
					  res_5 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = tmpvar_2;
					    res_5.w = tmpvar_6.w;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_5.xyz = tmpvar_7;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_8;
					    if (bool(unity_UseLinearSpace)) {
					      emission_8 = tmpvar_3;
					    } else {
					      emission_8 = (tmpvar_3 * ((tmpvar_3 * 
					        ((tmpvar_3 * 0.305306) + 0.6821711)
					      ) + 0.01252288));
					    };
					    mediump vec4 tmpvar_9;
					    tmpvar_9.w = 1.0;
					    tmpvar_9.xyz = emission_8;
					    res_5 = tmpvar_9;
					  };
					  gl_FragData[0] = res_5;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  highp vec4 tmpvar_2;
					  highp vec4 vertex_3;
					  vertex_3 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_4;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_4 = 0.0001;
					    } else {
					      tmpvar_4 = 0.0;
					    };
					    vertex_3.z = tmpvar_4;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_5;
					    if ((vertex_3.z > 0.0)) {
					      tmpvar_5 = 0.0001;
					    } else {
					      tmpvar_5 = 0.0;
					    };
					    vertex_3.z = tmpvar_5;
					  };
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = vertex_3.xyz;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _BaseColor;
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tex_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_1.w = tmpvar_4.w;
					  tex_1.xyz = (tmpvar_4.xyz * _BaseColor.xyz);
					  tmpvar_2 = tex_1.xyz;
					  mediump vec4 res_5;
					  res_5 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = tmpvar_2;
					    res_5.w = tmpvar_6.w;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_5.xyz = tmpvar_7;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_8;
					    if (bool(unity_UseLinearSpace)) {
					      emission_8 = tmpvar_3;
					    } else {
					      emission_8 = (tmpvar_3 * ((tmpvar_3 * 
					        ((tmpvar_3 * 0.305306) + 0.6821711)
					      ) + 0.01252288));
					    };
					    mediump vec4 tmpvar_9;
					    tmpvar_9.w = 1.0;
					    tmpvar_9.xyz = emission_8;
					    res_5 = tmpvar_9;
					  };
					  gl_FragData[0] = res_5;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 unity_DynamicLightmapST;
					uniform 	bvec4 unity_MetaVertexControl;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					in highp vec4 in_TEXCOORD2;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb6;
					void main()
					{
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0<in_POSITION0.z);
					#else
					    u_xlatb0 = 0.0<in_POSITION0.z;
					#endif
					    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
					    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb6 = 0.0<u_xlat0.z;
					#endif
					    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
					    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _BaseColor;
					uniform 	bvec4 unity_MetaFragmentControl;
					uniform 	float unity_OneOverOutputBoost;
					uniform 	float unity_MaxOutputValue;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					float u_xlat3;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _BaseColor.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat3 = unity_OneOverOutputBoost;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
					#else
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat3);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
					    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
					    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
					    SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 unity_DynamicLightmapST;
					uniform 	bvec4 unity_MetaVertexControl;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					in highp vec4 in_TEXCOORD2;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb6;
					void main()
					{
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0<in_POSITION0.z);
					#else
					    u_xlatb0 = 0.0<in_POSITION0.z;
					#endif
					    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
					    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb6 = 0.0<u_xlat0.z;
					#endif
					    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
					    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _BaseColor;
					uniform 	bvec4 unity_MetaFragmentControl;
					uniform 	float unity_OneOverOutputBoost;
					uniform 	float unity_MaxOutputValue;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					float u_xlat3;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _BaseColor.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat3 = unity_OneOverOutputBoost;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
					#else
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat3);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
					    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
					    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
					    SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 unity_DynamicLightmapST;
					uniform 	bvec4 unity_MetaVertexControl;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					in highp vec4 in_TEXCOORD2;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb6;
					void main()
					{
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.0<in_POSITION0.z);
					#else
					    u_xlatb0 = 0.0<in_POSITION0.z;
					#endif
					    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
					    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(0.0<u_xlat0.z);
					#else
					    u_xlatb6 = 0.0<u_xlat0.z;
					#endif
					    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
					    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _BaseColor;
					uniform 	bvec4 unity_MetaFragmentControl;
					uniform 	float unity_OneOverOutputBoost;
					uniform 	float unity_MaxOutputValue;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					float u_xlat3;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _BaseColor.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat3 = unity_OneOverOutputBoost;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
					#else
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat3);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
					    u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
					    u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
					    SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
			}
		}
	}
	Fallback "Lockwood/Diffuse"
}