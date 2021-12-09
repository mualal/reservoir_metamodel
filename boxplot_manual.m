text_size_scale = 1.7;
font = 'Times New Roman';
errors = [-1.1 -0.75 -0.12 -0.1 0 0.1 0.12 0.3 0.9 1];
%errors = -struct_net.e_rel(:,input(4,:)>400 & input(3,:)>0.01);
figure('Position', [10 10 1200 700],'DefaultTextFontName',font,'DefaultAxesFontName',font)
b=boxchart(errors(1:length(errors(:,1)),1:length(errors(1,:)))');
b.MarkerStyle='*';
b.MarkerColor='#ABADAE';
b.BoxFaceColor = 'black';
text(1,1.1,'Выброс','FontName',font,'FontSize',12)
text(1,-1.2,'Выброс','FontName',font,'FontSize',12)
text(1.26,0.05,'медиана q_2','FontName',font,'FontSize',12)
text(1.26,-0.16,'первый квартиль q_1','FontName',font,'FontSize',12)
text(1.26,0.3,'третий квартиль q_3','FontName',font,'FontSize',12)
text(1.14,0.9,'$q_3+1.5\cdot(q_3-q_1)$','Interpreter','latex','FontName',font,'FontSize',12)
text(1.14,-0.75,'$q_1-1.5\cdot(q_3-q_1)$','Interpreter','latex','FontName',font,'FontSize',12)
text(0.53,1.4,'Построена для набора [-1.1 -0.75 -0.12 -0.1 0 0.1 0.12 0.3 0.9 1]','FontName',font,'FontSize',12)
title('Диаграмма размаха ошибок','FontSize',12)
xlabel('Номер месяца','FontWeight','bold','FontSize',14)
ylabel('Ошибка, в процентах','FontWeight','bold','FontSize',14)
grid on
grid minor
ylim([-15 15]/10)
supersizeme(text_size_scale)

corrplot(input')