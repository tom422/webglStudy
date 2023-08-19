
uniform vec2 u_resolution;

varying vec3 v_position;

void main (void)
{
  vec3 color = vec3(0.0);
  // color.r = clamp(v_position.x, 0.0, 1.0);
  // color.g = clamp(v_position.y, 0.0, 1.0);
  
  // color.r = step(-1.0, v_position.x);
  // color.g = step(-1.0, v_position.y);


  color.r = smoothstep(0.0, 0.5, v_position.x);
  color.g = smoothstep(0.0, 0.5, v_position.y);
  gl_FragColor = vec4(color, 1.0); 
   
}