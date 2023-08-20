varying vec3 v_position;
varying vec2 v_uv;

void main() {	
  v_uv = uv;
  v_position = position;
  gl_Position = projectionMatrix * modelViewMatrix * vec4( position * 0.5 , 1.0 );
}