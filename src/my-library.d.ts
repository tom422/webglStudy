
// declare module 'three' {
//   import  *  as THREE from 'three'
//   type myShaderChunk = typeof THREE.ShaderChunk;
//   interface IShaderChunk  extends myShaderChunk {
//     simple_lambert_vertex:string,
//     noise:string
//   }
//   module 'three' {
//     export const ShaderChunk:IShaderChunk
//   }

// }

// src/my-library.d.ts

// 声明文件必须放在 src 文件夹下，以确保 TypeScript 能够正确识别

// declare module 'three' {
//     // 导入你要覆盖的库
//     import { ShaderChunk } from 'three';
//     import  *  as THREE from 'three'
//     //type myShaderChunk = typeof ShaderChunk;
//     interface IShaderChunk extends ShaderChunk {
//       simple_lambert_vertex:string,
//       noise:string
//     }
    
//     // 在模块声明中扩展命名空间属性的类型定义
//     // declare module 'three' {
//     //   // 这里覆盖 myFunction 的类型定义
//     //     type ShaderChunk = IShaderChunk
        
        
//     // }
     
//   }