---
title: "A mudança rápida"
description: "IA e uma coisa difícil de meter o dedo direito"
date: 2026-01-14T17:17:57-03:00 #current time
draft: false
image: "cover.png"
categories: ["desenvolvimento"]
tags: ["ia", "dev"]
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

Ultimamente eu tenho pensado na tal da *senioridade*.

Não que eu me sinta chegando nela; muito pelo contrário.

Mas na mudança que essa coisa de duas letras que está causando coisas e trecos está gerando no conceito, e na dinâmica entre desenvolvedores Júnior e Sênior.

E eu me peguei outro dia pensando mais do que eu achei que pensaria no assunto.

Deixo como nota que esses devaneios tomam como inevitável a continuidade da existência da IA atual, por mais que haja uma bolha a ser estourada. Vibe coding não é minha praia.

## Estagiário

O primeiro contato com IA me ajudando a resolver alguma treta foi no meu trabalho anterior, ainda na área de telefonia. Tinha que construir um *GUI* em *C#* e *XAML* - usando *Avalonia* - com algumas capacidades que não estavam incluídas no framework. No caso, um componente de navegação de pastas e arquivos em árvore, com um gerenciamento de estado mais complexo. Quem estava selecionado, quem não estava, quem tinha alguns elementos selecionados... Deu trabalho. Isso sem falar no potencial consumo de memória. O Avalonia 0.10 tinha algumas pegadinhas com gerenciamento de memória, e nós já tínhamos uma outra biblioteca que comprometia a performance, de acesso e edição de planilhas do Excel. Um projeto amaldiçoado.

Em alguns momentos achei que não ia dar pra desembolar. Mas futucando com a IA da época, que consistia basicamente no *Phind* quando era um preview gratuito e usava o *GPT 3.5* com uma leve alteração, eventualmente consegui fazer algo que funcionava. Tinha sua parcela de bugs que ia encontrando com o passar do tempo, mas **funcionava**.

A IA então tinha uma tendência a alucinar com muito mais frequência. E basicamente não conhecia nada do Avalonia: falava apenas de versões mais antigas, com arquitetura de classes diferentes, ou misturava com conceitos do WPF que ela conhecia melhor um pouco.

Em retrospectiva, tem duas causas importantes aí:

- Avalonia é um framework de nicho, e provavelmente não foi contemplado tendo seu código consumido pela LLM
- A documentação do Avalonia é um ponto fraco, ainda mais na época da versão 0.10. Hoje em dia está melhor, mas ainda é mencionada como um ponto contra quando comparada à concorrência direta, o Uno.

Foi com essa mistureba que eventualmente cheguei num componente que dava pra ser usado.

Meu sênior chamava o GPT de *estagiário*. Vira e mexe, especialmente quando precisava de alguma coisa de front-end, lá estava o estagiário fazendo alguma coisa.

Mas sempre naquele escopo pequeno. Um pedaço da página, poucas interações. Foi ainda um pouco como brinquedo que o estagiário foi contratado efetivamente.

## Júnior

Eu achava que tinha por alto uma ideia do que recomendar pra uma pessoa que queria entrar na carreira de desenvolvimento. Tenta coçar umas coceiras, tenta usar mais de uma linguagem, tenta absorver como não é tão assustador fazer algo que se publica sozinho, pratica, erra até acertar, bate a cabeça num problema, não tenha medo de cutucar as coisas, tenha curiosidade de perguntar e procurar saber o porquê.

Do ponto de vista de um time, uma pessoa num cargo Júnior tá ali também pra aprender *seguindo a trilha de migalhas de pão* dos seus sêniores. De aproveitar que sempre tem serviço que consome mais tempo que cognição de alguém mais experiente para se acostumar com a ideia de um dia tomar suas próprias decisões e brigar por elas.

Só que se alguém com mais experiência sabe fazer um prompt legal, sabe colocar limites e requisitos de forma clara, faz quase qualquer LLM atual que esteja se saindo bem em código ser mais produtiva que uma pessoa Júnior. **Ou até mais que isso**.

Uma pergunta que eu tenho curiosidade imensa em achar uma resposta: Como definir um caso geral em que isso possa se conciliar? Sequer é possível?

## Pleno

O tal "perigo" não se limita mais aos postos anteriores. Um Opus 4.5 da vida por exemplo implementa funcionalidades completas, dado um bom prompt. Pleno é um posto que eu vejo um pouco fora das contas fora do Brasil, mas representa um meio-termo relevante. É aqui que passa a se entender um pouco melhor o papel da delegação de tarefas.

Nesse sentido, considero "tão seguro quanto antes" um posto nesse degrau ainda. No geral, uma pessoa com a habilidade média esperada para essa casta já sabe fazer limitações adequadas para delegar uma pequena *gororoba* que funciona aqui e ali.

## Sênior e Além

A coisa que talvez seja a mais sênior que fiz foi bem recente.

Tem uma funcionalidade sendo implementada que tecnicamente está no meu nome, mas uma pessoa com menos experiência no desenvolvimento da base de código em questão se adiantou e começou a implementar, fazendo uso considerável de LLM.

Meu papel foi em primeiro lugar deixar que outra pessoa trabalhasse em algo que eu sei que faria mais ajeitado se tivesse o tempo. Revisei, sugeri, bloqueei, resolvi conflitos. Eventualmente, vou ajeitar para encaixar com o resto do código, mas o que está ali funciona.

Por mais que eu tenha revisado mais código gerado por IA, o processo de delimitar o que deveria ser criado foi feito do ponto de vista de alguém com a noção correta do que deveria acontecer no final das contas. Então eu revisei também se a ideia por trás da implementação soava certa, e soava.

## O Paquiderme na Sala

Todas essas perguntas ocorrem alheias aos danos fora do ramo. E me questiono também qual vai ser o papel dessas circunstâncias alheias quando for necessário algum tipo de medida de mitigação seja por dano ambiental, social, ou ambos, ou outras opções.

Há uma discussão até mesmo em torno de chamar IA de "ferramenta" versus o fato dela ter mudado o rumo do ramo. Por que não os dois? Ainda que estoure a famosa bolha, o que existe atualmente veio pra ficar, e não só vai influenciar o setor... como já influencia.

Eu fui Júnior e quero ajudar outros, mas é uma **situação coruja**. Abrir o GePetê da vida é *fazer um círculo*. Botar ele pra fazer o que você quer direito é *desenhar o resto do animal*. Sem o benefício de ver as coisas sob a ótica da experiência, é difícil exprimir o quão importante é fazer as coisas como se faziam nos tempos de outrora - **4 anos atrás** - pelo menos até você saber por alto de quantas formas diferentes pode dar um tiro de 12 no pé.
