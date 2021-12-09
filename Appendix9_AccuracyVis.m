%Визуализация истории процесса обучения (функции потерь) и размаха ошибок прогноза нейронной сети

%в следующей строке необходимо выбрать структуру с информацией о построенной нейросети, для которой проводится визуализация 
struct_net=struct_net1_trainscg1;
 
text_size_scale = 1.7;
font = 'Times New Roman';
figure('Position', [10 10 600 600],'DefaultTextFontName',font,'DefaultAxesFontName',font)
plotperform(struct_net.tr)
text(struct_net.tr.num_epochs/3,struct_net.tr.perf(1,1)/10,{'P = '+string(length(struct_net.Dla_train)),'N^1 = '+string(struct_net.net.layers{1}.size)},'FontName',font,'FontSize',11)
title({'Наименьшее значение на валидационной выборке составляет ',string(struct_net.valPerformance)+' и достигается на '+string(struct_net.tr.best_epoch)+' эпохе'})
xlabel('Номер эпохи (всего '+string(struct_net.tr.num_epochs)+')','FontSize',12,'FontWeight','bold')
ylabel('Среднеквадратичная ошибка (mse)','FontSize',12,'FontWeight','bold')
legend('Обучающая выборка','Валидационная выборка','Тестовая выборка','Лучшее значение при валидации')
grid on
grid minor
supersizeme(text_size_scale)
 

errors = -struct_net.e_rel;
%errors = -struct_net.e_rel(:,input(4,:)>400 & input(3,:)>0.01);
figure('Position', [10 10 1200 700],'DefaultTextFontName',font,'DefaultAxesFontName',font)
b=boxchart(errors(2:length(errors(:,1)),1:length(errors(1,:)))');
b.MarkerStyle='*';
b.MarkerColor='#ABADAE';
b.BoxFaceColor = 'black';
text(length(struct_net.FOPR_test(:,1))/2,round(max(max(errors)),-1),{'P = '+string(length(struct_net.Dla_train)),'N^1 = '+string(struct_net.net.layers{1}.size)},'FontName',font,'FontSize',12)
title('Диаграмма размаха ошибок прогноза метамодели','FontSize',15)
xlabel('Номер месяца','FontWeight','bold','FontSize',14)
ylabel('Ошибка, в процентах','FontWeight','bold','FontSize',14)
grid on
grid minor
ylim([round(min(min(errors)),-1)-10 round(max(max(errors)),-1)+50])
supersizeme(text_size_scale)
 
clear struct_net text_size_scale font errors b
