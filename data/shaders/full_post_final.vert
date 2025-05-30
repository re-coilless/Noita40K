#version 110

uniform vec2 camera_pos;
uniform vec2 camera_subpixel_offset;
uniform vec2 world_viewport_size;
uniform float camera_inv_zoom_ratio;

uniform vec2 tex_skylight_sample_delta;
uniform vec2 skylight_subpixel_offset;

uniform vec2 tex_fog_sample_delta;
uniform vec2 fog_subpixel_offset;


varying vec2 tex_coord_;
varying vec2 tex_coord_y_inverted_;
varying vec2 tex_coord_glow_;
varying vec2 world_pos;
varying vec2 tex_coord_skylight;
varying vec2 tex_coord_fogofwar;


void main()
{
    gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
	gl_FrontColor = gl_Color;
	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_TexCoord[1] = gl_MultiTexCoord1;

	tex_coord_ = gl_TexCoord[0].xy;
	tex_coord_y_inverted_ = gl_TexCoord[0].zw + vec2(camera_subpixel_offset.x, camera_subpixel_offset.y);
	tex_coord_glow_ = gl_TexCoord[1].xy;
    world_pos = camera_pos + tex_coord_y_inverted_ * world_viewport_size;
	
    vec2 sample_pos;
	
    // world coordinates -> skylight texture coordinates
	const float SKY_Y_OFFSET   = 55.0;
	const float SKY_PIXEL_SIZE = 64.0;
	const vec2  SKY_TEX_SIZE   = vec2( 32.0 );

	sample_pos = tex_coord_y_inverted_ * world_viewport_size;
	sample_pos.y += SKY_Y_OFFSET;
	sample_pos   += ( ( SKY_TEX_SIZE * SKY_PIXEL_SIZE ) - world_viewport_size.x ) / 2.0;
	sample_pos   += tex_skylight_sample_delta;
	sample_pos   /= SKY_PIXEL_SIZE * SKY_TEX_SIZE;
	sample_pos   += skylight_subpixel_offset;

	tex_coord_skylight = sample_pos;
	
	// world coordinates -> fog  texture coordinates
	const float FOG_PIXEL_SIZE = 32.0;
	float FOG_Y_OFFSET   = 90.0 * camera_inv_zoom_ratio;
	vec2  FOG_TEX_SIZE   = vec2( 64.0 ) * camera_inv_zoom_ratio;
	
	sample_pos = tex_coord_y_inverted_ * world_viewport_size;
	sample_pos.y += FOG_Y_OFFSET;
	sample_pos   += ( ( FOG_TEX_SIZE * FOG_PIXEL_SIZE ) - world_viewport_size.x ) / 2.0;
	sample_pos   += tex_fog_sample_delta;
	sample_pos   /= FOG_PIXEL_SIZE * FOG_TEX_SIZE;
	sample_pos   += fog_subpixel_offset; // subpixel correction
	
	tex_coord_fogofwar = sample_pos;
	
	//Noita40K stuff
	tex_coord_ += vec2(( mod( tex_coord_.y, 2.0 )*2 - 1 ), vec2( 0, 0 ));
	
	// float numLinesDown = floor(vertexCount / NUM_POINTS);
	// // produces 0,1, 1,2, 2,3, ...
	// float point = floor(mod(vertexId, NUM_POINTS) / 2.0) + mod(vertexId, 2.0);
	// // line count
	// float count = floor(vertexId / NUM_POINTS);

	// float u = point / NUM_SEGMENTS;  // 0 <-> 1 across line
	// float v = count / numLinesDown;  // 0 <-> 1 by line
	// float invV = 1.0 - v;

	// // Only use the left most 1/4th of the sound texture
	// // because there's no action on the right
	// float historyX = u * 0.25;
	// // Match each line to a specific row in the sound texture
	// float historyV = (v * numLinesDown + 0.5) / soundRes.y;
	// float snd = texture2D(sound, vec2(historyX, historyV)).a;

	// float x = u * 2.0 - 1.0;
	// float y = v * 2.0 - 1.0;
	// vec2 xy = vec2(
	  // x * mix(0.5, 1.0, invV),
	  // y + pow(snd, 5.0) * 1.0) / (v + 0.5);
	// gl_Position = vec4(xy * 0.5, 0, 1);

	// float hue = u;
	// float sat = invV;
	// float val = invV;
	// v_color = mix(vec4(hsv2rgb(vec3(hue, sat, val)), 1), background, v * v);
}