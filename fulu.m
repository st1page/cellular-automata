function [mp, v, time] = fulu(mp,v,time,vsidemax,Sidey1,Sidey2,Sidex,changepro)
%  
%
%
speedpro =0.9;
[N, M] = size(mp);  
step=0; x=25; y=Sidey2;
while(1)
    step=step+1;
    if(mp(x,y)==2) break;end;
    if(x==Sidex) break;end;
    x=x-1;
end;
if(mp(x,y)==2&&v(x,y)>=step)
    v(25,y)=1; mp(25,y)=2; time(25,y)=time(x,y)+1.2;
    v(x,y)=0; mp(x,y)=1; time(x,y)=0;
end;
dis=zeros(N,M)-1;
x=25;y=Sidey2;
dis(26,Sidey2)=0;
while(1)
    if(x==26) break;end;
    if(mp(x,y)==2) dis(x,y)=0;end;
    if(y==Sidey2&&x~=Sidex)
        x=x-1;
    elseif(x==Sidex&&y~=Sidey1)
        y=y-1;
    elseif(y==Sidey1&&x~=26)
        x=x+1;
    end;
end;
lastx=26; lasty=Sidey2; x=25; y=Sidey2;
while(1)
    if(x==26) break;end;
    if(dis(x,y)==-1) dis(x,y)=dis(lastx,lasty)+1;end;
    lastx=x; lasty=y;
    if(y==Sidey2&&x~=Sidex)
        x=x-1;  
    elseif(x==Sidex&&y~=Sidey1)
        y=y-1;
    elseif(y==Sidey1&&x~=26)
        x=x+1;
    end;
end;
x=25; y=Sidey1; nxtx=0; nxty=0;
while(1)
    if(x==26) break;end;
    if(y==Sidey1&&x~=Sidex)
        nxtx=x-1; nxty=y;
    elseif(x==Sidex&&y~=Sidey2)
        nxty=y+1; nxtx=x;
    elseif(y==Sidey2&&x~=26)
        nxtx=x+1; nxty=y;
    end;
    if(dis(x,y)==0)dis(x,y)=dis(nxtx,nxty)+1;end;
    x=nxtx; y=nxty;
end;
x=25; y=Sidey2;
tot=0;
X=1:500;Y=1:500;
while(1)
    if(x==26) break;end; tot=tot+1;
    if(mp(x,y)==2)
        if(rand<speedpro) rlv = min(vsidemax,min(v(x,y)+1,dis(x,y)-1));
        else rlv= min(vsidemax,min(max(0,v(x,y)-1),dis(x,y)-1));
        end;
        if(rlv~=0) 
            tox = X(tot-rlv); toy=Y(tot-rlv);
            mp(tox,toy)=2; v(tox,toy)=rlv;
            time(tox,toy)=time(x,y)+1.2; time(x,y)=0;
            mp(x,y)=1; v(x,y)=0;
        end;
    end;
    X(tot)=x; Y(tot)=y;
    if(y==Sidey2&&x~=Sidex)
        x=x-1;  
    elseif(x==Sidex&&y~=Sidey1)
        y=y-1;
    elseif(y==Sidey1&&x~=26)
        x=x+1;
    end;
end;

for y=Sidey1:-1:2
    if(mp(26,y)==2)
        if(v(26,y)<Sidey1-y||rand>changepro) break;end;
        mp(25,Sidey1)=2; time(25,Sidey1)=time(26,y)+1.2; v(25,Sidey1)=2;
        mp(26,y)=1; time(26,y)=0; v(26,y)=0;
    end;
end;