function x = gauss(A)
% entrada: matriz aumentada
% Exemplo:
% A = [1, -1, 2, -1,  -8;
%      2, -2, 3, -3, -20;
%      1,  1, 1,  0,  -2;
%      1, -1, 4,  3,   4];
[n, m] = size(A);
tol = 1e-5;  % tolerancia

% saida
x = zeros(n, 1);  % solucao do sistema

% calculando
for i = 1:n-1
    % busca uma linha com diagonal nao nula
    existe_sol = false;
    for p = i:n
        if (abs(A(p, i)) > tol)
            existe_sol = true;
            break;
        end
    end
    % se nao existir tal linha, saia
    if (existe_sol == false)
        disp('nao existe solucao unica.');
        x = NaN;
        return;
    end
    % se a linha atual tem diagonal nula, troque linhas
    if (p != i)
        aux = A(i, :);
        A(i, :) = A(p, :);
        A(p, :) = aux;
    end
    % efetua a eliminacao referente a linha
    for j = i+1:n
        m = A(j, i) / A(i, i);
        A(j, :) = A(j, :) - m.*A(i, :);
    end
end
if (abs(A(n, n)) < tol)
    disp('nao existe solucao unica.')
    x = NaN;
    return;
end

% back substitution
x(n) = A(n, n+1) / A(n, n);
for i = n-1:-1:1
    s = 0;
    for j = i+1:n
        s = s + A(i, j) * x(j);
    end
    x(i) = (A(i, n+1) - s) / A(i, i);
end
