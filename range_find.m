%Parameter 
tic
count=0; count1=0; 
dgain=3*[24;24;24;24];pgain=1/4*[dgain(1)^2;dgain(2)^2;dgain(3)^2;dgain(4)^2];

Lc0=0.06; Lc1=0.07; Lc2=0.04; Lc3=0.04;
L0=0.12; L1=0.14; L2=0.08; L3=0.08;
m0=0.0425; m1=0.0111; m2=0.01955; m3=0.0119;
I0=5.1*10^(-5); I1=1.81*10^(-5); I2=1.19*10^(-5); I3=0.63*10^(-5);

rel_=[0,0,0];
syms qr1 qr2 qr3
MR =[ (I0*m0 + I0*m1 + I0*m2 + I0*m3 + L0^2*m0*m2 + L0^2*m0*m3 + L0^2*m1*m2 + L0^2*m1*m3 + L2^2*m0*m3 + L2^2*m1*m3 + L2^2*m2*m3 + Lc0^2*m0*m1 + Lc0^2*m0*m2 + Lc1^2*m0*m1 + Lc0^2*m0*m3 + Lc1^2*m1*m2 + Lc2^2*m0*m2 + Lc1^2*m1*m3 + Lc2^2*m1*m2 + Lc3^2*m0*m3 + Lc2^2*m2*m3 + Lc3^2*m1*m3 + Lc3^2*m2*m3 - 2*L0*Lc0*m0*m2 - 2*L0*Lc0*m0*m3 - 2*L2*Lc2*m2*m3 + 2*Lc1*Lc3*m1*m3*cos(qr2 - qr1 + qr3) + 2*L0*Lc3*m0*m3*cos(qr2 + qr3) + 2*L0*Lc3*m1*m3*cos(qr2 + qr3) - 2*Lc0*Lc3*m0*m3*cos(qr2 + qr3) + 2*L0*L2*m0*m3*cos(qr2) + 2*L0*L2*m1*m3*cos(qr2) + 2*L0*Lc1*m1*m2*cos(qr1) + 2*L0*Lc1*m1*m3*cos(qr1) + 2*L0*Lc2*m0*m2*cos(qr2) + 2*L0*Lc2*m1*m2*cos(qr2) - 2*L2*Lc0*m0*m3*cos(qr2) + 2*L2*Lc3*m0*m3*cos(qr3) + 2*L2*Lc3*m1*m3*cos(qr3) + 2*L2*Lc3*m2*m3*cos(qr3) + 2*Lc0*Lc1*m0*m1*cos(qr1) - 2*Lc0*Lc2*m0*m2*cos(qr2) - 2*Lc2*Lc3*m2*m3*cos(qr3) + 2*L2*Lc1*m1*m3*cos(qr1 - qr2) + 2*Lc1*Lc2*m1*m2*cos(qr1 - qr2))/(m0 + m1 + m2 + m3), -(Lc1*m1*(Lc1*m0 + Lc1*m2 + Lc1*m3 + L2*m3*cos(qr1 - qr2) + Lc2*m2*cos(qr1 - qr2) + Lc3*m3*cos(qr2 - qr1 + qr3) + L0*m2*cos(qr1) + L0*m3*cos(qr1) + Lc0*m0*cos(qr1)))/(m0 + m1 + m2 + m3), -(L2^2*m0*m3 + L2^2*m1*m3 + L2^2*m2*m3 + Lc2^2*m0*m2 + Lc2^2*m1*m2 + Lc3^2*m0*m3 + Lc2^2*m2*m3 + Lc3^2*m1*m3 + Lc3^2*m2*m3 - 2*L2*Lc2*m2*m3 + Lc1*Lc3*m1*m3*cos(qr2 - qr1 + qr3) + L0*Lc3*m0*m3*cos(qr2 + qr3) + L0*Lc3*m1*m3*cos(qr2 + qr3) - Lc0*Lc3*m0*m3*cos(qr2 + qr3) + L0*L2*m0*m3*cos(qr2) + L0*L2*m1*m3*cos(qr2) + L0*Lc2*m0*m2*cos(qr2) + L0*Lc2*m1*m2*cos(qr2) - L2*Lc0*m0*m3*cos(qr2) + 2*L2*Lc3*m0*m3*cos(qr3) + 2*L2*Lc3*m1*m3*cos(qr3) + 2*L2*Lc3*m2*m3*cos(qr3) - Lc0*Lc2*m0*m2*cos(qr2) - 2*Lc2*Lc3*m2*m3*cos(qr3) + L2*Lc1*m1*m3*cos(qr1 - qr2) + Lc1*Lc2*m1*m2*cos(qr1 - qr2))/(m0 + m1 + m2 + m3), -(Lc3*m3*(Lc3*m0 + Lc3*m1 + Lc3*m2 + Lc1*m1*cos(qr2 - qr1 + qr3) + L0*m0*cos(qr2 + qr3) + L0*m1*cos(qr2 + qr3) - Lc0*m0*cos(qr2 + qr3) + L2*m0*cos(qr3) + L2*m1*cos(qr3) + L2*m2*cos(qr3) - Lc2*m2*cos(qr3)))/(m0 + m1 + m2 + m3)];
body=double(subs(-(MR(2)*qr1+MR(3)*qr2+MR(4)*qr3)/MR(1),[qr1,qr2,qr3],rel_));

