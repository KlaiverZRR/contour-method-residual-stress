%  单面点云数据处理
%% 数据导入
clc;
clear all;
%% 单面点云拟合
%%%%%%%%%%%%%%%%%%使用单面点云拟合时要将8-9行代码取消注释同时注释掉双面点云拟合段
filepath = "C:\Users\10571\Desktop\test\FGH95\20批产95挡板\DYH-23-16-1\DYH-23-16-1_A.txt";%单面点云路径
Data = importdata(filepath);
ImpData = Data;
% 平移对准
x0 = ImpData(:,1); y0 = ImpData(:,2); z0 = ImpData(:,3);
[y0,z0] = Re(y0,z0);
[x0,z0] = Re(x0,z0);
% ImpData = [x0,y0,z0];
n0 = length(x0);
a0 = [x0,y0,z0,ones(n0,1)];
u0 = [-(max(x0)+min(x0))/2,-max(abs(y0)),-mean(z0)]; 
Tr0 = [1,0,0,u0(1);0,1,0,u0(2);0,0,1,u0(3);0,0,0,1];
A0 = a0*Tr0';
%%%%%%%%%%%%%%%%%%%
% theta = -180;
% M = [A0(:,1),A0(:,2)]*[cosd(theta),-sind(theta);sind(theta),cosd(theta)]';
% ImpData = [M(:,1),M(:,2),A0(:,3)];
%%%%%%%%%%%%%%%%%
ImpData = [A0(:,1),A0(:,2),A0(:,3)];
%% 双面点云拟合
%%%%%%%%%%%%%%%%%使用双面点云拟合时将单面代码行注释掉
%%%%%%%%%%%%%%%%%不要注释第7行代码避免最后保存代码报错
%点云对应路径
% data1 = importdata("D:\temp\work\401\pointdata\738\738-2\A.txt");
% data2 = importdata("D:\temp\work\401\pointdata\738\738-2\B.txt");
% %点云配准
% x0 = data1(:,1); y0 = data1(:,2); z0 = data1(:,3);
% x1 = data2(:,1); y1 = data2(:,2); z1 = data2(:,3);
% % x0 = data1.data(:,1); y0 = data1.data(:,2); z0 = data1.data(:,3);
% [y0,z0] = Re(y0,z0);
% [x0,z0] = Re(x0,z0);
% % x1 = data2.data(:,1); y1 = data2.data(:,2); z1 = data2.data(:,3);
% [y1,z1] = Re(y1,z1);
% [x1,z1] = Re(x1,z1);
% % n0 = length(x0);
% % a0 = [x0,y0,z0,ones(n0,1)];
% % u0 = [0,min(abs(y0)),-mean(z0)]; 
% % Tr0 = [1,0,0,0;0,1,0,u0(2);0,0,1,u0(3);0,0,0,1];
% % A0 = a0*Tr0'; x0 = A0(:,1); y0 = A0(:,2); z0 = A0(:,3);
% % n1 = length(x1);
% % a1 = [x1,y1,z1,ones(n1,1)];
% % u1 = [0,min(abs(y1)),-mean(z1)]; 
% % Tr1 = [1,0,0,0;0,1,0,u1(2);0,0,1,u1(3);0,0,0,1];
% % A1 = a1*Tr1'; x1 = A1(:,1); y1 = A1(:,2); z1 = A1(:,3);
% %%%%%%%%%%%%%%%旋转180配准情况
% % theta = -180;
% % A = [x1,y1]*[cosd(theta),-sind(theta);sind(theta),cosd(theta)]';
% % x1 = A(:,1); y1 = A(:,2);
% %%%%%%%%%%%%%%%
% x = -x1; y = y1; z = z1;
% data1 = [x0,y0,z0];
% data2 = [x,y,z];
% ImpData = [data1;data2];
% % data1 = [x0,y0,z0];
% % data2 = [x,y,z];
% % ImpData = [data1;data2];
%% 前处理
d = 1;%网格大小
[xq, yq, zq] = PreprocessDate(ImpData,d);
% [yq,zq] = Re(yq,zq);
% [xq,zq] = Re(xq,zq);
%% 拟合
n = 4;%拟合方程次数
[f  gof] = createFit(xq, yq, zq, n);
P = coeffvalues(f);%多项式系数向量
s = dispf(P,n,n);
disp(s)
disp(gof)
%% 保存拟合结果到文本
% c2 = cell2mat(struct2cell(gof));
% a = {s;c2};
% fileID = fopen(strcat(fileparts(filepath),'poly.txt'),'w');%%fileparts提取文件路径
% formatSpec = '%s %d %2.1f %s\n';
% [nrows,ncols] = size(a);
% for row = 1:nrows
%     fprintf(fileID,formatSpec,a{row,:}); % 注意此处不用{}，而是（）时，得到的字符串酱油引号，需注意
% end
% fclose(fileID);



