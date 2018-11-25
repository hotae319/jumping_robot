%%

N = size(ScopeData.time(:,1));

num_link = 3;
num_mode = 2;
length0=1;length1=1;length2=1;

theta = zeros(N(1),num_link);

for i = 1:num_link
    theta(:,i) = ScopeData.signals(1,1).values(:,i);
end

x_pole_0=[0, 0+length0*cos(theta(1,1))];
y_pole_0=[0, 0+length0*sin(theta(1,1))];
x_pole_1=[x_pole_0(1,2), x_pole_0(1,2)+length1*cos(theta(1,2))];
y_pole_1=[y_pole_0(1,2), y_pole_0(1,2)+length1*sin(theta(1,2))];    
x_pole_2=[x_pole_0(1,1)-length2*cos(theta(1,3)), x_pole_0(1,1)];
y_pole_2=[y_pole_0(1,1)-length2*sin(theta(1,3)), y_pole_0(1,1)];

pole0 = fill(x_pole_0,y_pole_0,'b','EraseMode','normal');



hold on;
pole1 = fill(x_pole_1,y_pole_1,'b','EraseMode','normal');
hold on;
pole2 = fill(x_pole_2,y_pole_2,'b','EraseMode','normal');
grid on;
xlabel('x-position(m)');
ylabel('y-position(m)');
hold off

axis([-2 4 -3 3]);
pbaspect([1,1,1]);

% simul2=VideoWriter('feed3.avi');
% open(simul2);

for t=1:N(1,1)
    
    updatedX_pole_0=[0, 0+length0*cos(theta(t,1))];
    updatedY_pole_0=[0, 0+length0*sin(theta(t,1))];
    updatedX_pole_1=[updatedX_pole_0(1,2), updatedX_pole_0(1,2)+length1*cos(theta(t,2))];
    updatedY_pole_1=[updatedY_pole_0(1,2), updatedY_pole_0(1,2)+length1*sin(theta(t,2))];    
    updatedX_pole_2=[updatedX_pole_0(1,1)-length2*cos(theta(t,3)), updatedX_pole_0(1,1)];
    updatedY_pole_2=[updatedY_pole_0(1,1)-length2*sin(theta(t,3)), updatedY_pole_0(1,1)];
    set(pole0,'Xdata',updatedX_pole_0,'Ydata',updatedY_pole_0);
    set(pole1,'Xdata',updatedX_pole_1,'Ydata',updatedY_pole_1);
    set(pole2,'Xdata',updatedX_pole_2,'Ydata',updatedY_pole_2);
    
    drawnow;
 
%    fr=getframe;
%    writeVideo(simul2,fr);
end

% close(simul2);