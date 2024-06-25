---
title: Conceitos Básicos
sidebar_position: 2
---

# Conceitos Básicos

Neste capítulo, vamos explorar alguns dos conceitos fundamentais utilizados na programação GLSL. Esses conceitos são cruciais para entender como shaders funcionam e como eles são utilizados para criar efeitos visuais em gráficos computacionais.

## Tipos de Dados

GLSL, a linguagem de shaders para OpenGL, suporta vários tipos de dados que são utilizados para manipular informações no código do shader:

- Escalares: Representam valores únicos, como int, float, bool, double.

- Vetores: São conjuntos de valores escalares, como vec2, vec3, vec4 (onde vec4 é um vetor de quatro componentes float), ou ivec3 (representa um vetor de 3 componentes int).

  - Uma *feature* bem interessante dos vetores é o chamado **Swizzling**, no qual é possível obter diferentes componentes do vetor, ou até mesmo construir um vetor novo ao acessar os atributos x, y, z e w do vetor:
        ```cpp
        vec4 someVec;
        someVec.wzyx = vec4(1.0, 2.0, 3.0, 4.0); // Reverses the order.
        someVec.zx = vec2(3.0, 5.0); // Sets the 3rd component of someVec to 3.0 and the 1st component to 5.0
        ```

- Matrizes: Utilizadas para transformações geométricas, como mat2, mat3, mat4.

- Samplers: Tipos usados para acessar texturas, como sampler2D, samplerCube.

## Vertex Shader e Fragment Shader

Vertex Shader: Processa cada vértice de um objeto. É responsável por transformar posições 3D em posições de tela 2D e calcular outros atributos de vértice, como cor e coordenadas de textura.

```cpp
void main() {
    gl_Position = uProjectionMatrix * uModelViewMatrix * vec4(aPosition, 1.0);
}
```

Fragment Shader: Calcula a cor de cada fragmento (pixel). Recebe dados interpolados do vertex shader e realiza cálculos de iluminação, texturização e outras operações para determinar a cor final do pixel.

```cpp
void main() {
    gl_FragColor = texture2D(uSampler, vTextureCoord);
}
```

## Attributes, Uniforms e Varying

Estes são qualificadores usados para declarar variáveis com diferentes propósitos nos shaders, seguem uma estrutura de acordo com a tabela a seguir.

<div align="center">

|        |Attribute |Uniform  |Varying     |
|--------|----------|---------|------------|
|Vertex  |Read Only |Read Only|Read/Write  |
|Fragment|N.A.      |Read Only|Read Only   |
|Set From|CPU       |CPU      |Vertex      |
|Changes |Per Vertex|Constant |Per Fragment|

</div>

### Attributes

Variáveis que são passadas unicamente para o vertex shader e são diferentes para cada um dos vértices. Um exemplo é o atributo `aPosition` que representa a posição do vértice nas coordenadas globais do shader.

```cpp
attribute vec3 aPosition;
```

### Uniforms

Variáveis globais que são definidas pela CPU, e permanecem constantes durante o desenho de um objeto. Podem ser usadas somente para leitura, tanto no vertex quanto no fragment shader. Os valores definidos no ShaderToy podem ser observados a seguir.

```cpp
uniform vec3      iResolution;           // viewport resolution (in pixels)
uniform float     iTime;                 // shader playback time (in seconds)
uniform float     iTimeDelta;            // render time (in seconds)
uniform float     iFrameRate;            // shader frame rate
uniform int       iFrame;                // shader playback frame
uniform float     iChannelTime[4];       // channel playback time (in seconds)
uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
uniform vec4      iDate;                 // (year, month, day, time in seconds)
```

### Varying

Variáveis utilizadas para passar dados do vertex shader para o fragment shader, esses valores variam para cada fragment. Um exemplo é o `fragCoord`, que representa a coordenada de fragmento (pixel) atual no fragment shader e pode ser utilizada para efeitos que dependem da posição do pixel na tela.

```cpp
varying vec2 FragCoord;
```
