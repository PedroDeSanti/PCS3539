---
title: Função Smoothstep
sidebar_position: 6
---

# Função Smoothstep

Uma função muito útil para criar suavizações dentro do shader é a `smoothstep`, que recebe 3 parâmetros `edge0`, `edeg1` e `x`, o primeiro e o segundo determinam, respectivamente, o início e o fim do degrau, e o terceiro é o valor a ser avaliado, de forma que ao invés de uam transição abrupta, como ocorre na função `step`, o valor transiciona gradativamente entre `0` e `1` no intervalo do degrau, como pode ser observado no gráfico a seguir.

<div align="center">

![Smoothstep Function](/img/smoothstep.png)

</div>
