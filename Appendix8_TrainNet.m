x = input; %входной вектор нейронной сети
t = FOPR_target; %вектор целевых значений на выходе нейронной сети
 
net = network; %инициализация нейронной сети
net.name = 'Метамодель для предсказания дебитов нефти (FOPR)';
 
net.numInputs = 1; %количество входных параметров нейронной сети (один вектор)

net.numLayers = 2; %количество слоёв нейронной сети
 
net.biasConnect = [1; 1]; %связи векторов отклонений
net.inputConnect = [1; 0]; %связи входного слоя
net.layerConnect = [0 0; 1 0]; %связи между слоями
net.outputConnect = [0 1]; %связи выходного слоя
 
net.inputs{1}.name='Вход'; %название входа
net.inputs{1}.exampleInput=input(:,1); %пример структуры входного вектора
net.inputs{1}.range=[lb_train;ub_train]'; %диапазоны варьирования каждого значения во входном векторе
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'}; %применяемые методы предобработки входного вектора
 
net.layers{1}.name='Скрытый слой'; %название первого слоя нейронной сети
net.layers{1}.size=30; %количество нейронов на первом слое
net.layers{1}.transferFcn='tansig'; %функция активации первого слоя
net.layers{1}.initFcn='initnw'; %функция инициализации значений (перед обучением) на первом слое
 
net.layers{2}.name='Выходной слой'; %название второго слоя нейронной сети
net.layers{2}.size=60; %количество нейронов на втором слое
net.layers{2}.transferFcn='tansig'; %функция активации второго слоя
net.layers{2}.initFcn='initnw'; %функция инициализации значений (перед обучением) на втором слое
 
net.outputs{2}.name='Выход'; %название выхода
net.outputs{2}.processFcns={'removeconstantrows','mapminmax'}; %применяемые методы предобработки выходного вектора
 
net.adaptFcn = 'adaptwb';
net.derivFcn = 'defaultderiv';

%Способ разделения получаемых на обучение данных на выборки (обучающую, валидационную и тестовую)
net.divideFcn = 'divideind';
net.divideMode = 'sample';
net.divideParam.trainInd = 1:length(Dla_train(:,1));
net.divideParam.valInd = length(Dla_train(:,1))...
    +1:length(Dla_train(:,1))+length(Dla_valid(:,1));
net.divideParam.testInd = length(Dla_train(:,1))+length(Dla_valid(:,1))+...
    1:length(Dla_train(:,1))+length(Dla_valid(:,1))+length(Dla_test(:,1));
 
net.initFcn = 'initlay';
net.performFcn = 'mse'; %функция потерь
net.performParam.regularization = 0; %коэффициент регуляризации
net.performParam.normalization = 'none'; %нормализация ошибок относительно целевых данных
net.plotFcns = {'plotperform', 'plottrainstate', 'ploterrhist',...
    'plotregression', 'plotfit'}; %графики, генерируемые в процессе обучения
net.trainFcn='trainscg'; %метод обучения нейронной сети (метод масштабируемых сопряжённых градиентов)
net.trainParam.epochs=50000; %максимальное количество эпох
net.trainParam.max_fail=1000; %максимальное количество неудач улучшения прогноза на валидационной выборке
 
% Обучение нейронной сети
[net,tr] = train(net,x,t);
 
% Анализ точности построенной нейронной сети
y = net(x); %прогноз
e = gsubtract(t,y); %разность целевых и предсказанных значений
performance = perform(net,t,y) %mse
 
% Перерасчёт ошибки прогноза (mse) для обучающей, валидационной и тестовой выборок
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y)
valPerformance = perform(net,valTargets,y)
testPerformance = perform(net,testTargets,y)

%Относительная ошибка прогноза
e_rel=-e./t*100;

%Гистограмма относительных ошибок для всех предсказанных значений (на обучающей+валидационной+тестовой выборках)
figure
ploterrhist(e_rel);

%Диаграмма размаха для всех предсказанных значений (на обучающей+валидационной+тестовой выборках)
figure
boxplot(e_rel(1:length(t(:,1)),1:length(t(1,:)))')

%Сохранение всех данных о построенной нейронной сети в структуру в Workspace
network_name = 'temp1'; %название файла с данными (временный файл)
save(network_name,'-regexp','^(?!struct_.*$).'); %сохранение файла (всё из Workspace, кроме struct_)
struct_net1_trainscg1 = load(network_name); %загрузка файла в Workspace в виде структуры. При очередной попытке обучения метамодели название переменной необходимо изменить для её отдельного сохранения, а не перезаписи имеющейся
delete temp1.mat; %удаление файла
clearvars -except struct* %удаление всех переменных из Workspace, кроме struct_
load('1.mat') %загрузка исходных данных для дальнейших попыток обучения метамодели

%Просмотр архитектуры нейронной сети
% struct_vis = struct_net1_trainscg1
% view(struct_vis.net)

%Просмотр графиков, генерируемых в процессе обучения
%figure, plotperform(struct_vis.tr)
%figure, plottrainstate(struct_vis.tr)
%figure, ploterrhist(struct_vis.e)
%figure, plotregression(struct_vis.t,struct_vis.y)
%figure, plotfit(struct_vis.net,struct_vis.x,struct_vis.t)
