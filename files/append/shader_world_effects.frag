// ============================================================================================================
// Noita40K stuff (inworld effects) ===========================================================================
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

#ifdef TRIPPY
	// drunk doublevision