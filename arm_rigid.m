function arm = arm_rigid(color,x,y,z)
%using renderer developed by Bruce R. Land, Electrical and Computer Engineering, Cornell University

%close all;



square1=scale(UnitCylinder(10),x,y,z);
square1.facecolor=color;
body=translate(square1,0,0,0);

Wc1 = scale(UnitSphere(10),0.05,0.05,0.05);
Wc1 = translate(Wc1,0,0,-z);
Wc1.facecolor = [1.0,0.7,0.3];


Wc = scale(UnitSphere(10),0.05,0.05,0.05);
Wc = translate(Wc,0,0,z);
Wc.facecolor = [1.0,0.7,0.3];

arm = combine(body,Wc,Wc1);
   
%camlight
%box on
%view(30,30)
%daspect([1 1 1])