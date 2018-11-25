tic
dgain=4*[24;24;24;24];pgain=1/4*[dgain(1)^2;dgain(2)^2;dgain(3)^2;dgain(4)^2];
ini=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi; 0;0;0;0];
desire=[6*pi/12+pi/9;-10/6*pi;pi/3;-2*pi/18];
kk=[296;296;296;296]*18;
side=-5; n=21; drift=zeros(n,1); sside=zeros(n,1);
for i =1 : n
    sim('sim_ex_4link_rel_cyclic');
    drift(i)=ScopeData.signals(1,1).values(200,1);
    sside(i)=side;
    side=side+0.5;    
end
ScopeData.signals(1,1).values(200,1:4)
plot(sside,drift)
toc