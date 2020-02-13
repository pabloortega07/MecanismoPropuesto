clear all
clc
close all
load VariablesGlobales 
load ProbNLOS


ProbModel=Pnlos;
Veh_x_Rx=1;
Veh_y_Tx=2;
ZonaRSU=1;

%Veh_y=[10 10 10 10];
Density_x=length(Veh_x);
Density_y=length(Veh_y);



%%
for kx=3:4:Density_x
    VehiculosRx=Veh_x(1,kx);
%%    
    for ky=1:1:Density_y
        VehiculosTx=Veh_y(1,ky);
                
%%       
for iteracion=1:1:iteracciones
            
            
                 [pos_vehX_Rx,pos_vehY_Tx]=UbicacionNodos_TxRx(pos_vehX_xini_Rx,pos_vehX_xend_Rx,pos_vehY_yini_Tx,pos_vehY_yend_Tx,width_x,width_y,Veh_x_Rx,Veh_y_Tx);   
                 [pos_vehX,pos_vehY]=UbicacionNodos(pos_vehX_xini,pos_vehX_xend,pos_vehY_yini,pos_vehY_yend,width_x,width_y,VehiculosRx,VehiculosTx);   
                 
                 pos_vehX(1,:)=pos_vehX_Rx;
                 pos_vehY(1,:)=pos_vehY_Tx(1,:);
                 pos_vehY(2,:)=pos_vehY_Tx(2,:);
                 
                 
                % pos_vehX=[-9 2]
 %%        
             for i=1:1:VehiculosTx
                 % [d]=round(distancia(pos_vehY(i,1),pos_vehY(i,2),0,0));
                  [d]=abs(pos_vehY(i,2)); 
                  p=pos_vehY(i,2);
                  [ZonaA]=ZonificarY(d,p);
                  zona_vehY(i,1)=d;
                  zona_vehY(i,2)=ZonaA;
                  Ay5=sum(zona_vehY(:,2)==5);
                  Ay4=sum(zona_vehY(:,2)==4);
                  Ay3=sum(zona_vehY(:,2)==3);
                  Ay2=sum(zona_vehY(:,2)==2);
                  Ay1=sum(zona_vehY(:,2)==1);                 
             end   % i=1:1:VehiculosTx    
       
             Ay=[Ay1 Ay2 Ay3 Ay4 Ay5];
             
             
             for i=1:1:VehiculosRx
                  %[d]=round(distancia(pos_vehX(i,1),pos_vehX(i,2),0,0));
                  [d]=abs(pos_vehX(i,1));
                  p=pos_vehX(i,1);
                  [ZonaA]=ZonificarX(d,p);
                  zona_vehX(i,1)=d;
                  zona_vehX(i,2)=ZonaA;
                  Ax5=sum(zona_vehX(:,2)==5);
                  Ax4=sum(zona_vehX(:,2)==4);
                  Ax3=sum(zona_vehX(:,2)==3);
                  Ax2=sum(zona_vehX(:,2)==2);
                  Ax1=sum(zona_vehX(:,2)==1);                 
             end % i=1:1:VehiculosRx
             
             Ax=[Ax1 Ax2 Ax3 Ax4 Ax5];
             
        
            %% RELAY ZONES
            
            ZonaRx=zona_vehX(1,2);
            ZonaTx=zona_vehY(1,2);
            
            [Relay]= control(ZonaTx,Ax); 
            
                if Relay==0

                [Ps]=Review1(ZonaTx,ZonaRx,Ax,Ay,Pa,TwoPa);
                Prob(iteracion,ky)=Ps;
                Ps_Tx_Rx=Ps; 
                model_Ps_Tx_Rx=ProbModel(zona_vehX(1,1),zona_vehY(1,1));
                PDR(iteracion,ky)=(Ps_Tx_Rx*model_Ps_Tx_Rx);
                

                else
                     Receptor=zona_vehX(1,1);
                     Transmisor=zona_vehY(1,1);
                     RSU=1;
                     
                     [Ps]=Review1(ZonaTx,ZonaRx,Ax,Ay,Pa,TwoPa);
                     Ps_Tx_Rx=Ps;
                     model_Ps_Tx_Rx=ProbModel(Receptor,Transmisor);
                     
                     [Ps]=Review1(ZonaTx,ZonaRSU,Ax,Ay,Pa,TwoPa);
                     Ps_Tx_RSU=Ps;
                     model_Ps_Tx_RSU=ProbModel(ZonaRSU,Transmisor);
                     
                     
                     [Ps]=Review1(ZonaRSU,ZonaRx,Ax,Ay,Pa,TwoPa);
                     Ps_RSU_Rx=Ps;
                     model_Ps_RSU_Rx=ProbModel(Receptor,ZonaRSU);
                     
                     
                     Prob(iteracion,ky)=Ps_Tx_Rx + ((1-Ps_Tx_Rx)*Ps_Tx_RSU*Ps_RSU_Rx);
                     
                     
                     PDR(iteracion,ky)=(Ps_Tx_Rx*model_Ps_Tx_Rx) + ((1-(Ps_Tx_Rx*model_Ps_Tx_Rx))*(Ps_Tx_RSU*model_Ps_Tx_RSU)*(Ps_RSU_Rx*model_Ps_RSU_Rx));
               end    
      
            %%%  end RELAY ZONES

        
            %% RELAY NETWOKCODING
        
          %for NCy=1:2:VehiculosTx-1
           for NCy=1:2:Veh_y_Tx;
                    ZonaTx1=zona_vehY(NCy,2);
                    ZonaTx2=zona_vehY(NCy+1,2);
                    Receptor=zona_vehX(1,1);
                    Transmisor1=zona_vehY(NCy,1);
                    Transmisor2=zona_vehY(NCy+1,1);
                    RSU=1;
          
                     [Ps]=Review1(ZonaTx1,ZonaRx,Ax,Ay,Pa,TwoPa);
                     NC_Ps_Tx1_Rx=Ps;
                     NC_model_Ps_Tx1_Rx=ProbModel(Receptor,Transmisor1);
                     
                     [Ps]=Review1(ZonaTx2,ZonaRx,Ax,Ay,Pa,TwoPa);
                     NC_Ps_Tx2_Rx=Ps;
                     NC_model_Ps_Tx2_Rx=ProbModel(Receptor,Transmisor2); 
                    
                     [Ps]=Review1(ZonaTx1,ZonaRSU,Ax,Ay,Pa,TwoPa);
                     NC_Ps_Tx1_RSU=Ps;
                     NC_model_Ps_Tx1_RSU=ProbModel(ZonaRSU,Transmisor1);             
                    
                     [Ps]=Review1(ZonaTx2,ZonaRSU,Ax,Ay,Pa,TwoPa);
                     NC_Ps_Tx2_RSU=Ps;
                     NC_model_Ps_Tx2_RSU=ProbModel(ZonaRSU,Transmisor2);
                     
                     [Ps]=Review1(ZonaRSU,ZonaRx,Ax,Ay,Pa,TwoPa);
                     NC_Ps_RSU_Rx=Ps;
                     NC_model_Ps_RSU_Rx=ProbModel(Receptor,ZonaRSU);
                     
                    NC_Prob(iteracion,ky)= (NC_Ps_Tx1_RSU*NC_Ps_Tx2_RSU*NC_model_Ps_RSU_Rx)*( NC_Ps_Tx1_Rx + ((1-NC_Ps_Tx1_Rx)*NC_Ps_Tx2_Rx ));
                    
                    NC_PDR(iteracion,ky)= ((NC_Ps_Tx1_RSU*NC_model_Ps_Tx1_RSU)*(NC_Ps_Tx2_RSU*NC_model_Ps_Tx2_RSU)*(NC_model_Ps_RSU_Rx*NC_model_Ps_RSU_Rx))*( (NC_Ps_Tx1_Rx*NC_model_Ps_Tx1_Rx) + ((1-(NC_Ps_Tx1_Rx*NC_model_Ps_Tx1_Rx))*(NC_Ps_Tx2_Rx*NC_model_Ps_Tx2_Rx) ));
                                
          end
             
            %%% end RELAY RELAY NETWOKCODING
        
        
         %% RELAY ZONES WITH NETWOKCODING    
            
        
           for NCy=1:2:Veh_y_Tx;
                    ZonaTx1=zona_vehY(NCy,2);
                    ZonaTx2=zona_vehY(NCy+1,2);
                    Receptor=zona_vehX(1,1);
                    Transmisor1=zona_vehY(NCy,1);
                    Transmisor2=zona_vehY(NCy+1,1);
                    RSU=1;
          
                     if ZonaTx1 > ZonaTx2
                        ZonaTx=ZonaTx1; % Transmisor
                     end
                     if ZonaTx2 > ZonaTx1    
                       ZonaTx=ZonaTx2; % Transmisor
                     end
                     if ZonaTx2 == ZonaTx1    
                       ZonaTx=ZonaTx1; % Transmisor
                     end                   
           
             %%%%%   [Relay]= control(ZonaTx,Ax);
                
              %%%%%  if Relay==0
                    
                    ZonaTx1=zona_vehY(NCy,2);
                    ZonaTx2=zona_vehY(NCy+1,2);
                    Receptor=zona_vehX(1,1);
                    Transmisor1=zona_vehY(NCy,1);
                    Transmisor2=zona_vehY(NCy+1,1);
                    RSU=1;
          
                     [Ps]=Review1(ZonaTx1,ZonaRx,Ax,Ay,Pa,TwoPa);
                     ZonesNC_Ps_Tx1_Rx=Ps;
                     ZonesNC_model_Ps_Tx1_Rx=ProbModel(Receptor,Transmisor1);
                     
                     [Ps]=Review1(ZonaTx2,ZonaRx,Ax,Ay,Pa,TwoPa);
                     ZonesNC_Ps_Tx2_Rx=Ps;
                     ZonesNC_model_Ps_Tx2_Rx=ProbModel(Receptor,Transmisor2); 
                    
                     [Ps]=Review1(ZonaTx1,ZonaRSU,Ax,Ay,Pa,TwoPa);
                     ZonesNC_Ps_Tx1_RSU=Ps;
                     ZonesNC_model_Ps_Tx1_RSU=ProbModel(ZonaRSU,Transmisor1);             
                    
                     [Ps]=Review1(ZonaTx2,ZonaRSU,Ax,Ay,Pa,TwoPa);
                     ZonesNC_Ps_Tx2_RSU=Ps;
                     ZonesNC_model_Ps_Tx2_RSU=ProbModel(ZonaRSU,Transmisor2);
                     
                     [Ps]=Review1(ZonaRSU,ZonaRx,Ax,Ay,Pa,TwoPa);
                     ZonesNC_Ps_RSU_Rx=Ps;
                     ZonesNC_model_Ps_RSU_Rx=ProbModel(Receptor,ZonaRSU);
                     
                    ZonesNC_Prob(iteracion,ky)= (ZonesNC_Ps_Tx1_RSU*ZonesNC_Ps_Tx2_RSU*ZonesNC_model_Ps_RSU_Rx)*( ZonesNC_Ps_Tx1_Rx + ((1-ZonesNC_Ps_Tx1_Rx)*ZonesNC_Ps_Tx2_Rx ));
                    
                    ZonesNC_PDR(iteracion,ky)= ((ZonesNC_Ps_Tx1_RSU*ZonesNC_model_Ps_Tx1_RSU)*(ZonesNC_Ps_Tx2_RSU*ZonesNC_model_Ps_Tx2_RSU)*(ZonesNC_model_Ps_RSU_Rx*ZonesNC_model_Ps_RSU_Rx))*( (ZonesNC_Ps_Tx1_Rx*ZonesNC_model_Ps_Tx1_Rx) + ((1-(ZonesNC_Ps_Tx1_Rx*ZonesNC_model_Ps_Tx1_Rx))*(ZonesNC_Ps_Tx2_Rx*ZonesNC_model_Ps_Tx2_Rx) ));
                                       
    
          end
         
         %%% end RELAY ZONES WITH NETWOKCODING
         
                  %% RELAY SIMPLE
            
            ZonaRx=zona_vehX(1,2);
            ZonaTx=zona_vehY(1,2);
            
                     Receptor=zona_vehX(1,1);
                     Transmisor=zona_vehY(1,1);
                     RSU=1;
                     
                     [Ps]=Review1(ZonaTx,ZonaRx,Ax,Ay,Pa,TwoPa);
                     RS_Ps_Tx_Rx=Ps;
                     RS_model_Ps_Tx_Rx=ProbModel(Receptor,Transmisor);
                     
                     [Ps]=Review1(ZonaTx,ZonaRSU,Ax,Ay,Pa,TwoPa);
                     RS_Ps_Tx_RSU=Ps;
                     RS_model_Ps_Tx_RSU=ProbModel(ZonaRSU,Transmisor);
                     
                     
                     [Ps]=Review1(ZonaRSU,ZonaRx,Ax,Ay,Pa,TwoPa);
                     RS_Ps_RSU_Rx=Ps;
                     RS_model_Ps_RSU_Rx=ProbModel(Receptor,ZonaRSU);
                     
                     
                     RS_Prob(iteracion,ky)=RS_Ps_Tx_Rx + ((1-RS_Ps_Tx_Rx)*RS_Ps_Tx_RSU*RS_Ps_RSU_Rx);
                     
                     
                     RS_PDR(iteracion,ky)=(RS_Ps_Tx_Rx*RS_model_Ps_Tx_Rx) + ((1-(RS_Ps_Tx_Rx*RS_model_Ps_Tx_Rx))*(RS_Ps_Tx_RSU*RS_model_Ps_Tx_RSU)*(RS_Ps_RSU_Rx*RS_model_Ps_RSU_Rx));
                 
      
            %%%  end RELAY SIMPLE
        
       %% RELAY LOS
            
            ZonaRx=zona_vehX(1,2);
            ZonaTx=zona_vehY(1,2);
            
                              
                    xa=[5 5]; % RSU
                    xs=[zona_vehY(1,1) zona_vehY(1,2)]; % Transmisor
                    xf=[zona_vehX(1,1) zona_vehX(1,2)]; % Receptor
                
                    lvl=(xa-xs)-((((xa-xs).*(xf-xs))/((xf-xs).^2))).*(xf-xs);
                    [dlvl]=distancia(lvl(1,1),lvl(1,2),xa(1,1),xa(1,2)); 
            
                     if dlvl < 4
                         Relay=0;    
                     else
                        Relay=1;
                    end
            
                if Relay==0

                [Ps]=Review1(ZonaTx,ZonaRx,Ax,Ay,Pa,TwoPa);
                LOS_Prob(iteracion,ky)=Ps;
                LOS_Ps_Tx_Rx=Ps; 
                LOS_model_Ps_Tx_Rx=ProbModel(zona_vehX(1,1),zona_vehY(1,1));
                LOS_PDR(iteracion,ky)=(LOS_Ps_Tx_Rx*LOS_model_Ps_Tx_Rx);
                

                else
                     LOS_Receptor=zona_vehX(1,1);
                     LOS_Transmisor=zona_vehY(1,1);
                     RSU=1;
                     
                     [Ps]=Review1(ZonaTx,ZonaRx,Ax,Ay,Pa,TwoPa);
                     LOS_Ps_Tx_Rx=Ps;
                     LOS_model_Ps_Tx_Rx=ProbModel(Receptor,Transmisor);
                     
                     [Ps]=Review1(ZonaTx,ZonaRSU,Ax,Ay,Pa,TwoPa);
                     LOS_Ps_Tx_RSU=Ps;
                     LOS_model_Ps_Tx_RSU=ProbModel(ZonaRSU,Transmisor);
                     
                     
                     [Ps]=Review1(ZonaRSU,ZonaRx,Ax,Ay,Pa,TwoPa);
                     LOS_Ps_RSU_Rx=Ps;
                     LOS_model_Ps_RSU_Rx=ProbModel(Receptor,ZonaRSU);
                     
                     
                     LOS_Prob(iteracion,ky)=LOS_Ps_Tx_Rx + ((1-LOS_Ps_Tx_Rx)*LOS_Ps_Tx_RSU*LOS_Ps_RSU_Rx);
                     
                     
                     LOS_PDR(iteracion,ky)=(LOS_Ps_Tx_Rx*LOS_model_Ps_Tx_Rx) + ((1-(LOS_Ps_Tx_Rx*LOS_model_Ps_Tx_Rx))*(LOS_Ps_Tx_RSU*LOS_model_Ps_Tx_RSU)*(LOS_Ps_RSU_Rx*LOS_model_Ps_RSU_Rx));
               end    
      
            %%%  end RELAY LOS
 
        
        
        end % iteracion=1:1:iteracciones
       
    end % ky=1:1:Density_y
    
