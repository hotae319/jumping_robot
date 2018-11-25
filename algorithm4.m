%Parameter 
tic
count=0; count1=0;
dgain=3*[24;24;24;24];pgain=1/4*[dgain(1)^2;dgain(2)^2;dgain(3)^2;dgain(4)^2];
ini=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi; 0;0;0;0];
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
    qzero1(1:8,1)=qzero(1:8,1);
    qzero1(9)=desire(1);
    qzero1=sort(qzero1); %arrange qzero ascendingly
    i=find(qzero1==desire(1));

%% 8 testing point(vertex)
if(i==1 || i==9)
    if(i==1)
        i1=find(qzero==qzero1(2));
    else
        i1=find(qzero==qzero1(8));
    end 
    ni=0; n=12; ni1=i1; qzeron=zeros(n,1);qzeron1=zeros(n+1,1);
    ntesting=zeros(3,n); ntesting(:,ni1)=testing(:,i1);
while (ni==1 || ni==n+1 || ni==0) 
    % n division searching
    if(ni==1)
        ni1=find(qzeron==qzeron1(2));
    elseif(ni==n+1)
        ni1=find(qzeron==qzeron1(n));
    end 
    ntesting=ntesting(:,ni1)*ones(1,n);
    switch mod(count,3)
        case 0 % qr1 direction             
                for k = 1 : n
                ntesting(1,k)=pi/6-(k-1)/n*(pi/6-(-11*pi/6));
                end           
        case 1 % qr2 direction
                for k = 1 : n
                ntesting(2,k)=pi-(k-1)/8*(pi-(-pi/6));
                end
        case 2 % qr3 direction
                for k = 1 : n
                ntesting(3,k)=-(k-1)/8*(0-(-pi));
                end
    end
    count=count+1
    for j = 1 : n   
        side1=-ini(2)+ntesting(1,j);
        side2=-ini(3)+ntesting(2,j);
        side3=-ini(4)+ntesting(3,j);
        sim('sim_ex_4link_rel_new_method');
        qzeron(j)=ScopeData.signals(1,1).values(200,1);
    end
    qzeron1(1:n,1)=qzeron(1:n,1);
    qzeron1(n+1)=desire(1);
    qzeron1=sort(qzeron1); %arrange qzero ascendingly
    ni=find(qzeron1==desire(1));
end
    j1=find(qzeron==qzeron1(ni-1)); % less
    j2=find(qzeron==qzeron1(ni+1)); % greater
    x=0;
else
    j1=find(qzero==qzero1(i-1)); % less
    j2=find(qzero==qzero1(i+1)); % greater
    x=1;
end
      
%% testing (j1), testing(j2) internal division
if(x==1)
    oldtestlow=testing(:,j1);
    oldtesthigh=testing(:,j2);
else
    oldtestlow=ntesting(:,j1);
    oldtesthigh=ntesting(:,j2);
end
    newtest=(oldtestlow+oldtesthigh)/2;
    side1=-ini(2)+newtest(1);
    side2=-ini(3)+newtest(2);
    side3=-ini(4)+newtest(3);
    sim('sim_ex_4link_rel_new_method');
    while abs(ScopeData.signals(1,1).values(200,1)-desire(1))>0.03
         if(ScopeData.signals(1,1).values(200,1)>desire(1))
            oldtesthigh=newtest;
            newtest=(oldtesthigh+oldtestlow)/2;
            side1=-ini(2)+newtest(1);
            side2=-ini(3)+newtest(2);
            side3=-ini(4)+newtest(3);
            sim('sim_ex_4link_rel_new_method');
        elseif(ScopeData.signals(1,1).values(200,1)<desire(1))
            oldtestlow=newtest;
            newtest=(oldtestlow+oldtesthigh)/2;
            side1=-ini(2)+newtest(1);
            side2=-ini(3)+newtest(2);
            side3=-ini(4)+newtest(3);
            sim('sim_ex_4link_rel_new_method');
        else
        end
        count1=count1+1
    end
    ScopeData.signals(1,1).values(200,1:4)
    figure
    plot3(ScopeData.signals(1,1).values(1:200,2),ScopeData.signals(1,1).values(1:200,3),ScopeData.signals(1,1).values(1:200,4),'ro')
    grid on
    title('qr 3D trajectory');
    xlabel('qr1 axis');
    ylabel('qr2 axis');
    zlabel('qr3 axis');

toc

