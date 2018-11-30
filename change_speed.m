function [mp, v, time] = change_speed(mp,v,time,vmainmax)
%
% 
%  
% 
% 
% 


speedpro =0.9;
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

for y=M-1:-1:2
    for x=26:28
        if(mp(x,y)==2) 
            if(dis(x,y)-1>=v(x,y)) 
                if(rand<speedpro)
                    v(x,y)=min(v(x,y)+1,min(dis(x,y)-1,vmainmax));
                else
                    v(x,y)=max(0,v(x,y)-1);
                end;
            else v(x,y)=dis(x,y)-1;
  %          if(v(x,y)==0) pause;end;
            end;
        end;
    end;
end;