end  % kx=1:1:Density_x

figure()

PDR_VehY_Verylow=(PDR(:,1));
PDR_VehY_low=(PDR(:,2));
PDR_VehY_Medium=(PDR(:,3));
PDR_VehY_High=(PDR(:,end));


NC_PDR_VehY_Verylow=(NC_PDR(:,1));
NC_PDR_VehY_low=(NC_PDR(:,2));
NC_PDR_VehY_Medium=(NC_PDR(:,3));
NC_PDR_VehY_High=(NC_PDR(:,end));

ZonesNC_PDR_VehY_Verylow=(ZonesNC_PDR(:,1));
ZonesNC_PDR_VehY_low=(ZonesNC_PDR(:,2));
ZonesNC_PDR_VehY_Medium=(ZonesNC_PDR(:,3));
ZonesNC_PDR_VehY_High=(ZonesNC_PDR(:,end));

RS_PDR_VehY_Verylow=(RS_PDR(:,1));
RS_PDR_VehY_low=(RS_PDR(:,2));
RS_PDR_VehY_Medium=(RS_PDR(:,3));
RS_PDR_VehY_High=(RS_PDR(:,end));

LOS_PDR_VehY_Verylow=(LOS_PDR(:,1));
LOS_PDR_VehY_low=(LOS_PDR(:,2));
LOS_PDR_VehY_Medium=(LOS_PDR(:,3));
LOS_PDR_VehY_High=(LOS_PDR(:,end));




