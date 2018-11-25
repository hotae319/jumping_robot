function arm = arm_hs(color,x,y,z)
%using renderer developed by Bruce R. Land, Electrical and Computer Engineering, Cornell University

%close all;

square1=scale(UnitCylinder(10),x,y,z);
square1.facecolor=color;
body=translate(square1,0,0,0);


Wc = scale(UnitSphere(10),0.05,0.05,0.05);
Wc = translate(Wc,0,0,z);
Wc.facecolor = [1.0,0.7,0.3];

arm = combine(body,Wc);
   
%camlight
%box on
%view(30,30)
%daspect([1 1 1])