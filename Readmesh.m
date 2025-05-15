%%%%%%%%%%%  读取inp文件模型信息 %%%%%%%%%%%%
%该程序可读取多种类型单元(三角形、四边形、三棱柱、六面体)的节点及单元信息
%Nodes：n行a列的矩阵(n为模型节点总数，a为模型维度）。以三维为例，每一行代表一个节点的编号，X，Y，Z坐标(例如：第n行代表第n个节点的坐标)
%Elements：m行b列的矩阵(m为模型单元总数，b为单元节点数量)。每一行代表用于组成单元的节点编号(编号顺序为等参元节点顺序)
%fname：字符串类型。代表读取文件的名称(例如：sanjiao.inp)，不要丢掉扩展名（.inp）
%本程序只能读取模型信息(节点位置Nodes及连通矩阵Elements),无法读取约束及外载信息，约束及外载信息需要在自己程序中手动加入
function [Nodes, Elements, set5node, set5element] = Readmesh( fname )
fid = fopen(fname,'rt');  %fname文件名   r读取  t以txt格式打开
S = textscan(fid,'%s','Delimiter','\n'); %已经打开的文件  字符向量形式读取   'Delimiter','\n'分隔符为换行符  默认分隔符为空格
S = S{1};
%找到Node关键字所在的位置
idxS = strfind(S, 'Node');  %返回元胞数组 若数组中没有相应元素，则返回空
idx1 = find(not(cellfun(@isempty, idxS))); %cellfun(fun,A) 对元胞数组A分别使用函数fun   isempty(A) A为空返回逻辑值1   find 寻找非0元素的索引
%找到Element关键字所在的位置
idxS = strfind(S, 'Element');
idx2 = find(not(cellfun(@isempty, idxS)));
%找到Nset关键字所在位置
idxS = strfind(S, 'Nset');
idx3 = find(not(cellfun(@isempty, idxS)));
% 取出节点信息(元胞数组)
Nodes = S(idx1(1)+1:idx2(1)-1);  %以元胞数组形式取出
%将元胞数组转换为矩阵
Nodes = cell2mat(cellfun(@str2num,Nodes,'UniformOutput',false));  %'UniformOutput',false  以元胞形式返回输出值
% 取出单元(元胞数组)
elements = S(idx2+1:idx3(1)-1) ;
% 将元胞数组转换为矩阵
Elements = cell2mat(cellfun(@str2num,elements,'UniformOutput',false));
Nodes=Nodes(:,2:end);
Elements=Elements(:,2:end);
%提取set-5相关node和elements
set5idx = strfind(S, '*Elset, elset=rs, instance=Part-1-1');  %返回元胞数组 若数组中没有相应元素，则返回空
set5idx1 = find(not(cellfun(@isempty, set5idx))); %cellfun(fun,A) 对元胞数组A分别使用函数fun   isempty(A) A为空返回逻辑值1   find 寻找非0元素的索引
set5idx = strfind(S, '*Elset, elset=Set-5, instance=Part-1-1');  %返回元胞数组 若数组中没有相应元素，则返回空
set5idx2 = find(not(cellfun(@isempty, set5idx))); %cellfun(fun,A) 对元胞数组A分别使用函数fun   isempty(A) A为空返回逻辑值1   find 寻找非0元素的索引
set5idx = strfind(S, '*End');
set5idx3 = find(not(cellfun(@isempty, set5idx)));
% 提取节点信息（元胞）
% set5节点
set5node = S(set5idx1(1)+1:set5idx2(1)-2); 
set5node = cell2mat(cellfun(@str2num,set5node,'UniformOutput',false));  %'UniformOutput',false  以元胞形式返回输出值
[m,n] = size(set5node);
set5node = reshape(set5node,m*n,1);
temp = S(set5idx2(1)-1:set5idx2(1)-1); 
temp = cell2mat(cellfun(@str2num,temp,'UniformOutput',false));  %'UniformOutput',false  以元胞形式返回输出值
[m,n] = size(temp);
temp = reshape(temp,m*n,1);
set5node = [set5node;temp];
%set5单元
set5element = S(set5idx2(1)+1:set5idx3(1)-2); 
set5element = cell2mat(cellfun(@str2num,set5element,'UniformOutput',false));  %'UniformOutput',false  以元胞形式返回输出值
[m,n] = size(set5element);
set5element = reshape(set5element,m*n,1);
temp = S(set5idx3(1)-1:set5idx3(1)-1); 
temp = cell2mat(cellfun(@str2num,temp,'UniformOutput',false));  %'UniformOutput',false  以元胞形式返回输出值
[m,n] = size(temp);
temp = reshape(temp,m*n,1);
set5element = [set5element;temp];
% dlmwrite('Nodes.txt', Nodes,'precision', '%f');
% dlmwrite('Elements.txt', Elements,'precision', '%f');
% dlmwrite('set5node.txt', set5node,'precision', '%f');
% dlmwrite('set5element.txt', set5element,'precision', '%f');
fclose('all');
end