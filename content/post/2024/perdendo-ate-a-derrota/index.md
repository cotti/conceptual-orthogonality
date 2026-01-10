---
title: "Perdendo até a derrota"
description: ""
date: 2024-09-11T02:18:57-03:00
draft: false
image: "cover.jpg"
categories: ["computaria", "tolice"]
tags: ["backup", "borrise"]
# series: []
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

Eu tava de férias, né. Como era de se esperar, foi difícil ter um instante aqui e outro ali. Mas tava saindo um livro de visitas. Um projetinho bem anos 90, com uma roupagem dos tempos quase atuais – com a licença poética de não usar uma linguagem tão da hora e do momento.

Mas tinha de quase tudo um pouco ali; captcha do Cloudflare para coibir spam, uma API caprichadinha para receber e ter um gerenciadorzinho, com JWT configurado bonitinho, refresh token…

Tinha um design usando (ainda que fosse overkill, mas a ideia era entender mesmo) Clean Architecture, CQRS, tudo refinadinho. Usei até MongoDB, que nunca tinha mexido.

Criei um Dockerfile, criei um docker-compose.yml, e o mais importante: criei um docker-compose.yml que funcionou muito bem. Ele segurava as variáveis de ambiente que o backend usava, e fez tudo certinho. Rodava junto com o MongoDB e até um Manager enquanto não fazia o frontend.

Francamente, tava legal. Dava pra usar para começar a ter um mini-portifólio. Pelo menos eu podia mostrar que consigo desembolar esse tipo de coisa, ainda que não esteja trabalhando com isso agora.

Fiz a documentação inicial no README, conferi se podia usar a GNU AGPLv3, fiz uma página com um exemplo da parte do envio das mensagens pro livro. Tava pronto pra publicar no repositório.

Mas aí eu pensei, não, vou só adicionar logging primeiro. “Vai ser legal deixar um Serilog pronto, mesmo que com um sink só pra arquivo. Qualquer coisa coloca um sink pro Seq e adiciona ele no docker-compose.yml.”

## O castigo vem de bicicleta.

Eu tinha considerado várias vezes manter uma instância do Forgejo aqui no meu servidor, e espelhar as coisas no Github. Me permitiria não ter muita cerimônia pra salvar o que eu quisesse. Mas protelei.

Eu pensei várias vezes na estratégia que devia tomar pra começar um backup mais extensivo e automático de coisinhas jogadas em trocentas pastas pelos discos. Ou, finalmente, centralizar tudo e então replicar. Mas protelei.

O SSD onde estavam todos os projetos que ainda não tinham repositório externo, uma quantidade difícil de saber de dados que podem ou não ser importantes – porque a minha memória continua sendo um lixo – e a maioria das aplicações e definições de aplicações, foi pro saco.

Levei para uma empresa de recuperação de dados, identificaram que foi o controlador, e vai dar um custo insano. SE der certo. Se não der certo, vai ser só um terço de insanidade pela tentativa.

Agora eu nem sei por onde recomeçar, pois francamente ainda estou atônito. As coisas que já estavam sem gosto, agora estão intragáveis.

Façam backup, pessoas. Especialmente se você acha que dividir dados entre discos para reduzir danos resolve por um tempo. Nem era meu SSD mais antigo ou mais usado.

Agora é ficar olhando pras feridas, sem saber como lamber.
