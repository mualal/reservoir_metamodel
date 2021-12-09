%Визуализация зависимости дебита нефти от времени и входных параметров нейросети (в движении)

%в следующей строке необходимо выбрать структуру с информацией о построенной нейросети, для которой проводится визуализация
struct_vis = struct_net1_trainscg1;

%нейросеть, для которой проводится визуализация
net_vis = struct_vis.net;

figure('Position', [10 10 1250 700])
for j=50:10:2000
clf
subplot(2,2,1)
hold on
flag=0;
str={};
slice_array=1:1:10;
color_array=jet(length(slice_array))/1.5;
for i=slice_array
new_result = net_vis([0.14;i;0.005;j]);
plot(new_result,'DisplayName',string(i),'Color',color_array(flag+1,:));
flag=flag+1;
str{flag}=string(i)+' мД';
end
title(compose('Пористость матрицы: 0.14; проницаемость матрицы указана в легенде;\n пористость трещин: 0.005; проницаемость трещин: '+string(j)+' мД'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
grid on
grid minor
leg=legend(str);
title(leg,{'P = '+string(length(struct_vis.Dla_train)),'N^1 = '+string(struct_vis.net.layers{1}.size)})
subplot(2,2,2)
hold on
flag=0;
str={};
for i=slice_array
new_result = net_vis([0.24;i;0.005;j]);
plot(new_result,'DisplayName',string(i),'Color',color_array(flag+1,:));
flag=flag+1;
str{flag}=string(i)+' мД';
end
title(compose('Пористость матрицы: 0.24; проницаемость матрицы указана в легенде;\n пористость трещин: 0.005; проницаемость трещин: '+string(j)+' мД'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
grid on
grid minor
leg=legend(str);
title(leg,{'P = '+string(length(struct_vis.Dla_train)),'N^1 = '+string(struct_vis.net.layers{1}.size)})
subplot(2,2,3)
hold on
flag=0;
str={};
for i=slice_array
new_result = net_vis([0.14;i;0.05;j]);
plot(new_result,'DisplayName',string(i),'Color',color_array(flag+1,:));
flag=flag+1;
str{flag}=string(i)+' мД';
end
title(compose('Пористость матрицы: 0.14; проницаемость матрицы указана в легенде;\n пористость трещин: 0.05; проницаемость трещин: '+string(j)+' мД'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
grid on
grid minor
leg=legend(str);
title(leg,{'P = '+string(length(struct_vis.Dla_train)),'N^1 = '+string(struct_vis.net.layers{1}.size)})
subplot(2,2,4)
hold on
flag=0;
str={};
for i=slice_array
new_result = net_vis([0.24;i;0.05;j]);
plot(new_result,'DisplayName',string(i),'Color',color_array(flag+1,:));
flag=flag+1;
str{flag}=string(i)+' мД';
end
title(compose('Пористость матрицы: 0.24; проницаемость матрицы указана в легенде;\n пористость трещин: 0.05; проницаемость трещин: '+string(j)+' мД'))
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров за сутки')
grid on
grid minor
leg=legend(str);
title(leg,{'P = '+string(length(struct_vis.Dla_train)),'N^1 = '+string(struct_vis.net.layers{1}.size)})
supersizeme(1.3)
drawnow
end

clear struct_vis net_vis j flag str slice_array color_array i new_result
clear leg 
