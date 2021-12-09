%создаются файлы для расчёта в гидродинамическом симуляторе (этот код запускается 3 раза, при каждом запуске вручную меняются только значения sampling (= Dla_train, = Dla_valid или = Dla_test) и folder_number (= 1, = 2 или = 3)). После третьего запуска необходимо сохранить Workspace в текущую папку командой save('1'), чтобы в дальнейшем не потерять сгенерированные данные
sampling = Dla_train; %Dla_train - обучающая выборка, сгенерированная методом латинского гиперкуба на предыдущем этапе и находящаяся в Workspace 
folder_number = 1; %номер-название папки, куда будут помещаться сгенерированные файлы
 
cases_count = length(sampling); %количество файлов для генерации


%генерация файла для командной строки. Файл необходим, чтобы все сгенерированные файлы запускались на расчёт в симулятор автоматически из командной строки
for i=1:cases_count
    cmd_matrix(i,1)={'C:\ecl\2017.1\bin\pc_x86_64\eclipse'};
    cmd_matrix{i,1}=cmd_matrix{i,1}+"  D"+string(i);
end
 
mkdir(string(folder_number)); %создание новой папки

writecell(cmd_matrix,string(folder_number)+'/'+string(folder_number),'QuoteStrings',false);
 
fileList=dir([string(folder_number)+'/*.txt']);
file = fullfile(fileList(1).folder, fileList(1).name);
[tempDir, tempFile] = fileparts(file);
status = copyfile(file, fullfile(tempDir, [tempFile, '.cmd']));
delete(file)
 
 
%чтение файла-шаблона, хранящего в себе всю информацию (о гидродинамической модели), необходимую для расчёта на симуляторе 
file_exp = textread('D_template1.DATA', '%s', 'delimiter', '\n', ...
                'whitespace', '');

%далее в файле-шаблоне заменяются строки, содержащие информацию о значениях варьируемых параметров (подставляются значения из латинского гиперкуба). В цикле происходит сохранение файлов для последующего расчёта на симуляторе
for i=1:cases_count
    %номера строк 59, 61, 63, 73, 75 и 77 соответствуют файлу-шаблону в приложении 1
    file_exp{59,1}="'PORO'  "+string(sampling(i,1))+"   /";
    file_exp{61,1}="'PERMX'  "+string(sampling(i,2))+"   /";
    file_exp{63,1}="'PERMY'  "+string(sampling(i,2))+"   /";
    file_exp{73,1}="'PORO'  "+string(sampling(i,3))+"   /";
    file_exp{75,1}="'PERMX'  "+string(sampling(i,4))+"   /";
    file_exp{77,1}="'PERMY'  "+string(sampling(i,4))+"   /";
    writecell(file_exp,string(folder_number)+"/D"+string(i)+".dat",'QuoteStrings',false);
    
end
 
 
%файлы сохранились в формате .dat. Меняем на .DATA
fileList=dir([string(folder_number)+'/*.dat']);
 
for i = 1:numel(fileList)
    file = fullfile(fileList(i).folder, fileList(i).name);
    [tempDir, tempFile] = fileparts(file);
    status = copyfile(file, fullfile(tempDir, [tempFile, '.DATA']));
    delete(file)
end


%очистка параметров, которые не будут использоваться в дальнейшем
clear cases_count cmd_matrix file file_exp fileList folder_number
clear i sampling status tempDir tempFile
