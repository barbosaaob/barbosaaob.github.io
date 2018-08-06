title: Introdução ao TeX/LaTeX
tags: comp math
category: blog
date: 2018-07-14 22:53
modified: 2018-07-14 22:53
status: draft

## O que são o TeX e o LaTeX

"O TeX é um sistema de tipografia desenhado e escrito principalmente por Donald
Knuth e lançado em 1978. Junto com a linguagem para a descrição de fontes
Metafont e a família de tipos de letras Computer Modern, o TeX foi projetado
tendo em vista dois objetivos principais: permitir que qualquer pessoa produza
livros de alta qualidade com o mínimo esforço e fornecer um sistema que produza
exatamente os mesmos resultados em todos os computadores em qualquer momento."
([Wikipedia](https://pt.wikipedia.org/wiki/TeX))


"$\LaTeX$ é um conjunto de macros para o programa de diagramação de textos TeX,
utilizado amplamente na produção de textos matemáticos e científicos, devido a
sua alta qualidade tipográfica."
([Wikipedia](https://pt.wikipedia.org/wiki/LaTeX))
 
## Software necessário

### Distribuição TeX

Algumas distribuições TeX mais conhecidas para cada sistema operacional são:

GNU/Linux e BSDs: [TeX Live](https://tug.org/texlive/)  
MS Windows: [MiKTeX](https://miktex.org/)  
Mac OS: [MacTeX](http://www.tug.org/mactex/)

Pra iniciantes é recomendado a instalação completa da distribuição TeX
disponível para seu sistema operacional.

Uma lista mais completa de distrubuições está disponível em:
[http://www.tug.org/interest.html#free](http://www.tug.org/interest.html#free)

### Editor de texto

Qualquer [editor de texto plano](https://pt.wikipedia.org/wiki/Editor_de_texto)
pode ser utilizado para escrever e editar arquivos $\LaTeX$ (MS Word e OpenOffice
são **processaores** de texto). Entretando, existem alguns editores de texto
especializados para editaçção de arquivos LaTex. Alguns dos mais conhecidos
são:

[Texmaker](http://www.xm1math.net/texmaker/) - GNU/Linux, BSDs, Windows e Mac OS
[Kile](https://kile.sourceforge.io/) - GNU/Linux e BSDs
[TeXnicCenter](http://www.texniccenter.org/) - MS Windows
[TeXShop](http://pages.uoregon.edu/koch/texshop/) - Mac OS

Uma lista mais completa de editores está disponível em:
[http://www.tug.org/interest.html#packages](http://www.tug.org/interest.html#packages)

Usar um editor especializado para arquivos $\LaTeX$ é recomandada, pois sua
interface disponibiliza uma série de símbolos e a insersão dos comandos
referentes a esses símbolos com apenas um clique. Além disso, o editor será o
responsável por chamar a distribuição TeX e essa transformará seu arquivo $\LaTeX$
num arquivo legível em diversos formatos a sua escolha (pdf, html, dvi, etc).

## Estrutura do arquivo

Um arquivo em $\LaTeX$ tem o seguinte formato:

	\documentclass{article}
	\title{Meu primeiro artigo em LaTeX}
	\author{Adriano}
	\date{Agosto 2018}
	\begin{document}
		\maketitle
		Oi mundo!
	\end{document}

Em português:

* O documento é um artigo
* O título do artigo é Meu primeiro artigo em $\LaTeX$
* O autor é Adriano
* Foi escrito em Agosto de 2018
* O texto do artigo é a frase Oi mundo!

Em detalhes:

O comando `\documentclass{article}` determina o tipo (classe) do documento.
Nesse caso, um artigo. Outras classes possíveis são `book` e `report`.

Nem todas as classes aceitam os comandos `\title` e `\author`. Esses são
comandos que dependem da implementação na classe escolhida (sim, podemos
definir nossas próprias classes, mas fica para outra oportunidade).

Os comandos `\begin` e `\end` delimitam um ambiente. O ambiente `document` é o
ambiente principal de qualquer arquivo $\LaTeX$. Dentro desse ambiente que vai o
conteúdo do nosso documento.

O comando `\maketitle` é responsável por inserir o título, autor e data na
página inicial do artigo seguinto a formatação da classe `article`.

Todo o resto do conteúdo do ambiente `document` é o nosso texto.

## Comandos e ambientes úteis

Para escrever $\LaTeX$ eu utilizei o comando `\LaTeX` ;-)

### Ambiente matemático

Para escrever fórmulas matemáticas em $\LaTeX$ usamos o ambiente matemático.
Existem várias formas de usar o ambiente matemático:

* Equação na mesma linha do texto:
	`$x^2-2x+4=0$`

* Equação centralizada na página:
	`$$x^2-2x+4=0$$`
ou
	`\[x^2-2x+4=0\]`

* Equação centralizada e numerada:
	`\begin{equation}
		x^2-2x+4=0
	\end{equation}`

### Figuras

Para inserir figuras usamos o ambiente `figure`:
	`\begin{figure}[h]
		\includegraphics[scale=0.5]{arquivo_da_figura.png}
	\end{figure}`

O `[h]` (*here*) significa que a figura deve ser inserida naquele exato lugar.
Outras opções são `b` (*botton*) para inserir a figura na parte de baixo da
página ou `t` (*top*) para que a figura fique na parte superior da página.

O comando `scale=0.5` diz que a figura deve ser inserida com 50% do seu tamanho
original. Outras opções são `width=0.3` para que a figura tenha largura igual a
30% do seu tamanho original ou `height=0.7` para inserir a figura com 70% da
sua altura. Em todos os casos, a proporção entre altura e largura da figura é
mantida.

### Tabelas

Inserir tabelas no $\LaTeX$:
	`\begin{tabular}{c|c}
		\hline
		a & b \\
		\hline
		c & d \\
		\hline
	\end{tabular}`

O parâmetro `{c|c}` do ambiente `tabular` diz que nossa tabela terá duas
colunas centralizadas e uma linha vertical entre essas colunas. Para obter
outras formas de alinhamento usamos `r` (*right*, direita) ou `l` (*left*,
esquerda). O número de letras c (ou r ou l) indica a quantidade de colunas da
tabela.

O comando `\hline` é responsável por desenhar as linhas horizontais da tabela.

As celulas da tabela são separadas pelo `&`.
