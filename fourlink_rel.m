%dynamic model of 3 link -> find D,C,pi
syms x y q0 qr1 qr2 qr3 dx dy dq0 dqr1 dqr2 dqr3  T1 T2 T3;
syms Lc0 Lc1 Lc2 Lc3 L0 L1 L2 L3 m0 m1 m2 m3 I0 I1 I2 I3;
syms g; c=1;k=1;
D=0; P=0;
m=[m0;m1;m2;m3];
I=[I0;I1;I2;I3];
q=[x;y;q0;qr1;qr2;qr3]; dq=[dx;dy;dq0;dqr1;dqr2;dqr3];
p0=[x;y]; p1=[x+Lc0*cos(q0)+Lc1*cos(q0-qr1);y+Lc0*sin(q0)+Lc1*sin(q0-qr1)];
p2=[x-(L0-Lc0)*cos(q0)-Lc2*cos(q0-qr2);y-(L0-Lc0)*sin(q0)-Lc2*sin(q0-qr2)];
p3=p2-[(L2-Lc2)*cos(q0-qr2)+Lc3*cos(q0-qr2-qr3);(L2-Lc2)*sin(q0-qr2)+Lc3*sin(q0-qr2-qr3)];
%position matrix
p=[p0;p1;p2;p3];
%find the jacobians of velocity & angular velocity
Jv=[jacobian(p0,q);jacobian(p1,q);jacobian(p2,q);jacobian(p3,q)];
Jq=[jacobian(q0,q);jacobian(qr1,q);jacobian(qr2,q);jacobian(qr3,q)];
for i=1:4
    D=D+m(i,:)*Jv(2*i-1:2*i,:).'*Jv(2*i-1:2*i,:)+I(i,:)*Jq(i,:).'*Jq(i,:);
end
D=simplify(D) %inertia matrix 
C=D-D;
for k=1:6
for j=1:6
for i=1:6
    C(k,j)=C(k,j)+1/2*(diff(D(k,j),q(i,:))+diff(D(k,i),q(j,:))-diff(D(i,j),q(k,:)))*dq(i,:);
end
end
end
C=simplify(C) %christoffel matrix

for i=1:4
    P=P+m(i,:)*g*p(2*i,1); %potential energy
end
poten=jacobian(P,q).'; 
simplify(poten)
tau=[0;0;0;T1;T2;T3];

%passive decomposition
Mpr=-D(1:2,3:6)/(m0+m1+m2+m3);
S=simplify([eye(2) Mpr; zeros(4,2) eye(4)]);
Ms=simplify(S.'*D*S);
dS=dq0*diff(S,q0)+dqr1*diff(S,qr1)+dqr2*diff(S,qr2)+dqr3*diff(S,qr3);
Cs=simplify(S.'*D*dS+S.'*C*S);
pis=simplify(S.'*poten);
taus=simplify(S.'*tau);

ME=Ms(3:6,3:6)
CE=Cs(3:6,3:6)
TE=taus(3:6)