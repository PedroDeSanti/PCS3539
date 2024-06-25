---
title: Animações
sidebar_position: 7
---

# Animações

Outra funcionalidade útil fornecida pelos shaders é o uso de variáveis que servem como inputs, conhecidas como **uniforms**. No caso do Shader Toy, em geral são variáveis definidas previamente cujo nome começa com 'i'. Vamos abordar a mais proeminente neste exemplo: **iTime**. Como o nome indica, a variável iTime armazena o tempo de playback do shader em segundos e permite que a sua renderização varie junto com o tempo de execução do shader.

Uma das formas mais comuns de se usufruir desta *feature* é utilizando funções trigonométricas como seno ou cosseno, alimentando estas variáveis com o **iTime**, podemos ter efeitos que variam de forma cíclica, acompanhando o padrão de uma função trigonométrica! Vamos conferir isso no exemplo abaixo, [cujo link do Shader Toy encontra-se aqui](https://www.shadertoy.com/view/433XRM)

<div align="center">
<iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/433XRM?gui=true&t=10&paused=false&muted=false" allowfullscreen></iframe>
</div>

```cpp
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
    
    finalColor = vec3(0.1, d,0.4);
    
    //UI
    vec4 ui = texture(iChannel0, fragCoord/iResolution.xy);
    fragColor = mix(vec4(finalColor, 1.0), ui, ui.a);
}
```

Note que agora possuímos uma linha onde a SDF torna-se um produto de **iTime**, assim, conseguimos um efeito não apenas de repetição (graças ao seno), como também de animação (produto da operação com **iTime**)

```cpp
d = sin(d*8.+iTime)/8.;
```

- Como será que conseguimos acelerar ou desacelerar a velocidade da animação ou aumentar o número de primitivas repetidas no shader?
