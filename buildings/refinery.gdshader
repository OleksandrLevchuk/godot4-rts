shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR = vec4(vec3(1,1,1)-vec3(COLOR.r,COLOR.b,COLOR.g),COLOR.a);
	COLOR.r = COLOR.r * 0.5;
}
