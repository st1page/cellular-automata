function [mp, v, time,lightmp] = init_mp(Sidex1,Sidex2,Sidey,Mainy,Mainlength,Mainwide)
% 
%       Sidex1 = 51      Sidex2=551
%         +---------------+     Sidey = 2
%         |               |
%         |               |
%   ======+===============+==== Mainy = 126
%
%

mp = zeros(Mainy+Mainwide+2,Mainlength+2) + 3;
v =  zeros(Mainy+Mainwide+2,Mainlength+2);
time =  zeros(Mainy+Mainwide+2,Mainlength+2);
lightmp = zeros(Mainy+Mainwide+2,Mainlength+2);
mp(Mainy:Mainy+Mainwide-1,1:Mainlength+2) = 1;
mp(Sidey:Mainy,Sidex1:Sidex1)=1;
mp(Sidey:Mainy,Sidex2:Sidex2)=1;
mp(2:2,Sidex1:Sidex2)=1;
lightmp(Mainy:Mainy+Mainwide+-1,Sidex1-5:Sidex1-5)=1;

