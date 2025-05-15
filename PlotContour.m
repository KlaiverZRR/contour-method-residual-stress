%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%         结果后处理绘制云图程序         %%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlotContour(newE,N,S)
% newE为网格面片
% N是对应网格结点坐标
% S网格结点数值
myColor=1/255*[0,0,255;  0,93,255;   0,185,255;  0,255,232;
    0,255,139;  0,255,46;  46,255,0;  139,255,0;
    232,255,0;  255,185,0; 255,93,0;  255,0,0];
figure
patch('Faces',newE,"Vertices",[N(:,2),N(:,3)],'facevertexCdata',S,'edgecolor','none','facecolor','interp')
axis off; %不显示坐标轴
colormap(myColor);
caxis([min(S),max(S)]);
t1=caxis;
t1=linspace(t1(1),t1(2),13);
colorbar('ytick',t1,'Location','eastoutside');
axis equal;
end

