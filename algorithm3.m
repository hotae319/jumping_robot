%Parameter 
tic
count=0; count1=0;
dgain=[24;24;24;24];pgain=1/4*[dgain(1)^2;dgain(2)^2;dgain(3)^2;dgain(4)^2];
ini=[3/4*pi; -1/4*pi; 1/12*pi; -1/3*pi; 0;0;0;0];
desire=[6*pi/12+pi/18;-10/6*pi;pi/3;-2*pi/18];
kk=[296;296;296;296];
qzero=zeros(8,1);
qzero1=zeros(9,1); 
testing0=[pi/6 pi/6 pi/6 pi/6 -11*pi/6 -11*pi/6 -11*pi/6 -11*pi/6;...
         pi pi -pi/6 -pi/6 -pi/6 -pi/6 pi pi ;...
         0 -pi -pi 0 0 -pi -pi 0];
testing=testing0;
i=1; 
%% 8 testing point(vertex)
while (i==1 || i==9) 
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
    if(i==1||i==9)
        if(i==1)
            i1=find(qzero==qzero1(2));
        else
            i1=find(qzero==qzero1(8));
        end    
        switch mod(count,3)
            case 0 % qr1 direction
                if(testing(1,i1)==pi/6)
                    for k = 1 : 8
                    testing(:,k)=testing(:,i1)-[k/8*(pi/6-(-11*pi/6));0;0];
                    end
                elseif(testing(1,i1)==-11*pi/6)
                    for k = 1 : 8
                    testing(:,k)=testing(:,i1)+[k/8*(pi/6-(-11*pi/6));0;0];
                    end
                end
            case 1 %qr2 direction
                if(testing(1,i1)==pi)
                    for k = 1 : 8
                    testing(:,k)=testing(:,i1)-[0;k/8*(pi-(-pi/6));0];
                    end
                elseif(testing(1,i1)==-pi/6)
                    for k = 1 : 8
                    testing(:,k)=testing(:,i1)+[0;k/8*(pi-(-pi/6));0];
                    end
                end 
            case 2 %qr3 direction
                if(testing(1,i1)==0)
                    for k = 1 : 8
                    testing(:,k)=testing(:,i1)-[0;0;k/8*(0-(-pi))];
                    end
                elseif(testing(1,i1)==-pi)
                    for k = 1 : 8
                    testing(:,k)=testing(:,i1)+[0;0;k/8*(0-(-pi))];
                    end
                end
        end
        count=count+1    
    end
end
    j1=find(qzero==qzero1(i-1)); % less
    j2=find(qzero==qzero1(i+1)); % greater  
%% testing (j1), testing(j2) internal division
oldtestlow=testing(:,j1);
oldtesthigh=testing(:,j2);
newtest=(oldtestlow+oldtesthigh)/2;
    side1=-ini(2)+newtest(1);
    side2=-ini(3)+newtest(2);
    side3=-ini(4)+newtest(3);
    sim('sim_ex_4link_rel_new_method');
    while abs(ScopeData.signals(1,1).values(200,1)-desire(1)>0.03)
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
    ScopeData.signals(1,1).values(200,1)
toc

