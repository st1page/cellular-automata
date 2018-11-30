function [mp, v] = new_cars(dt,mp,v,vmainmax)
%
%
%
%
% 
tmp = find(mp(:,2) == 1);
n = length(tmp);
sum =min( poissrnd(4,1), n);
%sum=min(3,n);
if sum > 0 
    x = randperm(n);
    for i = 1:sum
        
        row=tmp(x(i));
    %    if(row~=26 )
        mp(row,2) = 2;
        v(row,2) = vmainmax; %end;
    end
end

