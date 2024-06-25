---
title: Raymarching
sidebar_position: 10
---

# Ray Marching

Até agora foram apresentadas diversas funções e técnicas que compõem a base da utilização dos shaders, e por mais que tenham sido demonstradas em situações com duas dimensões para simplificar a visualização, tudo que foi demonstrado também se aplica com mais dimensões.

A partir disso, nesse capítulo serão abordados os conceitos necessários para a implementação do Ray Marching, que é uma técnica para renderização de cenas 3D no qual os raios são traçados de forma iterativa, através do incremento da posição com base na distância do raio aos objetos próximos.

## Inicialização

Inicialmente é necessário declarar o raio, que parte de um ponto de trás da tela em direção a cena, e uma variável que irá armazenar a distância total percorrida por esse raio:

```cpp
vec3 ro = vec3(0, 0, -3);         // ray origin
vec3 rd = normalize(vec3(uv, 1)); // ray direction
float t = 0. // total distance traveled
```

## Função de distâncias

Em seguida, é necessário declarar uma função `map`, que retorna a distância até o objeto mais próximo para uma determinada coordenada na cena, isso é o equivalente a obter o valor mínimo de todas as SDFs dos objetos, mas no caso de uma cena com um único objeto, essa função é o próprio SDF.

```cpp
float map(vec3 p) {
    return length(p) - 1.; // distance to a sphere of radius 1
}
```

## O Algoritmo

Por fim, é necessário implementar o algoritmo de ray marching, que de forma iterativa incrementa a posição do raio na direção determinada, considerando a distância para os objetos na cena.

```cpp
for (int i = 0; i < 80; i++) {
    vec3 p = ro + rd * t;     // position along the ray

    float d = map(p);         // current distance to the scene

    t += d;                   // "march" the ray

    if (d < .001) break;      // early stop if close enough
    if (t > 100.) break;      // early stop if too far
}
```

Essa técnica pode parecer simples, mas é base para muitas visualizações complexas em 3D, sendo necessário somente realizar algumas otimizações, e alterar a função de map para incluir novos objetos.

## Exemplo

Para exemplificar o algoritmo, foi desenvolvido [um shader](https://www.shadertoy.com/view/43cXRM) com ray marching, no qual é possível rotacionar um cubo em diferentes eixos utilizando os sliders presentes na UI.

<div align="center">
<iframe width="640" height="360" frameborder="0" src="https://www.shadertoy.com/embed/43cXRM?gui=true&t=10&paused=false&muted=false" allowfullscreen></iframe>
</div>
