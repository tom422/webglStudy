import {ShaderChunk}  from 'three'
import THREE from 'three';
 
type myShaderChunk = typeof THREE.ShaderChunk;
type IShaderChunk  = {
    simple_lambert_vertex:string,
    noise:string,
    [key:string]:unknown
}

type mainly = IShaderChunk | myShaderChunk;

// 然后，在全局作用域中扩展命名空间属性的类型定义
declare global {
    namespace THREE {
       const ShaderChunk: IShaderChunk;
    }
  }
 
  

 



 

 