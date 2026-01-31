shader_type spatial;

uniform bool use_billboard;
void vertex() {
	if (use_billboard){
        MODELVIEW_MATRIX = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
	}
}

uniform sampler2D albedo_texture : source_color;
uniform int do_rainbow : hint_range(0, 1);

void fragment() {
/*	RAINBOW!
	ALBEDO = vec3(cos(TIME), sin(TIME), 0.5); 
*/
	if(do_rainbow == 1){
		ALBEDO = vec3(cos(TIME), sin(TIME), 0.5); 
	}
	else{
		ALBEDO = texture(albedo_texture, UV).rgb;
	}
	
	ALPHA = texture(albedo_texture, UV).a;
	
}