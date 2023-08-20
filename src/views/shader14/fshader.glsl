uniform vec3 u_LightColor;
uniform vec3 u_DarkColor;
uniform float u_Frequency;
uniform float u_NoiseScale;
uniform float u_RingScale;
uniform float u_Contrast;
uniform sampler2D u_tex;

varying vec3 v_position;
varying vec2 v_uv;

#define PI 3.14159265359
#define PI2 6.28318530718

#include <noise>
vec2 rotate(vec2 pt, float theta, float aspect){
  float c = cos(theta);
  float s = sin(theta);
  mat2 mat = mat2(c, s, -s, c);
  pt.y /= aspect;
  pt = mat * pt;
  pt.y *= aspect;
  return  pt;
}

float inRect(vec2 pt, vec2 bottomLeft , vec2 topRight){
  vec2 s = step(bottomLeft, pt) - step(topRight, pt);
  return s.x * s.y;
}

void main(){
  // vec2 vu = vec2(v_uv.x, 1.0 - v_uv.y);
  vec2 center = vec2(0.5);
  vec2 uv = rotate(v_uv - center, PI / 2.0, 1.0) + center;
  
  vec3 texel = texture2D(u_tex,uv).rgb;
  vec3 bg = vec3(0.0);

  float t = inRect(uv, vec2(0.0), vec2(1.0));
  vec3 color = mix(bg, texel, t);

  gl_FragColor = vec4(color, 1.0);
}