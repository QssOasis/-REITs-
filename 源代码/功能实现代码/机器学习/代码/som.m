A = xlsread('D:\pingji.xlsx');
n=13;
for i=1:n
     A(i,:)=(A(i,:)-min(A(i,:)))/(max(A(i,:))-min(A(i,:)));
end
A=A';    %%%È¡×ªÖÃ¾ØÕó
AA=A([1:1:30],:)';
net=newsom(minmax(AA),[1 3]);

a=[1000 2000 3000 4000 5000 6000];
for i=1:6
    net.trainParam.epochs=a(i);
    net=train(net,AA);
    y=sim(net,AA);
    yc=vec2ind(y);
end

pt=AA;
C=yc;
T=ind2vec(C);
n1=1;
n2=1;n3=1;n4=1;
n5=1;n6=1;n7=1;
n8=1;n9=1;n10=1;
n11=1;n12=1;n13=1;
a1=[];a2=[];a3=[];
a4=[];a5=[];a6=[];
a7=[];a8=[];a9=[];
a10=[];a11=[];
a12=[];a13=[];
for i=1:100
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
    if C(i)==5
        a5(n5)=i;
        n5=n5+1;
    end
    if C(i)==6
        a6(n6)=i;
        n6=n6+1;
    end
    if C(i)==7
        a7(n7)=i;
        n7=n7+1;
    end
    if C(i)==8
        a8(n8)=i;
        n8=n8+1;
    end
    if C(i)==9
        a9(n9)=i;
        n9=n9+1;
    end
    if C(i)==10
        a10(n10)=i;
        n10=n10+1;
    end
    if C(i)==11
        a11(n11)=i;
        n11=n11+1;
    end
    if C(i)==12
        a12(n12)=i;
        n12=n12+1;
    end
    if C(i)==13
        a13(n13)=i;
        n13=n13+1;
    end
end
