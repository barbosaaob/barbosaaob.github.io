% entrada
f = @(t, y) y - t^2 + 1;  % y' = f(t, y)
a = 0;                    % inicio do intervalo
b = 2;                    % fim do intervalo
N = 10;                   % numero de divisoes no intervalo
y0 = 0.5;                 % condicao inicial

% inicializacao
h = (b - a) / N;
t = a;
w = y0;
disp([t, w]);

% calculo
for i = 1:N
    w = w + h * f(t, w);  % calcula w_i
    t = a + i * h;        % calcula t_i
    disp([t, w]);
endfor
