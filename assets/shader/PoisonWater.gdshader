shader_type canvas_item;

uniform float progress = 0.5;
uniform float freq = 2.5;
uniform float amp = 0.1;
uniform float speed = 2.0;

uniform vec4 backgroundColor: source_color;
uniform vec4 waveColor: source_color;

vec4 wave(vec2 uv) {
	float sinus = sin((uv.x + TIME * speed ) * freq ) * amp;
	return waveColor * step (1.0 - sinus - progress, uv.y);
}

void fragment() {
	vec4 wave = wave(UV);
	COLOR.rgb  = mix(backgroundColor, wave, wave.a).rgb;
}
