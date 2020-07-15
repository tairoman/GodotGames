shader_type canvas_item;

uniform bool active = false;

void fragment() {
    vec4 prev_color = texture(TEXTURE, UV);
    if (active) {
        prev_color.rgb = vec3(1.0, 1.0, 1.0);
    }
    COLOR = prev_color;
}