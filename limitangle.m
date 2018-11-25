vertex=[pi/6 -pi/6 -pi;pi/6 pi -pi;-11*pi/6 pi -pi;-11*pi/6 -pi/6 -pi;pi/6 -pi/6 0;pi/6 pi 0;-11*pi/6 pi 0;-11*pi/6 -pi/6 0];
face=[1 2 3 4; 1 2 6 5; 2 3 7 6; 3 4 8 7; 1 4 8 5; 5 6 7 8];
patch('Faces',face,'Vertices',vertex,'Facecolor',[0.2 0.8 0.6]);
grid on;
title('limit angle range');
xlabel('\theta_{1}');
ylabel('\theta_{2}');
zlabel('\theta_{3}');
axis auto
view(3);

