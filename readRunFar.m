function t=readRunFar(file)
% return table containing data from input file
  fid=fopen(file,'r');
  % read the fullfile as cell array, convert to string array, ignore the FORTRAN formfeed
  c=textscan(fid,'%s','delimiter','\n','Whitespace','','CommentStyle','1','CollectOutput',0);
  fid=fclose(fid);
  c=string(c{:});
  ix=find(contains(c,"SUMMARY"))-1;       % get section starting lines
  N=numel(ix);                            % the number of sections in file
  iyr=find(contains(c,"YEARS"));          % the start of second column of data
  iyr=strfind(c(iyr(1)),"YEARS")-1;
  c(ix(2):end)=extractAfter(c(ix(2):end),iyr); % remove the TIME column after first set
  iend=find(char(c(end))~=' ',1,'last');  % find last data on last section
  d=c(1:ix(2)-1);                         % begin a new data array with first section
  for i=2:N-1                             % join subsequent sections to first
    d=strcat(d, c(ix(i):ix(i+1)-1));
  end
  temp = extractBefore(c(ix(N):end),iend+1);
  if length(temp)>length(d)
      temp(7)=[];
  end
  d=strcat(d, temp);
  d=d(4:end);                             % trash the beginning header lines
  d=d(~all(char(d)==' '|char(d)=='-' ,2));% and the other extraneous text
  data=str2num(char(d(4:end)));           % convert to numeric
  vnames=split(d(1));                     % get the variable names from header
  vnames=vnames(~(vnames==""));           % split() leaves empties...
  vnames=categorical(vnames,unique(vnames,'stable')); % create ordered categorical variable
  cats=categories(vnames);                % the category names for logical addressing
  t=table(data(:,1),'VariableNames',cats(1)); % initial table entry
  for i=2:numel(cats)                     % and build the output table
    t=[t table(data(:,vnames==cats(i)),'VariableNames',cats(i))];
  end
end
