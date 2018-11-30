function [alltime,mp, v, time , sumpassed ] = move(alltime,sumpassed,mp,v,time,dt)
%  
%
%

[N, M] = size(mp);  
for y=M:-1:1
    for x=26:28
        if(mp(x,y)==2)
            if(y+v(x,y)>=M) 
                alltime=alltime+time(x,y);
                v(x,y)=0; time(x,y)=0; mp(x,y)=1;
                sumpassed=sumpassed+1;
            else 
                if(v(x,y)~=0)
                    v(x,y+v(x,y))=v(x,y); time(x,y+v(x,y))=time(x,y)+dt; mp(x,y+v(x,y))=2;
                    v(x,y)=0; time(x,y)=0; mp(x,y)=1;
                end;
            end;
        end;
    end;
end;

