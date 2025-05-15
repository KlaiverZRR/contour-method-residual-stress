figure; % 创建一个新的图形窗口
h = contourf(av.xi,av.yi,av.z); %输入坐标（x y z）
% set(h,'EdgeColor','none'); % 去除边缘线
shading interp;
colormap(jet); % 设置颜色映射为jet
caxis([min(zq), max(zq)]); %设置云图色条上下限
colorbar;
xlabel('X /mm'); % 设置x轴标签
ylabel('Y /mm'); % 设置y轴标签
axis equal
axis tight; % 调整坐标轴范围以紧密包含数据