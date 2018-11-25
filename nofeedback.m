Lc0=0.06; Lc1=0.07; Lc2=0.04; Lc3=0.04;
L0=0.12; L1=0.14; L2=0.08; L3=0.08;
m0=0.0425; m1=0.0111; m2=0.01955; m3=0.0119;
I0=5.1*10^(-5); I1=1.81*10^(-5); I2=1.19*10^(-5); I3=0.63*10^(-5);

rel_=[-15,-10,15];

syms qr1 qr2 qr3 dqr1 dqr2 dqr3
MR =[ (I0*m0 + I0*m1 + I0*m2 + I0*m3 + L0^2*m0*m2 + L0^2*m0*m3 + L0^2*m1*m2 + L0^2*m1*m3 + L2^2*m0*m3 + L2^2*m1*m3 + L2^2*m2*m3 + Lc0^2*m0*m1 + Lc0^2*m0*m2 + Lc1^2*m0*m1 + Lc0^2*m0*m3 + Lc1^2*m1*m2 + Lc2^2*m0*m2 + Lc1^2*m1*m3 + Lc2^2*m1*m2 + Lc3^2*m0*m3 + Lc2^2*m2*m3 + Lc3^2*m1*m3 + Lc3^2*m2*m3 - 2*L0*Lc0*m0*m2 - 2*L0*Lc0*m0*m3 - 2*L2*Lc2*m2*m3 + 2*Lc1*Lc3*m1*m3*cos(qr2 - qr1 + qr3) + 2*L0*Lc3*m0*m3*cos(qr2 + qr3) + 2*L0*Lc3*m1*m3*cos(qr2 + qr3) - 2*Lc0*Lc3*m0*m3*cos(qr2 + qr3) + 2*L0*L2*m0*m3*cos(qr2) + 2*L0*L2*m1*m3*cos(qr2) + 2*L0*Lc1*m1*m2*cos(qr1) + 2*L0*Lc1*m1*m3*cos(qr1) + 2*L0*Lc2*m0*m2*cos(qr2) + 2*L0*Lc2*m1*m2*cos(qr2) - 2*L2*Lc0*m0*m3*cos(qr2) + 2*L2*Lc3*m0*m3*cos(qr3) + 2*L2*Lc3*m1*m3*cos(qr3) + 2*L2*Lc3*m2*m3*cos(qr3) + 2*Lc0*Lc1*m0*m1*cos(qr1) - 2*Lc0*Lc2*m0*m2*cos(qr2) - 2*Lc2*Lc3*m2*m3*cos(qr3) + 2*L2*Lc1*m1*m3*cos(qr1 - qr2) + 2*Lc1*Lc2*m1*m2*cos(qr1 - qr2))/(m0 + m1 + m2 + m3), -(Lc1*m1*(Lc1*m0 + Lc1*m2 + Lc1*m3 + L2*m3*cos(qr1 - qr2) + Lc2*m2*cos(qr1 - qr2) + Lc3*m3*cos(qr2 - qr1 + qr3) + L0*m2*cos(qr1) + L0*m3*cos(qr1) + Lc0*m0*cos(qr1)))/(m0 + m1 + m2 + m3), -(L2^2*m0*m3 + L2^2*m1*m3 + L2^2*m2*m3 + Lc2^2*m0*m2 + Lc2^2*m1*m2 + Lc3^2*m0*m3 + Lc2^2*m2*m3 + Lc3^2*m1*m3 + Lc3^2*m2*m3 - 2*L2*Lc2*m2*m3 + Lc1*Lc3*m1*m3*cos(qr2 - qr1 + qr3) + L0*Lc3*m0*m3*cos(qr2 + qr3) + L0*Lc3*m1*m3*cos(qr2 + qr3) - Lc0*Lc3*m0*m3*cos(qr2 + qr3) + L0*L2*m0*m3*cos(qr2) + L0*L2*m1*m3*cos(qr2) + L0*Lc2*m0*m2*cos(qr2) + L0*Lc2*m1*m2*cos(qr2) - L2*Lc0*m0*m3*cos(qr2) + 2*L2*Lc3*m0*m3*cos(qr3) + 2*L2*Lc3*m1*m3*cos(qr3) + 2*L2*Lc3*m2*m3*cos(qr3) - Lc0*Lc2*m0*m2*cos(qr2) - 2*Lc2*Lc3*m2*m3*cos(qr3) + L2*Lc1*m1*m3*cos(qr1 - qr2) + Lc1*Lc2*m1*m2*cos(qr1 - qr2))/(m0 + m1 + m2 + m3), -(Lc3*m3*(Lc3*m0 + Lc3*m1 + Lc3*m2 + Lc1*m1*cos(qr2 - qr1 + qr3) + L0*m0*cos(qr2 + qr3) + L0*m1*cos(qr2 + qr3) - Lc0*m0*cos(qr2 + qr3) + L2*m0*cos(qr3) + L2*m1*cos(qr3) + L2*m2*cos(qr3) - Lc2*m2*cos(qr3)))/(m0 + m1 + m2 + m3)];
body=double(subs(-(MR(2)*dqr1+MR(3)*dqr2+MR(4)*dqr3)/MR(1),[qr1,qr2,qr3,dqr1,dqr2,dqr3],[-1/4*pi, 1/12*pi, -1/3*pi,rel_]));
ini=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi;body;rel_.'];

dgain=2*[24;24;24;24];pgain=1/4*[dgain(1)^2;dgain(2)^2;dgain(3)^2;dgain(4)^2];
desire=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi;0;0;0;0];
% desire=[6*pi/12+pi/9;-10/6*pi;pi/3;-2*pi/18];
sim('sim_ex_4link_rel_basic');
ScopeData.signals(1,1).values(200,1:4)
ScopeData.signals(1,4).values(1,1)