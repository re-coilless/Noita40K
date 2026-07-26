******[UNIFORMS]******

uniform vec4 refractor_effect;
uniform vec4 living_shadow;
uniform vec4 black_rage;
uniform vec4 life_eater_edge_effect;
uniform vec4 warpfire_edge_effect;
uniform vec4 chogorian_edge_effect;
uniform vec4 blessed_edge_effect;



******[FUNCTIONS]******

//http://gamedev.stackexchange.com/questions/59797/glsl-shader-change-hue-saturation-brightness
vec3 rgb2hsv( vec3 c )
{	
    vec4 K = vec4( 0.0, -1.0/3.0, 2.0/3.0, -1.0 );
    vec4 p = mix( vec4( c.bg, K.wz ), vec4( c.gb, K.xy ), step( c.b, c.g ));
    vec4 q = mix( vec4( p.xyw, c.r ), vec4( c.r, p.yzx ), step( p.x, c.r ));

    float d = q.x - min( q.w, q.y );
    float e = 1.0e-10;
    return vec3( abs( q.z + ( q.w - q.y )/( 6.0*d + e )), d/( q.x + e ), q.x );
}

vec3 hsv2rgb( vec3 c )
{
    vec4 K = vec4( 1.0, 2.0/3.0, 1.0/3.0, 3.0 );
    vec3 p = abs( fract( c.xxx + K.xyz )*6.0 - K.www );
    return c.z*mix( K.xxx, clamp( p - K.xxx, 0.0, 1.0 ), c.y );
}



******[WORLD]******

//shamelessly stolen from https://gist.github.com/detunized/1317940 and https://taylorpetrick.com/blog/post/dispersion-opengl
if( refractor_effect[2] > 0.0 )
{
	float R = 200.0;
	float h = refractor_effect[2]; //25
	float hr = R*sqrt( 1.0 - (( R - h )/R )*(( R - h )/R ));
	
	vec2 l_center = refractor_effect.xy*window_size;
	vec2 xy = gl_FragCoord.xy - l_center.xy;
	float dist = length( xy );
	
	vec2 new_xy = dist < hr ? xy*( R - h )/sqrt( R*R - dist*dist ) : xy;
	vec2 lense_offset = ( new_xy + l_center )/window_size;
	
	vec2 refractVecR = vec2( 0.0, 0.0 );
	vec2 refractVecG = vec2( 0.0, 0.0 );
	vec2 refractVecB = vec2( 0.0, 0.0 );
	if( dist < hr )
	{
		float iorOffset = sqrt( dist )*( 0.00015*refractor_effect[3]);
		
		vec2 view = vec2( 0.5, 0.5 );
		vec2 normal = vec2( 0.5, 0.5 );
		refractVecR = refract( view, normal, 1.0 - iorOffset );
		refractVecG = refract( view, normal, 1.0 );
		refractVecB = refract( view, normal, 1.0 + iorOffset );
	}
	
	color = vec3( 
		texture2D( tex_bg, lense_offset + refractVecR.xy ).r,
		texture2D( tex_bg, lense_offset + refractVecG.xy ).g,
		texture2D( tex_bg, lense_offset + refractVecB.xy ).b
	);
	color_fg = vec4(
		texture2D( tex_fg, lense_offset + refractVecR.xy ).r,
		texture2D( tex_fg, lense_offset + refractVecG.xy ).g,
		texture2D( tex_fg, lense_offset + refractVecB.xy ).b,
		texture2D( tex_fg, lense_offset + refractVecR.xy ).a
	);
}



******[OVERLAY]******

******[OUTPUT]******
