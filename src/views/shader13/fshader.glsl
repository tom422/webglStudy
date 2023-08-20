uniform vec3 u_LightColor;
uniform vec3 u_DarkColor;
uniform float u_Frequency;
uniform float u_NoiseScale;
uniform float u_RingScale;
uniform float u_Contrast;

varying vec3 v_position;

#include <noise>

void main(){
  float n = snoise(v_position);
  float ring = fract( u_NoiseScale * n );
  ring *= u_Contrast * ( 1.0 - ring );
  float lerp = pow( ring, u_RingScale ) + n;
  vec3 color = mix(u_DarkColor, u_LightColor, lerp);

  gl_FragColor = vec4(color, 1.0);
}