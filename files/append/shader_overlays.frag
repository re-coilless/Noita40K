// ============================================================================================================
// Noita40K stuff (overlays) ==================================================================================
	if( living_shadow[0] > 0.0 )
	{
		vec3 color_hsv = rgb2hsv( color );
		if( !( abs( color.r - color.g ) < 0.01 && abs( color.r - color.b ) < 0.01 && color_hsv[2] > 0.5 ))
		{
			color_hsv[1] *= 1.0 - living_shadow[0];
			color_hsv[2] *= 1.0 - living_shadow[0]/2.0;
		}
		
		color = clamp( hsv2rgb( color_hsv ), 0.0, 1.0 );
	}
	
	if( black_rage[0] > 0.0 )
	{
		vec3 color_hsv = rgb2hsv( color );
		float r_k = color.r/( color.r + color.g + color.b );
		if( r_k > 0.6*black_rage[0] )
		{
			color_hsv[0] += ( 1.0 - color_hsv[0] )*black_rage[0];
			color_hsv[1] *= 1.1;
			color_hsv[2] *= 1.1;
		}
		else
		{
			color_hsv[1] = 0.0;
			color_hsv[2] *= 0.7;
		}
		
		color = clamp( hsv2rgb( color_hsv ), 0.0, 1.0 );
	}
	
	if( life_eater_edge_effect[0] > 0.0 )
	{
		color = mix( color, vec3( 0.635, 0.376, 0.0 ), edge_dist/2.0 );
	}
	
	if( warpfire_edge_effect[0] > 0.0 )
	{
		color = mix( color, vec3( 0.373, 0.0, 0.714 ), edge_dist/3.0 );
	}
	
	if( chogorian_edge_effect[0] > 0.0 )
	{
		color = mix( color, vec3( 0.243, 0.0, 0.039 ), edge_dist*chogorian_edge_effect[0] );
	}
	
	if( blessed_edge_effect[0] > 0.0 )
	{
		color = mix( color, vec3( 0.82, 0.624, 0.165 ), edge_dist*blessed_edge_effect[0] );
	}

// ============================================================================================================
// additive overlay ===========================================================================================