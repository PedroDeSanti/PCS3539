---
title: Utilizando Cores
sidebar_position: 3
---

# Utilizando Cores

Este [primeiro exemplo](https://www.shadertoy.com/view/43cSRM) trata-se da renderização mais elementar que pode ser atingida utilizando o Shader Toy. O objetivo aqui é apenas observar a renderização de cores no canvas utilizando as funções mais básicas disponíveis, abaixo, podemos ver o resultado do render no Shader Toy e em seguida, o código fonte. (note que você pode clicar no nome do Shader localizado no canto superior esquerdo para acessar o produto diretamente no Shader Toy)

<div align="center">
<iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/43cSRM?gui=true&t=10&paused=false&muted=false" allowfullscreen></iframe>
</div>

```cpp
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    float r1 = readFloat(1.);
    float r2 = readFloat(2.);
    float r3 = readFloat(3.);
    
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y; // centraliza coordenadas
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    
    finalColor = vec3(r1, r2, r3);
    
    //UI
    vec4 ui = texture(iChannel0, fragCoord/iResolution.xy);
    fragColor = mix(vec4(finalColor, 1.0), ui, ui.a);
}
```

Perceba que o canvas (a tela) recebe um valor do tipo `vec4`, ou seja, um vetor de tamanho 4 onde cada item representa um valor de cor (R, G, B) e um canal de transparência (alpha). Para associar um `vec4` à saída, basta retornar o valor do `vec4` para a variável `fragColor`, que representa o renderizador do canvas.

Note, que no exemplo fornecido, ao invés de simplesmente realizar

```cpp
fragColor = vec4(1., 0., 1., 1.)
```

Fazemos

```cpp
    vec3 finalColor = vec3(0.0);
    
    finalColor = vec3(r1, r2, r3);
    
    //UI
    vec4 ui = texture(iChannel0, fragCoord/iResolution.xy);
    fragColor = mix(vec4(finalColor, 1.0), ui, ui.a);
```

Aqui, uma série de funções são utilizadas. Vamos analisar uma à uma:

- Inicialmente, define-se a cor desejada como um vec3 denominado finalColor. Ele é definido pelas variáveis r1, r2 e r3, que são definidas pelos sliders.

- Em seguida, tem-se um `vec4 ui`. Ele representa um buffer de vídeo (como se fosse outro canvas além do principal), onde são renderizados os elementos da interface interativa com os sliders.

- Enfim, retornamos para o renderizador através da função `mix()`, que retorna uma interpolação linear da UI com a cor renderizada utilizando o valor ui.a como peso, e atribui no `fragColor`, assim renderizando a interface e uma cor na tela.

Experimente arrastar os sliders, você consegue entender como cada parâmetro afeta o resultado da renderização?
