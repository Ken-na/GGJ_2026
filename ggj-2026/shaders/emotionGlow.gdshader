shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform sampler2D image : source_color;
void fragment() {
	vec2 texSize = vec2(textureSize(image, 0));
	int pixelsFilled = 0;
	for (float x = -3.0f; x <= 3.0f; x++)
	{
		for (float y = -3.0f; y <= 3.0f; y++)
		{
			vec2 pixelOff = vec2(x/texSize.x, y/texSize.y);
			vec4 pix = texture(image, UV + pixelOff);
			if (pix.a > 0.0f)
			{
				pixelsFilled = pixelsFilled + 1;
			}
		}
	}
	
	float alpha = float(pixelsFilled)/20.0f;
	ALBEDO = vec3(1, 1, 0);
	ALPHA = alpha;
}