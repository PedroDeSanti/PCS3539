---
title: Funções Booleanas
sidebar_position: 5
---

# Funções Booleanas

Dentro da linguagem de shaders, é possível utilizar blocos condicionais `if`, mas por criar branches na execução das instruções do código, esses blocos costumam reduzir a performance do programa. Para isso, é possível utilizar a função step para replicar a funcionalidade da lógica booleana através apenas da matemática, de forma que o código pode ser executado de forma sequencial.

## Função Step

A função step recebe dois valores `edge` e `x`, o primeiro determina onde será o degrau da função, e o segundo é o valor a ser avaliado, de forma que a operação retorna 0.0 se x < edge e 1.0 caso contrário, como pode ser observado no gráfico a seguir.

<div align="center">

![Step Function](/img/step.jpeg)

</div>

## Operações Booleanas

### Operação "NOT"

<div align="center">

|A|1 - A|not A|
|-|---|-----|
|0| 1 |  1  |
|1| 0 |  0  |

</div>

### Operação "AND"

<div align="center">

|A|B|A*B|A and B|
|-|-|---|-------|
|0|0| 0 |   0   |
|0|1| 0 |   0   |
|1|0| 0 |   0   |
|1|1| 1 |   1   |

</div>

### Operação "OR"

<div align="center">

|A|B|step(0.0, A+B)|A or B|
|-|-|--------------|------|
|0|0|      0       |   0  |
|0|1|      1       |   1  |
|1|0|      1       |   1  |
|1|1|      1       |   1  |

</div>
