
uniform vec2 u_resolution;
uniform float u_time;
varying vec2 v_uv;
varying vec3 v_position;

mat2 getScaleMatrix(float scale){
  return mat2(scale, 0, 0, scale);
}
mat2 getRotationMatrix(float theta){
  float s = sin(theta);
  float c = cos(theta);
  return mat2(c, -s, s, c);
}

// 创建矩形 pt position  size 大小   center 中心点
float rect(vec2 pt,vec2 anchor, vec2 size, vec2 center){
  vec2 p = pt - center - anchor ;
  vec2 halfsize = size * 0.5;
  // float horz = (v_position.x > -halfsize.x && v_position.x < halfsize.x) ?  1.0 : 0.0;
  float horz = step(-halfsize.x, p.x) - step(halfsize.x, p.x);
  float vert = step(-halfsize.y, p.y) - step(halfsize.y, p.y);
  return horz * vert;
}

// 创建一个圆
float circle(vec2 pt, vec2 center, float radius){
  vec2 p = pt - center;
  return 1.0 - step(radius, length(p));
}
// 创建一个圆  添加虚化
float circle(vec2 pt, vec2 center, float radius, bool soften){
  vec2 p = pt - center;
  float edge = (soften) ? radius * 0.5 : 0.0;
  return 1.0 - smoothstep(radius - edge, radius + edge, length(p));
}
// 创建一个圆 只有线条
float circle(vec2 pt, vec2 center, float radius, bool soften, float line_width){
  vec2 p = pt - center;
  float len = length(p);
  float half_line_width = line_width / 2.0;
  return step(radius - half_line_width, len) - step(radius + half_line_width, len);
}

float line(float a, float b, float line_width, float edge_thickness){
  float half_line_width = line_width * 0.5;
  return smoothstep(a-half_line_width-edge_thickness, a-half_line_width, b) - smoothstep(a+half_line_width, a+half_line_width+edge_thickness,b);
}

void main (void)
{

 
  // vec3 color = vec3(1.0,1.0, 0.0) * circle(v_position.xy, vec2(0.5), 0.3, true, 0.02);
   vec3 color = vec3(1.0,1.0, 0.0) * circle(v_position.xy, vec2(0.5), 0.3, true);
  vec2 uv = v_position.xy;
  // vec3 color = vec3(1.0) * line(uv.x, uv.y, 0.5, 0.3);
  // vec3 color = vec3(1.0) * line(uv.y,mix(-0.0, 0.8, (sin(uv.x * 3.14) + 1.0)/2.0) , 0.02, 0.0);
  if(color == vec3(0.0)){
    vec3 bg = vec3(0.5, 0.2, 0.0);
    gl_FragColor = vec4(bg, 1.0); 
  } else  {
    gl_FragColor = vec4(color, 1.0); 
  }  
   
}