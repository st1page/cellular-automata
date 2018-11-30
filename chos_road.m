function [mp, v, time] = chos_road(mp,v,time)
%
% 
%  
% 
% 
% 
%

[N, M] = size(mp);
for y=M-1:-1:2
    for x=26:28
        if(mp(x,y)==2 & mp(x,y+1)~=1)
            if(mp(x-1,y)==1 & mp(x+1,y)==1 )
                if(rand<0.5)
                    mp(x+1,y)=2;
                    mp(x,y)=1;
                    v(x+1,y)=v(x,y);
                    v(x,y)=0;
                    time(x+1,y)=time(x,y);
                    time(x,y)=0;
                else
                    mp(x-1,y)=2;
                    mp(x,y)=1;
                    v(x-1,y)=v(x,y);
                    v(x,y)=0;
                    time(x-1,y)=time(x,y);
                    time(x,y)=0;
                end;
            elseif(mp(x+1,y)==1)
                mp(x+1,y)=2;
                mp(x,y)=1;
                v(x+1,y)=v(x,y);
                v(x,y)=0;
                time(x+1,y)=time(x,y);
                time(x,y)=0;
            elseif(mp(x-1,y)==1)
                mp(x-1,y)=2;
                mp(x,y)=1;
                v(x-1,y)=v(x,y);
                v(x,y)=0;
                time(x-1,y)=time(x,y);
                time(x,y)=0;
            end;
        end;
    end;
end;