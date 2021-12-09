%Визуализация дебитов нефти для всех кейсов (сравнение: симулятор и метамодель)

%в следующей строке необходимо выбрать структуру с информацией о построенной нейросети, для которой проводится визуализация 
struct_net=struct_net1_trainscg1;
 
text_size_scale = 2;
font = 'Times New Roman';
figure('Position', [10 10 1100 700],'DefaultTextFontName',font,'DefaultAxesFontName',font)
net1 = struct_net.net;
subplot(1,2,1)
hold on
cases_count=length(struct_net.FOPR_target(1,:));
plot(struct_net.FOPR_target(1:end,1:cases_count));
text(2*length(struct_net.FOPR_target(:,1))/3,4*max(max(struct_net.FOPR_target))/5,'Сценарий 1','FontName',font,'FontSize',11)
title({'Дебит нефти от времени','для всех кейсов (симулятор)'})
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров в сутки')
grid on
grid minor
subplot(1,2,2)
hold on
plot(net1(struct_net.input(1:end,1:cases_count)))
text(2*length(struct_net.FOPR_target(:,1))/3,4*max(max(struct_net.FOPR_target))/5,{'P = '+string(length(struct_net.Dla_train)),'N^1 = '+string(struct_net.net.layers{1}.size)},'FontName',font,'FontSize',11)
title({'Дебит нефти от времени','для всех кейсов (метамодель)'})
xlabel('Номер месяца')
ylabel('Дебит нефти, кубометров в сутки')
grid on
grid minor
supersizeme(text_size_scale)
 
clear text_size_scale font net1 cases_count struct_net
