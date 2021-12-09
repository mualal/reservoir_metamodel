%репрезентативный и нерепрезентативный латинские гиперкубы в двумерном пространстве (m=50)
%в следующей строке использована функция ihs(dim_num, point_num, duplication, seed) с сайта [10]. Но перед командой return в теле функции ihs добавлена строка x = x./point_num; с целью нормализации гиперкуба к диапазону [0;1]
lh_example1 = ihs(2, 50, 30, 5);
%нерепрезентативный латинский гиперкуб
lh_example2(1:2,1)=[0.02 0.02];
for i=2:50
lh_example2(1:2,i)=lh_example2(1:2,i-1)+0.02;
end
%визуализация гиперкубов
text_size_scale = 1.9;
font = 'Times New Roman';
figure('Position', [10 10 750 750], 'DefaultTextFontName', font, 'DefaultAxesFontName', font)
scatter(lh_example1(1,:),lh_example1(2,:),27,'filled','black','DisplayName','Репрезентативный')
hold on
scatter(lh_example2(1,:),lh_example2(2,:),27,'filled','r','DisplayName','Нерепрезентативный')
grid on
grid minor
title('2 латинских гиперкуба в двумерном пространстве')
xlabel('Параметр 1')
ylabel('Параметр 2')
xlim([0 1.02])
ylim([0 1.095])
legend
%в следующей строке использована функция supersizeme(varargin) с сайта [23] с целью увеличения шрифта текста
supersizeme(text_size_scale)
 
clear font i lh_example1 lh_example2 text_size_scale
