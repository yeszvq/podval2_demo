shader_type canvas_item;
uniform float tile = 5.0;

void fragment() {
	vec2 grif = round(UV * tile)/tile;
	COLOR = texture(TEXTURE, grif);
	// Place fragment code here.
}
