---
title: Funções de Distância com Sinal
sidebar_position: 4
---

# Funções de Distância com Sinal

Neste segundo exemplo, o objetivo é conhecer uma ferramenta muito útil para o desenvolvimento de shaders bidimensionais conhecida como a Função de Distância com Sinal. Essas funções basicamente permitem que, através de funções matemáticas, se desenhem primitivas na tela.

Essas primitivas são definidas por regiões na tela, onde o valor é positivo fora da área da primitiva, 0 na sua borda e negativo dentro, assim, pode-se utilizar outras funções para desenhar diferentes primitivas no canvas. Abaixo, segue um exemplo de primitiva de círculo:

<div align="center">
![Exemplo de primitiva de círculo](/img/circle.jpeg)
</div>

```cpp
float sdCircle( vec2 p, float r )
{
    return length(p) - r;
}
```

Note que não é necessário "deduzir" as funções, boa parte das primitivas mais comuns já são problemas resolvidos. Você pode acessar [este link](https://iquilezles.org/articles/distfunctions2d/) para conferir diferentes SDFs.

Agora que já conhecemos as SDFs, vamos para o nosso programa, você pode observar e modificar o código fonte [aqui](https://www.shadertoy.com/view/X33XRM) e também interagir com o Shader na janela abaixo:

<div align="center">
<iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/X33XRM?gui=true&t=10&paused=false&muted=false" allowfullscreen></iframe>
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
        
    d = abs(d);
    d = step(0.05, d);
    finalColor = vec3(d, 0.5,0.2);
    //fragColor = vec4(finalColor, 1.0);
    
    //UI
    vec4 ui = texture(iChannel0, fragCoord/iResolution.xy);
    fragColor = mix(vec4(finalColor, 1.0), ui, ui.a);
}
```

- Note que ao interagir com o slider, a variável `d` tem seu valor alterado, sendo que d representa a função de primitiva a ser renderizada na tela.

- Perceba também que para conseguirmos o resultado demonstrado, extraímos o módulo de d com o método `abs(d)`, agora que você já conhece sobre SDFs, o que você acha que aconteceria caso omitíssemos o módulo?

- A combinação de cores é definida na linha 36, usando um vec3 da seguinte forma `finalColor = vec3(d, 0.5,0.2);`, considerando o que já aprendemos sobre cores, como poderíamos alterar estes valores para mantermos as primitivas mas alterarmos as cores?
