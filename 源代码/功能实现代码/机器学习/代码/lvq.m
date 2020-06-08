Pt=PP;
C=yc;
T=ind2vec(C);
n1=1;
n2=1;n3=1;n4=1;

a1=[];a2=[];a3=[];
a4=[];
for i=1:57
    if C(i)==1
        a1(n1)=i;
        n1=n1+1;
    end
    if C(i)==2
        a2(n2)=i;
        n2=n2+1;
    end
    if C(i)==3
        a3(n3)=i;
        n3=n3+1;
    end
    if C(i)==4
        a4(n4)=i;
        n4=n4+1;
    end    
end
B=[(n1-1);(n2-1);(n3-1);(n4-1)]'/57;
lvqnet=newlvq(minmax(Pt),4,B);
lvqnet.IW{1,1}=net.IW{1,1};
a=[20 40 60 80 100];
for i=1:5
    lvqnet.trainParam.epochs=a(i);
    lvqnet=train(lvqnet,Pt,T);
    yy=sim(lvqnet,Pt);
    C=vec2ind(yy);
end