y=[mean(RS_PDR_VehY_Verylow) mean(LOS_PDR_VehY_Verylow) mean(PDR_VehY_Verylow) mean(NC_PDR_VehY_Verylow); mean(RS_PDR_VehY_low) mean(LOS_PDR_VehY_low) mean(PDR_VehY_low) mean(NC_PDR_VehY_low); mean(RS_PDR_VehY_Medium) mean(LOS_PDR_VehY_Medium) mean(PDR_VehY_Medium) mean(NC_PDR_VehY_Medium) ; mean(RS_PDR_VehY_High) mean(LOS_PDR_VehY_High)  mean(PDR_VehY_High) mean(NC_PDR_VehY_High)];
err=[std(RS_PDR_VehY_Verylow) std(LOS_PDR_VehY_Verylow) std(PDR_VehY_Verylow) std(NC_PDR_VehY_Verylow); std(RS_PDR_VehY_low) std(LOS_PDR_VehY_low) std(PDR_VehY_low) std(NC_PDR_VehY_low); std(RS_PDR_VehY_Medium) std(LOS_PDR_VehY_Medium) std(PDR_VehY_Medium) std(NC_PDR_VehY_Medium); std(RS_PDR_VehY_High) std(LOS_PDR_VehY_High)  std(PDR_VehY_High) std(NC_PDR_VehY_High)];

