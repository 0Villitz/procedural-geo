shader_type spatial;

float doCalc(float axis, float linethickness, float numberofcells)
{
	return clamp(
				pow(
					cos(axis * PI * (numberofcells * 2.0)),
					(1.0 / linethickness) * 5.0					
				),
			0.0, 
			1.0
			);
}

void vertex()
{
	
}

void fragment() 
{	
	ALBEDO = 
	vec3(
		doCalc(UV.x, 0.01, 20.0),
		doCalc(UV.y, 0.01, 20.0),
		0.0);
	ALPHA = 0.65;
	ROUGHNESS = 1.0;
	METALLIC = 0.0;
	
}