ini=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi;body;rel_.'];

% ini=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi; 0;0;0;0];
desire=[6*pi/12+pi/9;-10/6*pi;pi/3;-2*pi/18];
kk=[296;296;296;296]*3;
qzero=zeros(8,1);
qzero1=zeros(9,1); 
testing0=[pi/6 pi/6 pi/6 pi/6 -11*pi/6 -11*pi/6 -11*pi/6 -11*pi/6;...
         pi pi -pi/6 -pi/6 -pi/6 -pi/6 pi pi ;...
         0 -pi -pi 0 0 -pi -pi 0];
testing=testing0;

for j = 1 : 8   
        side1=-ini(2)+testing(1,j);
        side2=-ini(3)+testing(2,j);
        side3=-ini(4)+testing(3,j);
        sim('sim_ex_4link_rel_new_method');
        qzero(j)=ScopeData.signals(1,1).values(200,1);
end
imax=find(qzero==max(qzero(1:8,1)));
imin=find(qzero==min(qzero(1:8,1)));
    
%% find max
n=20;qzeron=zeros(n+1,1);
ntesting=zeros(3,n+1); ntesting(:,1)=testing(:,imax);
imax=1; mmax=-1;
while (qzeron(imax)-mmax)>0.01 && count<5
ntesting=ntesting(:,imax)*ones(1,n+1);
    switch mod(count,3)
        case 0 % qr1 direction             
                for k = 1 : n+1
                ntesting(1,k)=pi/6-(k-1)/n*(pi/6-(-11*pi/6));
                end           
        case 1 % qr2 direction
                for k = 1 : n+1
                ntesting(2,k)=pi-(k-1)/8*(pi-(-pi/6));
                end
        case 2 % qr3 direction
                for k = 1 : n+1
                ntesting(3,k)=-(k-1)/8*(0-(-pi));
                end
    end
    count=count+1
    for j = 1 : n+1   
        side1=-ini(2)+ntesting(1,j);
        side2=-ini(3)+ntesting(2,j);
        side3=-ini(4)+ntesting(3,j);
        sim('sim_ex_4link_rel_new_method');
        qzeron(j)=ScopeData.signals(1,1).values(200,1);
    end
    imax=find(qzeron==max(qzeron(1:n+1,1)));
    mmax=qzeron(imax);
end
mmax=qzeron(imax); mmax_p=ntesting(:,imax);
%% find min
n=12;qzeron=zeros(n+1,1);
ntesting=zeros(3,n+1); ntesting(:,1)=testing(:,imin);
imin=1;mmin=1;
while (mmin-qzeron(imin))>0.01 && count1<5
ntesting=ntesting(:,imin)*ones(1,n+1);
    switch mod(count1,3)
        case 0 % qr1 direction             
                for k = 1 : n+1
                ntesting(1,k)=pi/6-(k-1)/n*(pi/6-(-11*pi/6));
                end           
        case 1 % qr2 direction
                for k = 1 : n+1
                ntesting(2,k)=pi-(k-1)/8*(pi-(-pi/6));
                end
        case 2 % qr3 direction
                for k = 1 : n+1
                ntesting(3,k)=-(k-1)/8*(0-(-pi));
                end
    end
    count1=count1+1
    for j = 1 : n+1   
        side1=-ini(2)+ntesting(1,j);
        side2=-ini(3)+ntesting(2,j);
        side3=-ini(4)+ntesting(3,j);
        sim('sim_ex_4link_rel_new_method');
        qzeron(j)=ScopeData.signals(1,1).values(200,1);
    end
    imin=find(qzeron==min(qzeron(1:n+1,1)));
    mmin=qzeron(imin);
end
%minimum value simulation
    side1=-ini(2)+ntesting(1,imin);
    side2=-ini(3)+ntesting(2,imin);
    side3=-ini(4)+ntesting(3,imin);
    sim('sim_ex_4link_rel_new_method');
mmin=qzeron(imin); mmin_p=ntesting(:,imin);

mmax
mmax_p
mmin
mmin_p

