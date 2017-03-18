function [L, U] = lu2(A)
% entrada: matriz aumentada
% Exemplo:
% A = [1, -1, 2, -1,  -8;
%      2, -2, 3, -3, -20;
%      1,  1, 1,  0,  -2;
%      1, -1, 4,  3,   4];
n = size(A, 1);
tol = 1e-5;  % tolerancia

% saida
L = eye(size(A));
U = zeros(size(A));

% calculando
for i = 1:n-1
    % busca uma linha com diagonal nao nula
    existe_dec = false;
    for p = i:n
        if (abs(A(p, i)) > tol)
            existe_dec = true;
            break;
        end
    end
    % se nao existir tal linha, saia
    if (existe_dec == false)
        disp('nao eh possivel aplicar a decomposicao');
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
        L(j, i) = A(j, i) / A(i, i);
        A(j, :) = A(j, :) - L(j, i).*A(i, :);
    end
end
if (abs(A(n, n)) < tol)
    disp('nao eh possivel aplicar a decomposicao');
    x = NaN;
    return;
end

U = A;
