function cone=UnitCone

[X,Y,Z]=cylinder([0;1]);

cone.vertices=[0,0,0;X(2,:)',Y(2,:)', Z(2,:)';0,0,1];
for i=1:length(X(1,:))-2
    cone.faces(i,:)=[1,i+1,i+2];
end
    cone.faces(i+1,:)=[1,i+2,2];

for i=1:length(X(1,:))-2
    cone.faces(i+length(X(1,:))-1,:)=[length(X(1,:))+2,i+1,i+2];
end
    cone.faces(2*length(X(1,:))-2,:)=[length(X(1,:))+2,i+2,2];
