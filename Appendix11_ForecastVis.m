%Визуализация зависимостей дебита нефти при варьировании одного из входных параметров

tic

text_size_scale = 2;
font = 'Times New Roman';

%в следующих двух строках необходимо выбрать структуры с информацией о нейросетях, для которых будет проводиться визуализация
struct1 = struct_net1_trainscg1;
struct2 = struct_net1_trainscg2;

%нейросети из выбранных структур
net1 = struct1.net; %первая нейросеть, для которой проводится визуализация
net2 = struct2.net; %вторая нейросеть, для которой проводится визуализация

%выбранные значения входных параметров, если они не варьируются
poro_matrix = 0.2;
perm_matrix = 5;
poro_crack = 0.02;
perm_crack = 1500;

%варьируется пористость матрицы
figure('Position', [10 10 1300 850],'DefaultTextFontName',font,'DefaultAxesFontName',font)
subplot(1,2,1)
hold on
slice_array=0.14:0.005:0.24;
color_array=jet(length(slice_array))/1.5;
flag=0;
for i=slice_array
    flag=flag+1;
    new_result = net1([i;perm_matrix;poro_crack;perm_crack]);
    plot(0:length(new_result)-1,new_result,'DisplayName',string(i),'Color',color_array(flag,:));
end
text(2*length(struct1.FOPR_target(:,1))/3,4*max(new_result)/5,{'P = '+string(length(struct1.Dla_train)),'N^1 = '+string(struct1.net.layers{1}.size)},'FontName',font,'FontSize',11)
title(compose('Графики зависимости дебитов от времени при \n варьировании пористости матрицы'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
xlim([0,60])
grid on
grid minor
leg = legend('show');
leg.FontSize = 7;
title(leg,compose('Пористость \n матрицы'))
 
subplot(1,2,2)
hold on
slice_array=0.14:0.005:0.24;
color_array=jet(length(slice_array))/1.5;
flag=0;
for i=slice_array
    flag=flag+1;
    new_result = net2([i;perm_matrix;poro_crack;perm_crack]);
    plot(0:length(new_result)-1,new_result,'DisplayName',string(i),'Color',color_array(flag,:));
end
text(2*length(struct2.FOPR_target(:,1))/3,4*max(new_result)/5,{'P = '+string(length(struct2.Dla_train)),'N^1 = '+string(struct2.net.layers{1}.size)},'FontName',font,'FontSize',11)
title(compose('Графики зависимости дебитов от времени при \n варьировании пористости матрицы'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
xlim([0,60])
grid on
grid minor
leg = legend('show');
leg.FontSize = 7;
title(leg,compose('Пористость \n матрицы'))
supersizeme(text_size_scale)
 
%варьируется проницаемость матрицы
figure('Position', [10 10 1300 850],'DefaultTextFontName',font,'DefaultAxesFontName',font)
subplot(1,2,1)
hold on
slice_array=0.9:0.455:10;
color_array=jet(length(slice_array))/1.5;
flag=0;
for i=slice_array
    flag=flag+1;
    new_result = net1([poro_matrix;i;poro_crack;perm_crack]);
    plot(0:length(new_result)-1,new_result,'DisplayName',string(i)+' мД','Color',color_array(flag,:));
end
text(2*length(struct1.FOPR_target(:,1))/3,4*max(new_result)/5,{'P = '+string(length(struct1.Dla_train)),'N^1 = '+string(struct1.net.layers{1}.size)},'FontName',font,'FontSize',11)
title(compose('Графики зависимости дебитов от времени при \n варьировании проницаемости матрицы'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
xlim([0,60])
grid on
grid minor
leg = legend('show');
leg.FontSize = 7;
title(leg,compose('Проницаемость \n матрицы'))
 
subplot(1,2,2)
hold on
slice_array=0.9:0.455:10;
color_array=jet(length(slice_array))/1.5;
flag=0;
for i=slice_array
    flag=flag+1;
    new_result = net2([poro_matrix;i;poro_crack;perm_crack]);
    plot(0:length(new_result)-1,new_result,'DisplayName',string(i)+' мД','Color',color_array(flag,:));
end
text(2*length(struct2.FOPR_target(:,1))/3,4*max(new_result)/5,{'P = '+string(length(struct2.Dla_train)),'N^1 = '+string(struct2.net.layers{1}.size)},'FontName',font,'FontSize',11)
title(compose('Графики зависимости дебитов от времени при \n варьировании проницаемости матрицы'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
xlim([0,60])
grid on
grid minor
leg = legend('show');
leg.FontSize = 7;
title(leg,compose('Проницаемость \n матрицы'))
supersizeme(text_size_scale)
 
%варьируется пористость трещин
figure('Position', [10 10 1300 850],'DefaultTextFontName',font,'DefaultAxesFontName',font)
subplot(1,2,1)
hold on
slice_array=0.005:0.0025:0.05;
color_array=jet(length(slice_array))/1.5;
flag=0;
for i=slice_array
    flag=flag+1;
    new_result = net1([poro_matrix;perm_matrix;i;perm_crack]);
    plot(0:length(new_result)-1,new_result,'DisplayName',string(i),'Color',color_array(flag,:));
end
text(2*length(struct1.FOPR_target(:,1))/3,4*max(new_result)/5,{'P = '+string(length(struct1.Dla_train)),'N^1 = '+string(struct1.net.layers{1}.size)},'FontName',font,'FontSize',11)
title(compose('Графики зависимости дебитов от времени при \n варьировании пористости трещин'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
xlim([0,60])
grid on
grid minor
leg = legend('show');
leg.FontSize = 7;
title(leg,compose('Пористость \n трещин'))
 
subplot(1,2,2)
hold on
slice_array=0.005:0.0025:0.05;
color_array=jet(length(slice_array))/1.5;
flag=0;
for i=slice_array
    flag=flag+1;
    new_result = net2([poro_matrix;perm_matrix;i;perm_crack]);
    plot(0:length(new_result)-1,new_result,'DisplayName',string(i),'Color',color_array(flag,:));
end
text(2*length(struct2.FOPR_target(:,1))/3,4*max(new_result)/5,{'P = '+string(length(struct2.Dla_train)),'N^1 = '+string(struct2.net.layers{1}.size)},'FontName',font,'FontSize',11)
title(compose('Графики зависимости дебитов от времени при \n варьировании пористости трещин'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
xlim([0,60])
grid on
grid minor
leg = legend('show');
leg.FontSize = 7;
title(leg,compose('Пористость \n трещин'))
supersizeme(text_size_scale)
 
%варьируется проницаемость трещин
figure('Position', [10 10 1300 850],'DefaultTextFontName',font,'DefaultAxesFontName',font)
subplot(1,2,1)
hold on
slice_array=50:65:2000;
color_array=jet(length(slice_array))/1.5;
flag=0;
for i=slice_array
    flag=flag+1;
    new_result = net1([poro_matrix;perm_matrix;poro_crack;i]);
    plot(0:length(new_result)-1,new_result,'DisplayName',string(i)+' мД','Color',color_array(flag,:));
end
text(2*length(struct1.FOPR_target(:,1))/3,4*max(new_result)/5,{'P = '+string(length(struct1.Dla_train)),'N^1 = '+string(struct1.net.layers{1}.size)},'FontName',font,'FontSize',11)
title(compose('Графики зависимости дебитов от времени при \n варьировании проницаемости трещин'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
xlim([0,60])
grid on
grid minor
leg = legend('show');
leg.FontSize = 6;
title(leg,compose('Проницаемость \n трещин'))
 
subplot(1,2,2)
hold on
slice_array=50:65:2000;
color_array=jet(length(slice_array))/1.5;
flag=0;
for i=slice_array
    flag=flag+1;
    new_result = net2([poro_matrix;perm_matrix;poro_crack;i]);
    plot(0:length(new_result)-1,new_result,'DisplayName',string(i)+' мД','Color',color_array(flag,:));
end
text(2*length(struct2.FOPR_target(:,1))/3,4*max(new_result)/5,{'P = '+string(length(struct2.Dla_train)),'N^1 = '+string(struct2.net.layers{1}.size)},'FontName',font,'FontSize',11)
title(compose('Графики зависимости дебитов от времени при \n варьировании проницаемости трещин'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
xlim([0,60])
grid on
grid minor
leg = legend('show');
leg.FontSize = 6;
title(leg,compose('Проницаемость \n трещин'))
supersizeme(text_size_scale)

toc

clear slice_array color_array flag new_result leg i text_size_scale 
clear font struct1 struct2 net1 net2 poro_matrix perm_matrix
clear poro_crack perm_crack
