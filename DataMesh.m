function outdata = DataMesh(ImpData,d,bd)
%DataMes 数据网格化
%ImpData 输入数据
%d       网格大小
%bd      轮廓边缘
x = ImpData(:,1);y = ImpData(:,2);z = ImpData(:,3); 
%% 3σ原则剔除异常z值
u = z;
mz = mean(u);
sigmaz = std(u);
lower_bound = mz - 3*sigmaz;
upper_bound = mz + 3*sigmaz;
idx = (u >= lower_bound) & (u <= upper_bound);
x = x(idx); y = y(idx); z = z(idx);
%% 数据网格化
maxx = max(x); minx = min(x);
maxy = max(y); miny = min(y);
X = minx : d : maxx;
Y = miny : d : maxy;
[xm,ym] = meshgrid(X,Y);
[in,on] = inpolygon(xm,ym,bd(:,1),bd(:,2));
in = logical(in+on);
zm = ones(size(xm)).*NaN;
[r,c] = size(xm);
for i = 1 : r
    for j = 1 : c
        temp_x = xm(i,j);
        temp_y = ym(i,j);
        delta = sqrt((x-temp_x).^2+(y-temp_y).^2);
        id = delta <= d./2;
        u = z(id);
        temp_z = mean(u);
        zm(i,j) = temp_z;
    end
end
%NaN补全
zvmCi = fillmissing(zm,'linear');%相邻非缺失值的线性插值补全
zvmCi = fillmissing(zvmCi,'linear',2);
xv = xm(in);
yv = ym(in);
zv = zvmCi(in);
%% 输出
field1 = 'point';  value1 = [xv,yv,zv];
field2 = 'in';  value2 = in;
field3 = 'xm';  value3 = xm;
field4 = 'ym';  value4 = ym;
field5 = 'zm';  value5 = zm;
field6 = 'zvmCi'; value6 = zvmCi;
outdata = struct(field1,value1,field2,value2,field3,value3,field4,value4, ...
          field5,value5,field6,value6);

end