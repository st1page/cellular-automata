function h = print_mp(mp, h, ptime)
%
% 
%        mp map  
%        h  handle 
%        ptime pause
%

%load map3.mat;
[N,M] = size(mp);
mp=flipud(mp);
if ishandle(h)
    set(h,'CData',mp)
    pause(ptime)
else
    figure('position',[50,50,7000,7000])
    h = imagesc(mp);    
    colormap(copper);
    axis image
    set(gca,'XTick',[]);
    set(gca,'yTick',[]);
    pause(ptime);
end
