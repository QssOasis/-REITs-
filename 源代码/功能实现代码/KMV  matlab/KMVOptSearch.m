function [Va,AssetTheta]=KMVOptSearch(E,D,r,T,EquityTheta)
EtoD=E/D;
x0=[1,1];
VaThetaX=fsolve(@(x)KMVfun(EtoD,r,T,EquityTheta,x),x0);
Va=VaThetaX(1)*E;
AssetTheta=VaThetaX(2);

end