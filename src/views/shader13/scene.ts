import * as THREE from 'three';
 
import vshader from './vshader.glsl'
import fshader from './fshader.glsl'




const scene = new THREE.Scene();
const camera = new THREE.OrthographicCamera( -1, 1, 1, -1, 0.1, 10 );

const renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );

const clock = new THREE.Clock();

const geometry = new THREE.PlaneGeometry( 2, 2 );
type Uniforms = {
   [key:string]:{value:any}
}
const uniforms:Uniforms = {}
uniforms.u_time = { value: 0.0 };
uniforms.u_resolution = { value: new THREE.Vector2() };
uniforms.u_LightColor = { value: new THREE.Color(0xbb905d) };
uniforms.u_DarkColor = { value: new THREE.Color(0x7d490b) };
uniforms.u_Frequency = { value: 2.0 };
uniforms.u_NoiseScale = { value: 6.0 };
uniforms.u_RingScale = { value: 0.6 };
uniforms.u_Contrast = { value: 4.0 };

const material = new THREE.ShaderMaterial( {
  uniforms: uniforms,
  vertexShader: vshader,
  fragmentShader: fshader
} );

const plane = new THREE.Mesh( geometry, material );
scene.add( plane );

camera.position.z = 1;


 

 


function onWindowResize( event?:unknown ) {
  const aspectRatio = window.innerWidth/window.innerHeight;
  let width, height;
  if (aspectRatio>=1){
    width = 1;
    height = (window.innerHeight/window.innerWidth) * width;
  }else{
    width = aspectRatio;
    height = 1;
  }
  camera.left = -width;
  camera.right = width;
  camera.top = height;
  camera.bottom = -height;
  camera.updateProjectionMatrix();
  renderer.setSize( window.innerWidth, window.innerHeight );
  uniforms.u_resolution.value.x = window.innerWidth;
  uniforms.u_resolution.value.y = window.innerHeight;
}

function animate() {
  requestAnimationFrame( animate );
  uniforms.u_time.value += clock.getDelta();
  // console.log(uniforms.u_time.value);
  
  renderer.render( scene, camera );
}


export default function init(){
    animate();
    if (!('ontouchstart' in window)) window.addEventListener( 'resize', onWindowResize, false );
}
