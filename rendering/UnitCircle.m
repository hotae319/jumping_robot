function circle=UnitCircle(res)

if (res>10)
   res=10;
elseif (res<1)
   res=1;
end
theta_=-pi:0.2:pi;
x=cos(theta_);
y=sin(theta_);
circle.vertices=[0,0,0;x',y',zeros(length(x),1)];
for i=1:length(x)-2
    circle.faces(i,:)=[1,i+1,i+2];
end
circle.faces(i+1,:)=[1,i+2,2];


