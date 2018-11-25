%% 2017. 06. 05 by Hyunsoo Yang yangssoo@snu.ac.kr
%% 
close all;
clf;
N = size(ScopeData.time(1:200,1));
time_s = ScopeData.time(1:200,1);
mframe = 15;
mtime = 15; %15;
res_v = ceil((N-1)/mframe/mtime/2.2);
res = res_v;
num_link = 4; length0=1*0.9;length1=1.2*0.9;length2=0.8*0.9;length3=0.8*0.9;
msf = 0.3;

theta = zeros(N(1),num_link);

for i = 1:num_link
    theta(:,i) = ScopeData.signals(1,1).values(1:200,i);
end

mov = VideoWriter('ex_video_4link_rel.avi');
% mov.Quality = 100;

hold on;
figure('units','normalized','outerposition',[0 0 1 1]); 
xlabel('x-Axis[m]','fontsize',15); ylabel('y-Axis[m]','fontsize',15); grid on;

time_=ScopeData.time;

open(mov)
i = 1;

while i<N(1)
    p_center =  zeros(3,num_link);
    p_tip =  zeros(3,1);
                                                                                                                                                             
    link0 = scale(arm_rigid([0.5 0.5 0.5],0.03,0.03,length0/2),1,1,1);
    link0 = rotatey(link0,90);
    link0 = rotatey(link0,-theta(i,1)*180/pi);
    link0 = translate(link0, p_center(1,1) ,0 , p_center(2,1));
    group_0 = combine(link0);
    
    link1 = scale(arm_rigid([0.5 0.5 0.5],0.03,0.03,length1/2),1,1,1);
    link1 = rotatey(link1,90);
    link1 = rotatey(link1,-(theta(i,1)-theta(i,2))*180/pi);
    link1 = translate(link1, length0/2*cos(theta(i,1))+length1/2*cos((theta(i,1)-theta(i,2))) ,0 , length0/2*sin(theta(i,1))+length1/2*sin((theta(i,1)-theta(i,2))));
    group_1 = combine(link1);
    
    link2 = scale(arm_rigid([0.5 0.5 0.5],0.03,0.03,length2/2),1,1,1);
    link2 = rotatey(link2,90);
    link2 = rotatey(link2,-(theta(i,1)-theta(i,3))*180/pi);
    link2 = translate(link2, -length0/2*cos(theta(i,1))-length2/2*cos(theta(i,1)-theta(i,3)) ,0 , -length0/2*sin(theta(i,1))-length2/2*sin(theta(i,1)-theta(i,3)));
    group_2 = combine(link2);
    
    link3 = scale(arm_rigid([0.5 0.5 0.5],0.03,0.03,length3/2),1,1,1);
    link3 = rotatey(link3,90);
    link3 = rotatey(link3,-(theta(i,1)-theta(i,3)-theta(i,4))*180/pi);
    link3 = translate(link3, -length0/2*cos(theta(i,1))-length2*cos(theta(i,1)-theta(i,3))-length3/2*cos(theta(i,1)-theta(i,3)-theta(i,4)) ,0 , -length0/2*sin(theta(i,1))-length2*sin(theta(i,1)-theta(i,3))-length3/2*sin(theta(i,1)-theta(i,3)-theta(i,4)));
    group_3 = combine(link3);

   if mod(i,24)==1
%     cla;
   renderpatch(group_0);
    hold on;
   renderpatch(group_1); 
    hold on;
   renderpatch(group_2);
    hold on;
   renderpatch(group_3);
    box on; 
    hold on;
    camlight LEFT;
    drawnow;    
   end
    
%    end
    view([0,-1,0]);
%     view([-0.5,-1,0.5]);
    pbaspect([3,2,2]);
    set(gca,'projection','perspective');

    set(gca,'xlim',[-2.5 2.5],'ylim',[-1  1],'zlim',[-2 2]);

    currFrame= getframe;  
    writeVideo(mov,currFrame);
%     k = k+1;    
    i = i + res(1);
    
end

close(mov);
% close all;
