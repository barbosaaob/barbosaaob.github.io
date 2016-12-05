% entrada
P = [2, 0, -3, 3, -4];  % coeficientes a_n, a_n-1, ..., a_0 de P
x0 = -2;                % valor para avaliar P

% saida
% y = P(x0)
% z = Q(x0)

% calculando
n = length(P);  % indice do ultimo coeficiente
y = P(1);  % calcule b_n para P
z = P(1);  % calcule b_n-1 para Q
for j = 2:n-1
    y = x0 * y + P(j);
    z = x0 * z + y;
end
y = x0 * y + P(n);
disp([y, z]);