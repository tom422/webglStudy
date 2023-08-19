#define PI 3.14159265359
#define PI2 6.28318530718

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

float sweep(vec2 pt, vec2 center, float radius, float line_width, float edge_thickness){
  vec2 d = pt - center;
  float theta = u_time * 2.0;
  vec2 p = vec2(cos(theta), -sin(theta)) * radius;
  float h = clamp(dot(d,p)/dot(p,p), 0.0, 1.0);
  // 
  float l = length(d-p*h);

   float gradient = 0.0;
  const float gradient_angle = PI * 0.2;

  if (length(d)<radius){
    float angle = mod(theta + atan(d.y, d.x), PI2);
    gradient = clamp(gradient_angle - angle, 0.0, gradient_angle)/gradient_angle * 0.5;
  }

  return gradient + 1.0 - smoothstep(line_width, line_width+edge_thickness, l);
}

float circle(vec2 pt, vec2 center, float radius, float line_width, float edge_thickness){
  pt -= center;
  float len = length(pt);
  //Change true to false to soften the edge
  float result = smoothstep(radius-line_width/2.0-edge_thickness, radius-line_width/2.0, len) - smoothstep(radius + line_width/2.0, radius + line_width/2.0 + edge_thickness, len);

  return result;
}


float line(float a, float b, float line_width, float edge_thickness){
  float half_line_width = line_width * 0.5;
  return smoothstep(a-half_line_width-edge_thickness, a-half_line_width, b) - smoothstep(a+half_line_width, a+half_line_width+edge_thickness,b);
}


float polygon(vec2 pt, vec2 center, float radius, int sides, float rotate, float edge_thickness){
  pt -= center;
  
  // Angle and radius from the current pixel
  float theta = atan(pt.y, pt.x) + rotate;
  float rad = PI2/float(sides);

  // Shaping function that modulate the distance
  float d = cos(floor(theta/rad + 0.5)*rad-theta)*length(pt);

  return 1.0 - smoothstep(radius, radius + edge_thickness, d);
}

void main (void)
{

  vec3 axis_color = vec3(0.8);
  
  vec2 uv = v_uv.xy;
  vec3 color = line(v_uv.y, 0.5 , 0.002, 0.001 ) * axis_color;
  color += line(v_uv.x, 0.5, 0.002, 0.001)  * axis_color;
  color += circle(v_uv, vec2(0.5), 0.3, 0.002 , 0.001) * axis_color;
  color += circle(v_uv, vec2(0.5), 0.2, 0.002 , 0.001) * axis_color;
  color += circle(v_uv, vec2(0.5), 0.1, 0.002 , 0.001) * axis_color;
  color += sweep(v_uv, vec2(0.5), 0.3, 0.003, 0.001) * vec3(0.1, 0.3, 1.0);

  color += polygon(v_uv, vec2(0.9 - sin(u_time*3.0)*0.05, 0.5), 0.005, 4, -PI/6.0, 0.001) * vec3(1.0);
  color += polygon(v_uv, vec2(0.1 - sin(u_time*3.0+PI)*0.05, 0.5), 0.005, 3, PI/6.0, 0.001) * vec3(1.0); 
  color += polygon(v_uv, vec2(0.5, 0.9 - sin(u_time*3.0)*0.05), 0.005, 3, PI, 0.001) * vec3(1.0);
  color += polygon(v_uv, vec2(0.5, 0.1 - sin(u_time*3.0+PI)*0.05), 0.005, 3, 0.0, 0.001) * vec3(1.0); 
  gl_FragColor = vec4(color, 1.0); 
 
   
}