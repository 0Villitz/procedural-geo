shader_type sky;

void sky() {
	//float vertmask.x = EYEDIR.g;// = vec4(0.0, 0.0, 0.0, 1.0);
	vec3 color = EYEDIR.ggg * 0.1;

	COLOR = color.rgb;
	ALPHA = 1.0;
}
