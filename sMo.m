function v = sMo(V,F,n)
%sMo 数据平滑

% 网格的面片索引F，每个面片由四个顶点组成
numnodes = max(F(:));
A = zeros(numnodes, numnodes);
smoothed = V(:,3);
% 遍历所有面片
for i = 1:size(F, 1)
    % 获取面片的三个顶点索引
    v1 = F(i, 1);
    v2 = F(i, 2);
    v3 = F(i, 3);
    v4 = F(i, 4);
    
    % 设置顶点之间的邻接关系
    A(v1, v2) = 1;
    A(v2, v1) = 1;
    A(v2, v3) = 1;
    A(v3, v2) = 1;
    A(v3, v4) = 1;
    A(v4, v3) = 1;
    A(v4, v1) = 1;
    A(v1, v4) = 1;
end

% 将 A 转换成稀疏矩阵
A = sparse(A);
for k = 1 : n
    s = V(:,3);
    for i = 1 : numnodes
        u = find(A(i,:) == 1);
        V(i,3) = (A(i,:)*s + s(i))/(length(u) + 1);
    end
end
v = V(:,3);
end

