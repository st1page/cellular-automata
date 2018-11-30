function main
%   元胞自动机模拟三车道干路中间有大企业两边有一一车道辅路高峰时段
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Sidex1        Sidex2
%         +---------------+     Sidey = 2
%         |               |
%         |               |
%   ======+===============+==== Mainy 
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   T               总模拟实际时间
%   Arrival         总车流量
%   Mainlength      干道长
%   Mainy           干道纵坐标
%   Mainwide        干道宽
%   Sidewide        辅路宽
%   Sidex1 Sidex2   辅路横坐标
%   Sidey           辅路纵坐标
%   Sidelengthh     辅路南北长
%   Sidelengthw     辅路东西长
%   MP              map矩阵
%              1 空 2 车 3 边界 
%   lightmp         红绿灯
%   lighttime       红绿灯间隔
%   v               车速度矩阵
%   vmainmax        干道最高速 
%   vsidemax        辅路最高速
%   time            车花费时间矩阵
%   dt              单位时间
%   tt              图像刷新时间
%   h               handle
%   sumtime         车总时间
%   alltime         车总花费时间
%   changepro       右侧车道进入铺路概率
clear;clc
T = 3000; 
Mainlength = 200; Mainwide = 3; vmainmax = 6;
%Sidelengthh = 25; Sidelengthw = 100; Sidewide = 1; 
changepro = 0;
vsidemax = 4;
Sidex1 = 30; Sidex2 = 150; Sidey = 2; Mainy = 26;
[mp, v, time,lightmp] = init_mp(Sidex1,Sidex2,Sidey,Mainy,Mainlength,Mainwide);

h = print_mp(mp, NaN, 0.1);
dt = 1.2; tt=0.1;
sumtime = 0; sumpassed =0;
lighttime = 20;


alltime=0;
%mp(25,comy)=2;
cy2=130;
mp(25,cy2)=2;
for i = 1:T
    sumtime=sumtime+dt;
%   刷车
    if(rem(i,2)&(mp(27,8)~=2||v(27,8)~=0))[mp, v] = new_cars(dt,mp,v,vmainmax); end;
%   软件园
    if(rem(i,2))mp(24,cy2)=1;else mp(24,cy2)=2;end;
    mp(26,cy2)=2;v(26,cy2)=0;

%   变道 chos_road2 激进 chos_road 保守
    [mp, v, time] = chos_road(mp,v,time);
%   变速
    [mp, v, time] = change_speed(mp,v,time,vmainmax);
    flag = (mp(Mainy,Sidex2)==0)
%   辅道    
    if(flag) 
        [mp, v, time] = fulu(mp,v,time,vsidemax,Sidex1,Sidex2,Sidey,changepro);
    end;
%   位移&消车
    [alltime, mp, v, time , sumpassed ] = move(alltime,sumpassed,mp,v,time,dt);
%   辅道 
    if(~flag)
        [mp, v, time] = fulu(mp,v,time,vsidemax,Sidex1,Sidex2,Sidey,changepro);
    end;
%   输出
    h = print_mp(mp,h,tt);
    xlabel({strcat(strcat('time = ',num2str(sumtime,'%.1f')),'s'),
            strcat('total number of vehicles =',num2str(sumpassed)),
            strcat('average passing time =',num2str(alltime/sumpassed,'%.4f'))
            ,'不开放辅路，软件园影响，保守策略'});
%     w= getframe;
%     imind  =frame2im(w);
%     [imind ,cm]=rgb2ind(imind,256);
%     if(i~=1)
%         imwrite(imind, cm, 'example2.gif','gif','WriteMode','append','DelayTime',0.01);
%     else
%         imwrite(imind, cm, 'example2.gif','gif','Loopcount',inf,'DelayTime',0.01);
%     end;
end