% y=[mean(PDR_VehY_Verylow) mean(RS_PDR_VehY_Verylow) mean(LOS_PDR_VehY_Verylow)  mean(NC_PDR_VehY_Verylow); mean(PDR_VehY_low) mean(RS_PDR_VehY_low) mean(LOS_PDR_VehY_low) mean(NC_PDR_VehY_low); mean(PDR_VehY_Medium) mean(RS_PDR_VehY_Medium) mean(LOS_PDR_VehY_Medium) mean(NC_PDR_VehY_Medium) ; mean(PDR_VehY_High) mean(RS_PDR_VehY_High) mean(LOS_PDR_VehY_High) mean(NC_PDR_VehY_High)];
% err=[std(PDR_VehY_Verylow) std(RS_PDR_VehY_Verylow) std(LOS_PDR_VehY_Verylow) std(NC_PDR_VehY_Verylow); std(PDR_VehY_low) std(RS_PDR_VehY_low) std(LOS_PDR_VehY_low) std(NC_PDR_VehY_low); std(PDR_VehY_Medium) std(RS_PDR_VehY_Medium) std(LOS_PDR_VehY_Medium) std(NC_PDR_VehY_Medium); std(PDR_VehY_High) std(RS_PDR_VehY_High) std(LOS_PDR_VehY_High) std(NC_PDR_VehY_High)];


