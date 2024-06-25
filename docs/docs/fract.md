---
title: Função Fract
sidebar_position: 8
---

# Função Fract

A função `fract` no GLSL (OpenGL Shading Language) é usada para obter a parte fracionária de um número. Ela é especialmente útil em shaders para criar padrões repetitivos, já que ela transforma um valor contínuo em um intervalo [0, 1). A função é definida da seguinte maneira:

```cpp
float fract(float x);
vec2 fract(vec2 x);
vec3 fract(vec3 x);
vec4 fract(vec4 x);
```

Para um valor escalar ou vetorial, a função retorna a parte fracionária. Por exemplo, fract(2.7) retorna 0.7, e fract(vec2(1.5, 2.8)) retorna vec2(0.5, 0.8).

## Exemplo prático

A `fract()` é extremamente poderosa para criar padrões repetitivos sem aumentar o custo computacional. Como os programas de shader são executados pixel por pixel, não importa quantas vezes você repita uma forma, o número de cálculos permanece constante, tornando os fragment shaders particularmente adequados para criar padrões de mosaico.

Vamos usar [um shader](https://www.shadertoy.com/view/4XcXRM) para demonstrar como a função `fract()` pode ser usada para criar padrões repetitivos.

<div align="center">
<iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/4XcXRM?gui=true&t=10&paused=false&muted=false" allowfullscreen></iframe>
</div>

No código a seguir, através dos sliders é possível interagir com o shader e observar os efeitos da função `fract()` em tempo real.

```cpp
float readFloat(float address) { return texture(iChannel0, (floor(vec2(address, 1))+0.5) / iChannelResolution[0].xy).r; }

float sdEquilateralTriangle( in vec2 p, in float r )
{
    const float k = sqrt(3.0);
    p.x = abs(p.x) - r;
    p.y = p.y + r/k;
    if( p.x+k*p.y>0.0 ) p = vec2(p.x-k*p.y,-k*p.x-p.y)/2.0;
    p.x -= clamp( p.x, -2.0*r, 0.0 );
    return -length(p)*sign(p.y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    float r1 = readFloat(1.);
    float r2 = readFloat(2.);
    float r3 = readFloat(3.);
    float r4 = readFloat(4.);
    float d = 0.;
    
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y; // centraliza coordenadas
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    if(r3<=0.1){
        uv = uv;
    }
    else if(r3<=0.2){
        uv = fract(uv*2.)-0.5;
    }
    else if(r3<=0.3){
        uv = fract(uv*3.)-0.5;
    }
    else if(r3<=0.4){
        uv = fract(uv*4.)-0.5;
    }
    else if(r3<=0.5){
        uv = fract(uv*5.)-0.5;
    }
    else if(r3>0.5){
        uv = fract(uv*6.)-0.5;
    }
    
    if(r4 <= 0.33){
         d = length(uv)-r1;
       }
    else if (r4< 0.66){
        vec2 c = abs(uv) - r1;
        d = length(max(c,0.0)) + min(max(c.x, c.y), 0.0);
    }
    else {
        d = sdEquilateralTriangle(uv, r1);
    }
    if(r2 <= 0.5){
        d = sin(d*8.+iTime)/8.;
    }
    else{
        d = sin(d*8.)/8.;
    }
    d = abs(d);
    d = step(0.015, d);
    
    finalColor = vec3(0.1, 0.4, d);
    
    //UI
    vec4 ui = texture(iChannel0, fragCoord/iResolution.xy);
    fragColor = mix(vec4(finalColor, 1.0), ui, ui.a);
}
```

- **Slider r1 (Radius)**: Controla o tamanho da forma geométrica (círculo, quadrado ou triângulo) gerada no shader.

- **Slider r2 (Animate)**: Este slider adiciona uma variação temporal ao padrão, resultando em um efeito de oscilação (senoidal) nos padrões. Valores menores ou maiores que 0.5 determinam a fórmula usada para calcular a oscilação.

- **Slider r3 (Fracts)**: Este slider controla o fator de repetição aplicado às coordenadas UV antes de calcular a parte fracionária. Variando o valor de r3 entre 0.0 e 0.6, você pode observar como os padrões repetitivos mudam. Quando r3 é maior, a repetição é mais frequente.
  - r3 ≤ 0.1: Sem modificação.
  - 0.1 < r3 ≤ 0.2: Repetição duplicada (2x).
  - 0.2 < r3 ≤ 0.3: Repetição triplicada (3x).
  - E assim por diante até 6 vezes.

- **Slider r4 (Function)**: Este slider altera a forma geométrica utilizada no shader.
  - r4 ≤ 0.33: Círculo.
  - 0.33 < r4 ≤ 0.66: Quadrado.
  - r4 > 0.66: Triângulo equilátero.
