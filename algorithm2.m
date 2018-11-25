%Parameter 
tic
count=0; count1=0;
dgain=[24;24;24;24];pgain=1/4*[dgain(1)^2;dgain(2)^2;dgain(3)^2;dgain(4)^2];
ini=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi; 0;0;0;0];
desire=[6*pi/12+pi/9;-10/6*pi;pi/3;-2*pi/18];
kk=[296;296;296;296];
qzero=zeros(8,1);
qzero1=zeros(9,1); 
testing=[pi/6 pi/6 pi/6 pi/6 -11*pi/6 -11*pi/6 -11*pi/6 -11*pi/6;...
         pi pi -pi/6 -pi/6 -pi/6 -pi/6 pi pi ;...
         0 -pi -pi 0 0 -pi -pi 0];
i=1; 
%% 8 testing point(vertex)
while (i==1 || i==9) 
while count <3 && (i==1 || i==9)
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
if(i==1 || i==9)
        for k = 1 : 8
            if(k==4)
                testing(:,k)=(testing(:,k)+testing(:,1))/2;
            elseif(k==8)
                testing(:,k)=(testing(:,k)+testing(:,5))/2;
            end
        end 
   count=count+1
end
end
%random fun. introduction
        rtest=zeros(2,3);
        rtest(1,1)=(pi/6-11*pi/6)/2+(pi/6-(pi/6-11*pi/6)/2)*rand(1);
        rtest(2,1)=-11*pi/6+((pi/6-11*pi/6)/2-(-11*pi/6))*rand(1);
        rtest(1,2)=(pi-pi/6)/2+(pi-(pi-pi/6)/2)*rand(1);
        rtest(2,2)=-pi/6+((pi-pi/6)/2-(-pi/6))*rand(1);
        rtest(1,3)=-pi/2+(0-(-pi/2))*rand(1);
        rtest(2,3)=-pi+pi/2*rand(1);
        testing=[rtest(1,1) rtest(1,1) rtest(1,1) rtest(1,1) rtest(2,1) rtest(2,1) rtest(2,1) rtest(2,1);...
                 rtest(1,2) rtest(1,2) rtest(2,2) rtest(2,2) rtest(1,2) rtest(1,2) rtest(2,2) rtest(2,2);...
                 rtest(1,3) rtest(2,3) rtest(1,3) rtest(2,3) rtest(1,3) rtest(2,3) rtest(1,3) rtest(2,3)]
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
    count1=count1+1
end
    j1=find(qzero==qzero1(i-1)); % less
    j2=find(qzero==qzero1(i+1)); % greater  
%% testing (j1), testing(j2) internal division
newtest=(testing(:,j1)+testing(:,j2))/2;
    side1=-ini(2)+newtest(1,i);
    side2=-ini(3)+newtest(2,i);
    side3=-ini(4)+newtest(3,i);
    sim('sim_ex_4link_rel_new_method');
    while abs(ScopeData.signals(1,1).values(200,1)-desire(1)>0.05)
        if(ScopeData.signals(1,1).values(200,1)>desire(1))
            newtest=(newtest+testing(:,j1)/2);
            side1=-ini(2)+newtest(1,i);
            side2=-ini(3)+newtest(2,i);
            side3=-ini(4)+newtest(3,i);
            sim('sim_ex_4link_rel_new_method');
        elseif(ScopeData.signals(1,1).values(200,1)<desire(1))
            newtest=(newtest+testing(:,j2)/2);
            side1=-ini(2)+newtest(1,i);
            side2=-ini(3)+newtest(2,i);
            side3=-ini(4)+newtest(3,i);
            sim('sim_ex_4link_rel_new_method');
        else
        end
    end
toc

        