barwitherr(err,y)
%bar(y);
legend('RS','LOS','RCLD_{Px}','NC');
ylabel('Packet Delivery Ratio PDR');
xlabel('Density of Vehicles');
ylim([0 1])
grid on
grid minor
hold on







% % % % y=[mean(PDR_VehY_Verylow) mean(RS_PDR_VehY_Verylow) mean(LOS_PDR_VehY_Verylow)  mean(NC_PDR_VehY_Verylow) mean(ZonesNC_PDR_VehY_Verylow); mean(PDR_VehY_low) mean(RS_PDR_VehY_low) mean(LOS_PDR_VehY_low) mean(NC_PDR_VehY_low) mean(ZonesNC_PDR_VehY_low); mean(PDR_VehY_Medium) mean(RS_PDR_VehY_Medium) mean(LOS_PDR_VehY_Medium) mean(NC_PDR_VehY_Medium) mean(ZonesNC_PDR_VehY_Medium); mean(PDR_VehY_High) mean(RS_PDR_VehY_High) mean(LOS_PDR_VehY_High) mean(NC_PDR_VehY_High) mean(ZonesNC_PDR_VehY_High)];
% % % % err=[std(PDR_VehY_Verylow) std(RS_PDR_VehY_Verylow) std(LOS_PDR_VehY_Verylow) std(NC_PDR_VehY_Verylow) std(ZonesNC_PDR_VehY_Verylow); std(PDR_VehY_low) std(RS_PDR_VehY_low) std(LOS_PDR_VehY_low) std(NC_PDR_VehY_low) std(ZonesNC_PDR_VehY_low); std(PDR_VehY_Medium) std(RS_PDR_VehY_Medium) std(LOS_PDR_VehY_Medium) std(NC_PDR_VehY_Medium) std(ZonesNC_PDR_VehY_Medium); std(PDR_VehY_High) std(RS_PDR_VehY_High) std(LOS_PDR_VehY_High) std(NC_PDR_VehY_High) std(ZonesNC_PDR_VehY_High)];
% % % % %barwitherr(err,y)
% % % % c = categorical({'apples','pears','oranges','oranges'});
% % % % bar(y);
% % % % legend('RCLD_{Px}','RS','LOS','NC','RCLD_{Px} with NC');
% % % % ylabel('Packet Delivery Ratio PDR');
% % % % xlabel('Density of Vehicles');
% % % % ylim([0 1])
% % % % grid on
% % % % grid minor
% % % % hold on










