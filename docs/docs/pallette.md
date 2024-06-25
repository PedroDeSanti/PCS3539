---
title: Paleta de Cores
sidebar_position: 9
---

# Paleta de Cores

Neste artigo, vamos descobrir como deixar as visualizações mais coloridas com o shader: utilizando funções de paleta em OpenGLSL, com foco específico em como elas são implementadas e utilizadas. As funções de paleta são fundamentais para criar efeitos de cor dinâmicos e variados em shaders, permitindo a geração de uma ampla gama de cores de forma eficiente e flexível.

## Função palette

A ideia dessas funções é receber um valor de entrada `t` e retornar uma cor em sua saída, de forma que ao variar esse valor, a cor resultante também é alterada de maneira controlada, permitindo a geração de gradientes e padrões coloridos complexos.

```cpp
vec3 palette(float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);

    return a + b * cos(6.28318 * (c * t + d));
}
```

Onde a, b, c, d são 4 cores diferentes, e a função basicamente busca retornar um valor de cor a partir de um float de entrada, assim permitindo colorir diversas regiões diferentes do shader de maneira programática. Outras diferente cores para formar novas paletas podem ser criadas a partir do site: http://dev.thi.ng/gradients/.

A partir disso, podemos combinar todas as funções apresentadas neste breve guia, para criar shaders verdadeiramente artísticos, como [este exemplo](https://www.shadertoy.com/view/433SRM) que encontra-se abaixo:

<div align="center">
<iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/433SRM?gui=true&t=10&paused=false&muted=false" allowfullscreen></iframe>
</div>

Note, que neste caso os sliders tem várias funções, como apontados abaixo:

- r1: Controla o número de iterações no loop, afetando a densidade do padrão.

- r2: Ajusta a quantidade de subdivisões fracionais, aumentando o número de "fractais'.

- r3: Modifica a frequência das ondulações sinusoidais aplicadas à distorção.

- r4: Define o deslocamento aplicado às coordenadas uv.

- r5: Controla o contraste dos elementos.

- r6: Altera a velocidade e a variação das cores ao longo do tempo.
