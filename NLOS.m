clear all; 
%close all; clc;

%dt= [1:1:160]; % Distance of Tx
dt= [1:1:160]; % Distance of Tx
dr= [1:1:160]; % Distance de Rx
iteraciones=500;

PDRprob=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
dw= 5; % Distance of Tx to the wall
wr= 18; % Width of Rx street 18 m

is= 1; % Theenviroment parameter (1 for suburban an enviroment and 0 for urban)
c=3E8;
f=5.89E9;
lambda=c/f; % Wave lenght
nNLOS=2.69; % Path loss exponent
mu=0; % Zero mean
sigma= 4.1; % Standard deviation of sigma=4.1dB 
%Xsigma= normrnd(mu,sigma)
PTx= 20; % Transmit power 20dB
Again=3; % Antenna gain 3 dB
ht=1.45; % Heigth Tx
hr=1.45; % Heigth Rx
db1= (ht*hr)/lambda; % Critical distance 100m
db= 100; % Critical distance 100m
alphaNLOS=3.75 +2.94*is;
nt=0.957;
BetaNLOS1= (1/(((dw*wr))^0.81))*((4*pi)/(lambda)); 
BetaNLOS2= (1/(((dw*wr))^0.81))*((4*pi)/(lambda*db)); 
nr1=1;
nr2=2;

PL_NLOS = zeros(length(dr), length(dt));


for i=1:iteraciones


for idt=1:1:length(dt)
  for idr=1:1:length(dr)
      if idr <= db
          Xsigma= normrnd(mu,sigma);
          
          temp = alphaNLOS + (10*nNLOS*log10(BetaNLOS1*(dt(idt)^nt)*(dr(idr)^nr1))) + Xsigma;
                    PL_NLOS(idr, idt)= PL_NLOS(idr, idt) + temp;
                
                                
      else
          Xsigma= normrnd(mu,sigma);
          
          temp = alphaNLOS + (10*nNLOS*log10(BetaNLOS2*(dt(idt)^nt)*(dr(idr)^nr2))) + Xsigma;
                    PL_NLOS(idr, idt)= PL_NLOS(idr, idt) + temp; 
                
                
      end
    end
end

end


PL_NLOS=PL_NLOS./iteraciones;

PRx= PTx +Again -PL_NLOS;
PRx1=PRx;
% figure(1)
% pcolor(PRx1)
% figure(2)
% pcolor(PRx1)



PRx=-PRx;

aNLOS= 1.319e-026; bNLOS= -0.6473;

% for p=1:1:length(dt)
%     for pp=1:1:length(dr)
%      PRx(pp,p)=real(10^(PRx(pp,p)/10));
%     end
% end

for n=1:1:length(dt)
   for m=1:1:length(dr)
        Pnlos(m,n)= 1 - aNLOS*exp(-bNLOS*PRx(m,n));
   end  
end   


for n=1:1:length(dt)
   for m=1:1:length(dr)
       if  Pnlos(m,n)< 0
            Pnlos(m,n)=0; 
       else
       end
   end   
end
  

% for n=1:1:length(dt)
%    for m=1:1:length(dr)
%        if Ps(m,n)< 0
%            Ps(m,n)=0; 
%        end
%        if  Ps(m,n)> 0.9
%            Ps(m,n)=1;
%        else
%        end
%    end   
% end
  

figure()
pcolor(Pnlos);
hold on

save('ProbNLOS.mat','Pnlos')
