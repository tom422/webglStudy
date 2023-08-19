
uniform vec2 u_resolution;

varying vec3 v_position;

// 创建矩形 pt position  size 大小   center 中心点
float rect(vec2 pt, vec2 size, vec2 center){
  vec2 p = pt - center;
  vec2 halfsize = size * 0.5;
  // float horz = (v_position.x > -halfsize.x && v_position.x < halfsize.x) ?  1.0 : 0.0;
  float horz = step(-halfsize.x, p.x) - step(halfsize.x, p.x);
  float vert = step(-halfsize.y, p.y) - step(halfsize.y, p.y);
  return horz * vert;
}

void main (void)
{
  float square1 = rect(v_position.xy, vec2(0.3), vec2(-0.5, 0.0));
  float square2 = rect(v_position.xy, vec2(0.4), vec2(0.5, 0.0));
  vec3 color = vec3(1.0,1.0, 0.0) * square1 + vec3(0.0, 1.0, 0.0) * square2;
  if(color == vec3(0.0)){
    
    gl_FragColor = vec4(vec3(0.5, 0.2, 0.0), 1.0); 
  }else{
    gl_FragColor = vec4(color, 1.0); 
  }
 
   
}