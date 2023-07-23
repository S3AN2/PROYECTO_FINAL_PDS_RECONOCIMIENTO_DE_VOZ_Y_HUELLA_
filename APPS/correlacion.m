function [n1,n2]=correlacion()
n11=imcrop(n1,[0 0 200 250]);
n22=imcrop(n2,[0 0 200 250]);
k1=corr2(n11,n22);
end
