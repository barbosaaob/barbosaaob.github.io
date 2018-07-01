title: Determinando o preço de venda
tags: math
category: blog
date: 2018-07-01 14:00
modified: 2018-07-01 14:00
status: draft

Suponha que um vendedor de paçoca venda seu produto a R&#36; 5,00 e que durante o
mês de junho, durante as festas juninas, ele fez uma promoção e vendeu cada
paçoca a R&#36; 4,00. Nesse período ele notou que vendeu 30 unidades a mais que as
100 que costumava vender por mês.

Como podemos ajudar nosso amigo vendedor a determinar o preço da paçoca de modo
a obter a maior receita possível? Ou seja, qual deve ser o desconto ideal para
que a receita seja máxima?

Vamos assumir que essa relação entre o preço e o número de unidades vendidas se
mantenha, ou seja, que cada R$ 1,00 de desconto resulte em 30 unidades vendidas a
mais. Alguns números:

| Preço unitário  | Vendas | Receita do mês |
|-----------------|--------|----------------|
| R$ 2,00         | 190    | R$ 380,00      |
| R$ 3,00         | 160    | R$ 480,00      |
| R$ 4,00         | 130    | R$ 520,00      |
| R$ 5,00         | 100    | R$ 500,00      |
| R$ 6,00         | 70     | R$ 420,00      |
| R$ 7,00         | 40     | R$ 280,00      |

A tabela indica que são vendidas $100+30x$ unidades sempre que reduzimos $x$ reais
no preço unitário. Dessa forma, se o preço unitário for $5-x$, serão vendidos
$100+30x$ unidades e a receita será de $(100+30x)(5-x)$.

Como

$$(100+30x)(5-x) = 500-100x+150x-30x^2 = 500+50x-30x^2$$

a função quadrática $R(x) = 500+50x-30x^2$ nos dá a receita obtiva a cada $x$
reais de desconto no preço inicial de R$ 5,00.

Para resolver nosso problema, basta determinar o maior valor possível para essa
função. Observe que:

$$R(x) = 500+50x-30x^2 = -30\left(x-\frac{5}{6}\right)^2 + \frac{3125}{6}$$

Mas $\left(x-\frac{5}{6}\right)^2 \ge 0 \Rightarrow -30\left(x-\frac{5}{6}\right)^2 \le 0$ qualquer que
seja o número real $x$. Logo, o maior valor alcançado por $R(x)$ é
$\frac{3125}{6} \approx 520,83$, obtido quando $\left(x-\frac{5}{6}\right)^2=0 \Rightarrow
x=\frac{5}{6} \approx 0,83$.

Portanto, ao dar um desconto de R&#36; 0,83, ou seja, ao vender o produto a
R&#36; 4,17, nosso amigo vendedor obterá a maior receita possível ao vender
suas paçocas.
