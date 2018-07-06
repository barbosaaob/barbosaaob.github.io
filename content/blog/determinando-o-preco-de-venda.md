title: Determinando o preço de um produto
tags: math
category: blog
date: 2018-07-06 08:50
modified: 2018-07-06 08:50

Suponha que um vendedor de paçoca venda seu produto a R&#36; 5,00 e que no
mês de junho, durante as festas juninas, ele fez uma promoção e vendeu cada
paçoca a R&#36; 4,00. Nesse período ele notou que vendeu 30 unidades a mais que as
100 que costumava vender por mês.

Como podemos ajudar nosso amigo vendedor a determinar o preço da paçoca de modo
a obter o maior faturamento possível? De outro modo, qual deve ser o desconto ideal para
que a faturamento do vendedor seja máximo?

Vamos assumir que a relação entre o preço e o número de unidades vendidas se
mantenha, ou seja, que cada R&#36; 1,00 de desconto resulte em 30 unidades vendidas a
mais. Vejamos alguns números:

| Preço unitário  | Vendas | Faturamento do mês |
|-----------------|--------|--------------------|
| R$ 2,00         | 190    | R$ 380,00          |
| R$ 3,00         | 160    | R$ 480,00          |
| R$ 4,00         | 130    | R$ 520,00          |
| **R$ 5,00**         | **100**    | **R$ 500,00**          |
| R$ 6,00         | 70     | R$ 420,00          |
| R$ 7,00         | 40     | R$ 280,00          |

Observe que são vendidas $100+30x$ unidades sempre que reduzimos $x$ reais
no preço unitário da paçoca. Dessa forma, se o preço unitário for $5-x$, serão vendidos
$100+30x$ unidades e o faturamento será de $(100+30x)(5-x)$ reais.

Como

$$(100+30x)(5-x) = 500-100x+150x-30x^2 = 500+50x-30x^2$$

a função quadrática $F(x) = 500+50x-30x^2$ nos dá o faturamento obtido a cada $x$
reais de desconto no preço inicial de R$ 5,00.

Para resolver nosso problema, basta descobrir para qual valor de $x$ (desconto
ideal) a função $F$ atinge seu valor máximo (maior faturamento possível).
Completanto o quadrado:

$$F(x) = 500+50x-30x^2 = -30\left(x-\frac{5}{6}\right)^2 + \frac{3125}{6}$$

Mas, $\left(x-\frac{5}{6}\right)^2 \ge 0$, pois o quadrado de qualquer número real é sempre $\ge 0$.
Assim, $-30\left(x-\frac{5}{6}\right)^2 \le 0$ qualquer que seja o número real
$x$.

Logo, o maior valor alcançado por $F$ é
$\frac{3125}{6} \approx 520,83$ e é obtido quando $-30\left(x-\frac{5}{6}\right)^2=0 \Rightarrow
x=\frac{5}{6} \approx 0,83$.

Portanto, ao dar um desconto de R&#36; 0,83, ou seja, ao vender suas paçocas a
R&#36; 4,17, nosso amigo vendedor obterá o maior faturamento possível ao final do mês.
