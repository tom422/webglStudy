uniform vec3 u_color;
uniform vec2 u_mouse;
uniform vec2 u_resolution;
uniform float u_time;

void main (void)
{
  // vec3 color = vec3(u_mouse.x/u_resolution.x, 0.0, u_mouse.y/u_resolution.y);
  vec3 color = vec3((sin(u_time)+1.0)/2.0, 0.0, (cos(u_time)+1.0)/2.0);
  gl_FragColor = vec4(color, 1.0); 
    // gl_FragColor = vec4( u_color, 1.0 ).rgba;
}