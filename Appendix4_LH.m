%генерируется выборка методом латинского гиперкуба
%Варьируются: пористость матрицы, проницаемость матрицы, пористость трещин, проницаемость трещин

points_train = 400; %количество точек для обучения метамодели 
N_train = 4; %количество варьируемых параметров
lb_train = [0.14 0.9 0.005 50]; %нижние границы диапазонов каждого из варьируемых параметров
ub_train = [0.24 10 0.05 2000]; %верхние границы диапазонов каждого из варьируемых параметров
%в следующей строке использована функция ihs(dim_num, point_num, duplication, seed) с сайта [10]. Однако перед командой return в теле функции ihs добавлена строка x = x./point_num; с целью нормализации гиперкуба к диапазону [0;1] 
Xla_train = ihs(N_train, points_train, 5, 7)'; %гиперкуб, нормализованный к диапазону [0;1]
Dla_train = bsxfun(@plus,lb_train,bsxfun(@times,Xla_train,(ub_train-lb_train))); %гиперкуб в пространстве варьируемых параметров

points_valid = 100; %количество точек для валидации метамодели
N_valid = 4; 
lb_valid = [0.14 0.9 0.005 50];
ub_valid = [0.24 10 0.05 2000];
Xla_valid = ihs(N_valid, points_valid, 5, 7)';
Dla_valid = bsxfun(@plus,lb_valid,bsxfun(@times,Xla_valid,(ub_valid-lb_valid)));
 

points_test = 800; %количество точек для тестирования метамодели
N_test = 4; 
lb_test = [0.14 0.9 0.005 50];
ub_test = [0.24 10 0.05 2000];
Xla_test = ihs(N_test, points_test, 5, 7)';
Dla_test = bsxfun(@plus,lb_test,bsxfun(@times,Xla_test,(ub_test-lb_test)));

%объединение данных в таблицу, которая будет подаваться в качестве входных данных при обучении метамодели
input = [Dla_train' Dla_valid' Dla_test']; 
 

%визуализация проекций латинских гиперкубов на трёхмерное пространство
text_size_scale = 1.9;
font = 'Times New Roman';
figure('DefaultTextFontName',font,'DefaultAxesFontName',font)
scatter3(Dla_train(:,1),Dla_train(:,2),Dla_train(:,4),'b','DisplayName','Обучающая выборка')
hold on
scatter3(Dla_valid(:,1),Dla_valid(:,2),Dla_valid(:,4),'g','DisplayName','Валидационная выборка')
hold on
scatter3(Dla_test(:,1),Dla_test(:,2),Dla_test(:,4),'r','DisplayName', 'Тестовая выборка')
title('Проекции латинских гиперкубов на трёхмерное пространство')
xlabel('Пористость матрицы, в долях единицы')
ylabel('Проницаемость матрицы, мДарси')
zlabel('Проницаемость трещин, мДарси')
legend
%в следующей строке использована функция supersizeme(varargin) с сайта [23] с целью увеличения шрифта текста
supersizeme(text_size_scale)

%очистка параметров, которые не будут использоваться в дальнейшем
clear points_test points_train points_valid N_test N_train N_valid font text_size_scale
