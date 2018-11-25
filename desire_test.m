%Parameter 
tic
count=100;
dgain=[24;24;24;24];pgain=1/4*[dgain(1)^2;dgain(2)^2;dgain(3)^2;dgain(4)^2];
ini=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi; 0;0;0;0];
desire=[6*pi/12+pi/18;-3/2*pi;pi/3;-2*pi/18];
kk=[40;40;40;40]; side=-5; j=0;
final=zeros(count,1);
sidev=zeros(count,1);
direction=zeros(27,1);
%% find the fastest changing direction 
for j1 = 1 : 3
                for j2 = 1 : 3
                    for j3 = 1 : 3
                        side1=-side+(j1-1)*side;
                        side2=-side+(j2-1)*side;
                        side3=-side+(j3-1)*side;
                        sim('sim_ex_4link_rel_new_method');j=j+1;
                        direction(j)=ScopeData.signals(1,1).values(200,1);
                    end
                 end
end
if(desire(1)-ini(1)<0) %if it needs decrease
    j=find(direction==min(direction));
else 
    j=find(direction==max(direction));
end

if(fix(mod(j,9)==0))
    switch j
        case 9
            j1=1;j2=3;j3=3;
        case 18
            j1=2;j2=3;j3=3;
        case 27
            j1=3;j2=3;j3=3;
    end
else    
j1=fix(j/9)+1;
j2=fix((j-9*(j1-1))/3)+1;
j3=j-9*(j1-1)-3*(j2-1);
end
side1=(j1-2)*side;
side2=(j2-2)*side;
side3=(j3-2)*side;
%% find side length
for i= 1: count
            sidev(i,1)=side;
            sim('sim_ex_4link_rel_new_method');
            final(i,1)=desire(1)-ScopeData.signals(1,1).values(200,1);
            side=side+0.1;
            side1=(j1-2)*side;
            side2=(j2-2)*side;
            side3=(j3-2)*side;
end

%optimal value re-simulation
i=find(abs(final)==min(abs(final)));
side=-5+0.1*i;
side1=(j1-2)*side;
side2=(j2-2)*side;
side3=(j3-2)*side;
sim('sim_ex_4link_rel_new_method');

%draw the graph
figure
plot(sidev,final)
grid on
title('side vs change angle');
xlabel('side');
ylabel('q0 angle');
figure
plot3(ScopeData.signals(1,1).values(1:200,2),ScopeData.signals(1,1).values(1:200,3),ScopeData.signals(1,1).values(1:200,4),'ro')
grid on
title('qr 3D trajectory');
xlabel('qr1 axis');
ylabel('qr2 axis');
zlabel('qr3 axis');
toc