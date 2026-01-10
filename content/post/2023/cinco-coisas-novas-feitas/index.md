---
title: "Cinco coisas novas feitas"
description: ""
date: 2023-11-13T02:18:57-03:00
draft: false
image: "cover.jpg"
categories: ["computaria"]
tags: ["AppImage", "AvaloniaUI", "projetos", "instalador", "LLM", "paralelismo", "rubberducking", "WiX"]
series: ["balanço"]
# author: ""
# toc: true
# math: false
# readingTime: true
# license: ""

# hidden: false
# comments: true
# slug: ""
# aliases: []

# lastmod: 2026-01-04T02:18:57-03:00
# expiryDate: 2025-12-31
# publishDate: 2026-01-04T02:18:57-03:00

# keywords: []
# weight: 1

# layout: "post"
# type: "post"

---

*Esse post estava n’O Bifão, uma tentativa (como todas as outras, falha) de manter uma espécie de blog nesses tempos tão difíceis em que tudo se resolve em volta de rede social.*

Um ano de um trampo bem diferente, ainda que cheio de paralelos – que ajudaram na colocação pra começo de conversa – me fizeram ir pra vários lugares diferentes, tecnicamente.

Eu tinha pensado por um tempo já em fazer um balanço do que sem querer ou por querer aprendi no ano. Fui testado pelas circunstâncias e pelos requisitos, e deu pra construir um pequeno playground cutucando coisas aqui e ali.

-----

## 1. AvaloniaUI

Já tinha um bom tempo que eu ficava de olho numa alternativa a fazer alguma coisa para desktop, com C#, que não fosse o WPF. Ou WinForms.

Ou WinUI. Ou UWP.

Ou Xamarin. Ou MAUI.

Francamente, a confusão que eu fiquei quando criei um projeto de brincadeira com MAUI não tá no gibi. E eu já me esqueci de tudo que eu já tinha decorado que era bom de fazer em um projeto novo com WPF. E, de toda forma, ser independente de plataforma é essencial pra mim.

Então veio a oportunidade de mexer com um produto em que eu pude escolher as coisas desde a incepção, e na criação da prova de conceito decidi prender a respiração e usar o AvaloniaUI, o qual já tinha ouvido falar anos atrás. O tempo para colocar as coisas em um nível testado era curto, então o ideal era não errar nessa escolha.

Confesso que minhas melhores expectativas foram superadas. É como o WPF devia ser desde o começo. Não que eu não tenha encontrado alguns pontos onde empaquei, ou onde eu não veja sentido nas escolhas (é um suplício trocar a cor da marca do CheckBox corretamente), mas a maior parte do tempo usando o AvaloniaUI é genuinamente divertido.

