function [s] = dispf(P,n,m)
s = ''; t = {32};
len = length(P);
[XnYm,k] = ttt(n,m);%%  XnYm(i,j) = x^(i-1)y^(j-1)
for i = 1 : n+1
    for j = 1 : m+2-i
        if i == 1 && j == 1
            s = strcat(s,num2str(P(k(i,j))),t,'+',t);
        elseif i == n+1
            s = strcat(s,num2str(P(k(i,j))),'*',XnYm(i,j),t);
        else
            s = strcat(s,num2str(P(k(i,j))),'*',XnYm(i,j),t,'+',t);
        end
    end
end
end
            
        
        
        

