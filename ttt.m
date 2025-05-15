function [XY_str,k] = ttt(n,m)
%   格式转换函数 将幂次从x^形式转换成x*形式,k为对应项系数编号
%
X_str = "";Y_str = "";XY_str = "";k=ones(n+1,m+1);
%% 定义X幂次形式向量
for i = 1 : n+1
    if i == 1
        X_str(i) = '';
    elseif i == 2
        X_str(i) = strcat('X');
    else
        X_str(i) = strcat(X_str(i-1),'*','X');
    end
end
%% 定义Y幂次形式向量
for i = 1 : m+1
    if i == 1
        Y_str(i) = '';
    elseif i == 2
        Y_str(i) = strcat('Y');
    else
        Y_str(i) = strcat(Y_str(i-1),'*','Y');
    end
end
%% 定义XY
for i = 1 : n+1
    for j = 1 : m+1
        if i == 1 && j == 1
            XY_str(i,j) = '';
        elseif i ~= 1 && j == 1
            XY_str(i,j) = X_str(i);
        elseif i == 1 && j ~= 1
            XY_str(i,j) = Y_str(j);
        else
            XY_str(i,j) = strcat(X_str(i),'*',Y_str(j));
        end
    end
end
%% 定义k  系数向量的定位矩阵
it = 1;

for i = 2 : n+2
    for j = 1 : i-1
        k(i-j, j) = it;
        it = it + 1;
    end
end

for p = n+3 :1: 2*(n+1)
    for i = n+1 :-1: p-n-1
        k(i, p-i) = it;
        it = it + 1;
    end
end

end


