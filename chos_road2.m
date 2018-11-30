function [mp, v, time] = chos_road(mp,v,time)
%
% 
%  
% 
% 
% 
%

[N, M] = size(mp);
dis=zeros(N,M)-1;
for y=M:-1:2
    for x=26:28 
        if (mp(x,y)==2|mp(x,y)==3) 
            dis(x,y) = 0;
        end;
    end;
end;
for y=M-1:-1:2
    for x=26:28
        if (dis(x,y)==-1 && dis(x,y+1)~=-1 ) 
            dis(x,y) = dis(x,y+1)+1;
        end;
    end;
end;
for y=2:M-1
    for x=26:28
        if(mp(x,y)==2)
            if(dis(x,y+1)==-1)dis(x,y)=123;
            else dis(x,y)=dis(x,y+1)+1;
            end;
        end;
    end;
end;

for y=2:M-1
    for x=26:28
        if(mp(x,y)==2 & (dis(x,y)-1<v(x,y)||mp(x,y+1)==2))
            if(mp(x-1,y)==1 & dis(x-1,y)>dis(x,y)  & mp(x+1,y)==1 & dis(x+1,y)>=dis(x,y))
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
            elseif(mp(x+1,y)==1 & dis(x+1,y)>=dis(x,y))
                mp(x+1,y)=2;
                mp(x,y)=1;
                v(x+1,y)=v(x,y);
                v(x,y)=0;
                time(x+1,y)=time(x,y);
                time(x,y)=0;
            elseif(mp(x-1,y)==1 & dis(x-1,y)>dis(x,y))
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