% figure()
% RelaySinNC=[1 ChannelLOS(1,1) ChannelNC(1,1) ChannelMP(1,1); 1 ChannelLOS(1,2) ChannelNC(1,2) ChannelMP(1,2);1 ChannelLOS(1,3) ChannelNC(1,3) ChannelMP(1,3); 1 ChannelLOS(1,4) ChannelNC(1,4) ChannelMP(1,4);1 ChannelLOS(1,5) ChannelNC(1,5) ChannelMP(1,5)];
% bar(RelaySinNC);
% legend('Relay Simple','Relay LOS','Relay With NC','Relay by Zones');
% ylabel('Channel Load Normalized');
% xlabel('Density of Vehicles');
% ylim([0 1])
% grid on
% grid minor
% 
% figure()
% RelayConNC=[ChannelNC(1,1) NCChannelLOS(1,1) NCChannelMP(1,1);ChannelNC(1,2) NCChannelLOS(1,2) NCChannelMP(1,2); ChannelNC(1,3) NCChannelLOS(1,3) NCChannelMP(1,3);ChannelNC(1,4) NCChannelLOS(1,4) NCChannelMP(1,4);ChannelNC(1,5) NCChannelLOS(1,5) NCChannelMP(1,5)];
% bar(RelayConNC);
% legend('Relay Simple with NC','Relay LOS with NC','Relay by Zones with NC');
% ylabel('Channel Load Normalized');
% xlabel('Density of Vehicles');
% ylim([0 1])
% grid on
% grid minor