[MessengerPlusSoundBankExtractor](https://github.com/cotti/MessengerPlusSoundBankExtractor), um dos prováveis programas mais de nicho de todos os tempos, é um extrator de áudios de pacotes de backup do já extinto por mais de 10 anos Messenger Plus – e usa AvaloniaUI.

{{< video mpsbe.mp4 >}}

## 2. AppImage

Tá aí uma outra coisa que eu tinha curiosidade mas não tinha oportunidade. Desembolar um AppImage que funcionasse, e conseguir enxergar – ainda que parcialmente – a lógica por trás.

É bem satisfatório ter um programa para desktop prontinho pra GNU/Linux (e funcionando), sem mexer uma linha de código do que é gerado pra Windows.

Incidentalmente, isso foi em boa parte contribuição do excelente PupNet-Deploy, que serviu de base para depois sair futucando ingratamente no AppImage que ele criou até ver como as peças se encaixavam. Ler especificações é para quem nasceu sabendo, afinal.

O que ainda é um pouco confuso pra mim é que aparentemente existem múltiplos empacotadores de AppImage por aí. Mas depois eu aprendo o que está acontecendo. Certamente é melhor que Flatpak e Snap…

## 3. Instaladores

Criar um instalador (especialmente e especificamente para Windows) não é uma tarefa exatamente casual (especialmente e especificamente antes de aprender sobre o PupNet-Deploy, mas isso são outros nhenhenhentos).

Graças ao vídeo-tutorial-bateção-de-cabeça do AngelSix mostrando o passo-a-passo de criar um instalador usando o WiX (versão 3), eu eventualmente consegui criar um instalador usando o WiX (versão 3).
O bendito tutorial. Como eu tive paciência, você pergunta? Eu não tive, é a resposta.

{{< youtube 6Yf-eDsRrnM >}}

A complexidade é um belo exemplar de Desnecessaurus Rex. Mas funcionou bem, e depois da configuração inicial não precisei mais fazer alterações.
A experiência de conhecer o mundo dos instaladores para WindowsA experiência de conhecer o mundo dos instaladores para Windows

## 4 – Não Deixe O Paralelismo Passar Fome Por Causa De Uma Linha

*Necessidade é o Frank Zappa & As Mães da Invenção*, já dizia o velho deitado. Quando você tem que usar uma biblioteca pra escrever um arquivo do Excel, pior ainda.

Passar por potencialmente todos os arquivos de um disco, que pode ser uma unidade de rede ainda por cima, tem um bom custo de I/O. Como muitas propriedades mais particulares deles eram usadas, tem uma quantidade interessante de syscalls sendo feitas.

Claro, um belo `Paralell.ForEach()` foi usado – com configurações bem-definidas (ainda que agressivas) de processamentos simultâneos, checagens colocadas no lugar certo se aquele loop deveria cessar, tudo do bom e do melhor.

Ele voa de cara!

Ele voa menos quando um disco em rede com mais de 2 milhões de arquivos é usado. **Na verdade parava nos 8% depois de 25 horas.**

**Algo de errado não estava certo**. Essas coisas deviam ir pra 100%. A conclusão é que alguma coisa estava causando *thread starvation*. Mas que tipo de coisa arcana e indomável podia fazer isso? Era o acesso à rede? Era essa busca por propriedades mais aprofundada nos arquivos?

Deixei um *profiler* rolando por uns minutos escaneando meu disco local todo. O problema tá lá também. Não era acesso à rede.

O que podia ser? Tudo que a gente fazia era pegar os arquivos, ler essas informações, jogar numa planilha de Excel, adicionar uma regra de validação em uma coluna…

Opa.

O profiler indicou o culpado – ninguém menos que **o método de inserir validação na planilha do Excel**. De alguma forma ele tende a travar a thread. E se a gente não ser só ingenuidade e adicionar a validação de uma só vez selecionando a coluna inteira depois de adicionar todas as linhas?

Mudar uma linha de código de um lugar para o outro, e mudar o parâmetro de uma linha só para um range de colunas. Agora atravessar o disco de rede inteiro leva umas poucas horas, e não desacelera. Faz um tempo bem melhor que a solução anterior do cliente, **que era feita em VB6**.

## 5 – Patinho de borracha

Em meio a alucinações e devaneios, se esconde um bom patinho de borracha.

![A inegável beleza da Internet contemporânea, em toda sua glória.](rubberduck.jpg)

Patinhos de borracha substancialmente sujos e desbotados.

A inegável beleza da Internet contemporânea, em toda sua glória.

Assim é um LLM. Não caí de anel assim pelo ChatGPT da vida, mas descrever o problema e olhar com cuidado as respostas já me economizou um bom tempo.

Mas é impressionante como as coisas evoluíram de pouco tempo pra cá.

Eu tenho usado o [Phind](https://www.phind.com/), que é otimizado para desenvolvimento, e provê algumas buscas usando GPT-4 por dia. Mas mesmo quando o modelo com o GPT-3.5 é usado, os resultados são na média muito bons.

É só garantir que não tem lama no meio. É relativamente comum alucinações em que são usadas APIs que foram removidas, por exemplo – mesmo quando a versão da coisa que você está usando é especificada.

LLM tem que RTFM um pouco mais.