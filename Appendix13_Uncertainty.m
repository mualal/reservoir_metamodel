zMonte_n=1e+6;
net_Monte=struct_net1_trainscg1.net;
 
%zMonte_poro_matrix = ((randn(zMonte_n,1)*0.01)+0.2)';
zMonte_poro_matrix_distr = makedist('Triangular','a',0.17,'b',0.2,'c',0.2);
zMonte_poro_matrix = random(zMonte_poro_matrix_distr,zMonte_n,1)';
 
%zMonte_perm_matrix = ((randn(zMonte_n,1)*1)+6)';
zMonte_perm_matrix_distr = makedist('Normal','mu',6,'sigma',0.5);
zMonte_perm_matrix = random(zMonte_perm_matrix_distr,zMonte_n,1)';
 
%zMonte_poro_crack = ((randn(zMonte_n,1)*0.004)+0.03)';
zMonte_poro_crack_distr = makedist('Uniform','lower',0.03,'upper',0.04);
zMonte_poro_crack = random(zMonte_poro_crack_distr,zMonte_n,1)';
 
%zMonte_perm_crack = ((randn(zMonte_n,1)*40)+1000)';
zMonte_perm_crack_distr = makedist('Triangular','a',1200,'b',1200,'c',1400);
zMonte_perm_crack = random(zMonte_perm_crack_distr,zMonte_n,1)';
 
text_size_scale = 1.7;
font = 'Times New Roman';
figure('Position', [10 10 1000 800],'DefaultTextFontName',font,'DefaultAxesFontName',font)
subplot(2,2,1)
histogram(zMonte_poro_matrix,30);
title(compose('Распределение значений \n пористости матрицы'))
ylabel({'Количество значений','в диапазонах'})
xlabel('Диапазоны')
grid on
grid minor
subplot(2,2,2)
histogram(zMonte_perm_matrix,30);
title(compose('Распределение значений \n проницаемости матрицы'))
ylabel({'Количество значений','в диапазонах'})
xlabel('Диапазоны, мД')
grid on
grid minor
subplot(2,2,3)
histogram(zMonte_poro_crack,30);
title(compose('Распределение значений \n пористости трещин'))
ylabel({'Количество значений','в диапазонах'})
xlabel('Диапазоны')
grid on
grid minor
subplot(2,2,4)
histogram(zMonte_perm_crack,30);
title(compose('Распределение значений \n проницаемости трещин'))
ylabel({'Количество значений','в диапазонах'})
xlabel('Диапазоны, мД')
grid on
grid minor
supersizeme(text_size_scale)
 
text_size_scale = 2;
tic
zMonte_result = sum(net_Monte([zMonte_poro_matrix;zMonte_perm_matrix;zMonte_poro_crack;zMonte_perm_crack]));
toc
figure('Position', [10 10 800 800],'DefaultTextFontName',font,'DefaultAxesFontName',font)
histogram(zMonte_result,30);
xlim([1.15 1.5]*1E+4)
ylim([0 8.5]*1E+4)
title('Гистограмма сумм дебитов')
ylabel('Количество значений в диапазонах')
xlabel('Диапазоны сумм дебитов, кубометров в сутки')
grid on
grid minor
supersizeme(text_size_scale)
