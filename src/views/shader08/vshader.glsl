varying vec2 v_uv;

void main() {	
  v_uv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4( position * 0.5 , 1.0 );
}