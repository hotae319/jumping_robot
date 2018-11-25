%dynamic model of 3 link after impact
syms q0 qr1 qr2 qr3  dq0 dqr1 dqr2 dqr3 T1 T2 T3 T4;
syms Lc0 Lc1 Lc2 Lc3 L0 L1 L2 L3 m0 m1 m2 m3 I0 I1 I2 I3;
syms g; c=1;k=1;
D=0; P=0;
m=[m0;m1;m2;m3];
I=[I0;I1;I2;I3];
q=[q0;qr1;qr2;qr3]; dq=[dq0;dqr1;dqr2;dqr3];
p0=[L3*cos(q0-qr2-qr3)+L2*cos(q0-qr2)+(L0-Lc0)*cos(q0);L3*sin(q0-qr2-qr3)+L2*sin(q0-qr2)+(L0-Lc0)*sin(q0)]; 
p1=[L3*cos(q0-qr2-qr3)+L2*cos(q0-qr2)+L0*cos(q0)+Lc1*cos(q0-qr1);L3*sin(q0-qr2-qr3)+L2*sin(q0-qr2)+L0*sin(q0)+Lc1*sin(q0-qr1)];
p2=[L3*cos(q0-qr2-qr3)+(L2-Lc2)*cos(q0-qr2);L3*sin(q0-qr2-qr3)+(L2-Lc2)*sin(q0-qr2)];
p3=[(L3-Lc3)*cos(q0-qr2-qr3);(L3-Lc3)*sin(q0-qr2-qr3)];
%position matrix
p=[p0;p1;p2;p3];
%find the jacobians of velocity & angular velocity
Jv=jacobian(p,q);
Jq=jacobian(q,q);
for i=1:4
    D=D+m(i,:)*Jv(2*i-1:2*i,:).'*Jv(2*i-1:2*i,:)+I(i,:)*Jq(i,:).'*Jq(i,:);
end
D=simplify(D) %inertia matrix 
C=D-D;
for k=1:4
for j=1:4
for i=1:4
    C(k,j)=C(k,j)+1/2*(diff(D(k,j),q(i,:))+diff(D(k,i),q(j,:))-diff(D(i,j),q(k,:)))*dq(i,:);
end
end
end
C=simplify(C) %christoffel matrix

for i=1:4
    P=P+m(i,:)*g*p(2*i,1); %potential energy
end
poten=jacobian(P,q).'; 
poten=simplify(poten)
tau=[0;T1;T2;T3];
