clear all
clc
close all
load VariablesGlobales
load ProbNLOS
Veh_y=[28 28 28 28];
Veh_x=1;
Density_x=length(Veh_x);
Density_y=length(Veh_y);



CountSimpleRelay=zeros(1,Density_y);
CountRelayLOS=zeros(1,Density_y);
NCCountRelayLOS=zeros(1,Density_y);
CountNC=zeros(1,Density_y);
CountMP=zeros(1,Density_y);
NCCountMP=zeros(1,Density_y);
%%
for positionVRx=1:1:5
    
CountSimpleRelay=zeros(positionVRx,Density_y);
CountRelayLOS=zeros(positionVRx,Density_y);
NCCountRelayLOS=zeros(positionVRx,Density_y);
CountNC=zeros(positionVRx,Density_y);
CountMP=zeros(positionVRx,Density_y);
NCCountMP=zeros(positionVRx,Density_y);
    
    if positionVRx==1
            pos_vehX_xini= 1;   % Rango donde se crean los vehiculos 
            pos_vehX_xend= 9;  % Rango donde se crean los vehiculos
    end
    
    if positionVRx==2
            pos_vehX_xini= 11;   % Rango donde se crean los vehiculos 
            pos_vehX_xend= 19;  % Rango donde se crean los vehiculos 
    end
   
    if positionVRx==3
            pos_vehX_xini= 21;   % Rango donde se crean los vehiculos 
            pos_vehX_xend= 39;  % Rango donde se crean los vehiculos 
    end

   if positionVRx==4
            pos_vehX_xini= 41;   % Rango donde se crean los vehiculos 
            pos_vehX_xend= 59;  % Rango donde se crean los vehiculos 
   end
   
   if  positionVRx==5
            pos_vehX_xini= 61;   % Rango donde se crean los vehiculos 
            pos_vehX_xend= 159;  % Rango donde se crean los vehiculos 
   end


for kx=1:1:Density_x
    VehiculosRx=Veh_x(1,kx);
%%    
    for ky=1:1:Density_y
        VehiculosTx=Veh_y(1,ky);
    
        CountSimpleRelay=0;
        CountRelayLOS=0;
        NCCountRelayLOS=0;
        CountNCRelay=0;
        CountMPRelay=0;
        NCCountMPRelay=0;
        
        CbasicSR(ky)=(((VehiculosTx)*(1/Ib))*S)*iteracciones;
        
%%   
   
        for iteracion=1:1:iteracciones
            
                [pos_vehX,pos_vehY]=UbicacionNodos(pos_vehX_xini,pos_vehX_xend,pos_vehY_yini,pos_vehY_yend,width_x,width_y,VehiculosRx,VehiculosTx);   
    
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
             
             %% RELAY SIMPLE
             for RSy=1:1:VehiculosTx
                    ZonaTx=zona_vehY(RSy,2);
              for RSx=1:1:VehiculosRx
                    ZonaRx=zona_vehX(RSx,2);
                    
                   [CountSimpleRelay]=ExitoSimpleRelay(ZonaTx,ZonaRx,Ax,Ay,CountSimpleRelay);
                   
                   dist_Rx=round(zona_vehX(RSx,2));
                   if dist_Rx==0
                       dist_Rx=1;
                   end
                   dist_Tx=round(zona_vehY(RSy,2));
                   if dist_Tx==0
                       dist_Tx=1;
                   end

                   CountSR(ky)=CountSimpleRelay;
                   ChannelSR(positionVRx,ky)=(((CountSR(ky)*(1/Ib))*S)*2);
                   

              end
             end
             
             %%% end RELAY SIMPLE     
             
             %% RELAY LOS
             
               for RLosy=1:1:VehiculosTx
                    for RLosx=1:1:VehiculosRx  
                        ZonaTx=zona_vehY(RLosy,2);

                    xa=[5 5]; % RSU
                    xs=[pos_vehY(RLosy,1) pos_vehY(RLosy,2)]; % Transmisor
                    xf=[pos_vehX(RLosx,1) pos_vehX(RLosx,2)]; % Receptor
                
                    lvl=(xa-xs)-((((xa-xs).*(xf-xs))/((xf-xs).^2))).*(xf-xs);
                    [dlvl]=distancia(lvl(1,1),lvl(1,2),xa(1,1),xa(1,2)); 



                       [CountRelayLOS]=ExitoRelayLOS(dlvl,CountRelayLOS);

                       dist_Rx=round(zona_vehY(RLosy,2));
                       if dist_Rx==0
                           dist_Rx=1;
                       end
                       dist_Tx=round(zona_vehY(RLosx,2));
                       if dist_Tx==0
                           dist_Tx=1;
                       end

                       CountLOS(ky)=CountRelayLOS;
                       ChannelLOS(positionVRx,ky)=(((CountLOS(ky)*(1/Ib))*S) + CbasicSR(ky))/ChannelSR(ky);
                    end
              end
            
              %%% end RELAY LOS
             
              
                           %% RELAY LOS with NC
             
               for NCRLosy=1:2:VehiculosTx-1
                    DisTx1=abs(pos_vehY(NCRLosy,2));
                    DisTx2=abs(pos_vehY(NCRLosy+1,2));               
                   
                    if DisTx1 > DisTx2
                       xs=[pos_vehY(NCRLosy,1) pos_vehY(NCRLosy,2)]; % Transmisor
                    end
                    if DisTx2 > DisTx1    
                       xs=[pos_vehY(NCRLosy+1,1) pos_vehY(NCRLosy+1,2)]; % Transmisor
                    end
                    if DisTx2 == DisTx1    
                       xs=[pos_vehY(NCRLosy+1,1) pos_vehY(NCRLosy+1,2)]; % Transmisor
                    end
                    
                        
                    for NCRLosx=1:1:VehiculosRx  
                        ZonaTx=zona_vehY(NCRLosy,2);

                    xa=[5 5]; % RSU
                            %xs=[pos_vehY(NCRLosy,1) pos_vehY(NCRLosy,2)]; % Transmisor
                    xf=[pos_vehX(NCRLosx,1) pos_vehX(NCRLosx,2)]; % Receptor
                
                    lvl=(xa-xs)-((((xa-xs).*(xf-xs))/((xf-xs).^2))).*(xf-xs);
                    [dlvl]=distancia(lvl(1,1),lvl(1,2),xa(1,1),xa(1,2)); 

                       [NCCountRelayLOS]=ExitoRelayLOS(dlvl,NCCountRelayLOS);

                       dist_Rx=round(zona_vehY(NCRLosy,2));
                       if dist_Rx==0
                           dist_Rx=1;
                       end
                       dist_Tx=round(zona_vehY(NCRLosx,2));
                       if dist_Tx==0
                           dist_Tx=1;
                       end

                       NCCountLOS(ky)=NCCountRelayLOS;
                       NCChannelLOS(positionVRx,ky)=(((NCCountLOS(ky)*(1/Ib))*S) + CbasicSR(ky))/(ChannelSR(ky)*0.75);
                    end
              end
            
              %%% end RELAY LOS with NC
             
             
             %% RELAY NETWORKCODING
             
              for NCy=1:2:VehiculosTx-1
                    ZonaTx1=zona_vehY(NCy,2);
                    ZonaTx2=zona_vehY(NCy+1,2);
                                     
                   [CountNCRelay]=ExitoNCRelay(CountNCRelay);
                   
                   CountNC(ky)=CountNCRelay;
                   ChannelNC(positionVRx,ky)=(((CountNC(ky)*(1/Ib))*S) + CbasicSR(ky)) /ChannelSR(ky)  ;
                   ChannelNC2(positionVRx,ky)=(((CountNC(ky)*(1/Ib))*S) + CbasicSR(ky)); 
              end
             
             %%% end RELAY NETWORKCODING
         
            %% RELAY ZONES
                                
            for MPx=1:1:VehiculosRx
                    ZonaRx=zona_vehX(MPx,2);   
            for MPy=1:1:VehiculosTx
                    ZonaTx=zona_vehY(MPy,2);
                                
                   [CountMPRelay]=ExitoMPRelay(ZonaTx,ZonaRx,Ax,Ay,CountMPRelay);
                   
                   dist_Rx=round(zona_vehX(MPx,2));
                   if dist_Rx==0
                       dist_Rx=1;
                   end
                   dist_Tx=round(zona_vehY(MPy,2));
                   if dist_Tx==0
                       dist_Tx=1;
                   end

                   CountMP(ky)=CountMPRelay;
                   ChannelMP(positionVRx,ky)=(((CountMP(ky)*(1/Ib))*S)+ CbasicSR(ky))/ChannelSR(ky) ;

              end
            end

             
            %% RELAY ZONES with NC                                          
                    
         for NCMPy=1:2:VehiculosTx-1
                    ZonaTx1=zona_vehY(NCMPy,2);           
                    ZonaTx2=zona_vehY(NCMPy+1,2);                 
         
          if ZonaTx1 > ZonaTx2
            ZonaTx=ZonaTx1; % Transmisor
          end
         if ZonaTx2 > ZonaTx1    
           ZonaTx=ZonaTx2; % Transmisor
         end
         if ZonaTx2 == ZonaTx1    
           ZonaTx=ZonaTx1; % Transmisor
         end
         
         
                   for NCMPx=1:1:VehiculosRx
                    ZonaRx=zona_vehX(NCMPx,2);
                                 
                   [NCCountMPRelay]=ExitoNCMPRelay(ZonaTx,ZonaRx,Ax,Ay,NCCountMPRelay);
                   
                   dist_Rx=round(zona_vehX(NCMPx,2));
                   if dist_Rx==0
                       dist_Rx=1;
                   end
                   dist_Tx=round(zona_vehY(MPy,2));
                   if dist_Tx==0
                       dist_Tx=1;
                   end

                   NCCountMP(ky)=NCCountMPRelay;
                   NCChannelMP(positionVRx,ky)=(((NCCountMP(ky)*(1/Ib))*S)+ CbasicSR(ky))/(ChannelSR(ky)*0.75) ;

                 end
        end
            
            
            %%% end RELAY ZONES  with NC
             
             
             
       end % iteracion=1:1:iteracciones
              
       
       
    end % ky=1:1:Density_y
    
    
end  % kx=1:1:Density_x

end

figure()
%%%%%%RelaySinNC=[ChannelLOS(1,1) ChannelNC(1,1) ChannelMP(1,1);ChannelLOS(2,1) ChannelNC(2,1) ChannelMP(2,1);ChannelLOS(3,1) ChannelNC(3,1) ChannelMP(3,1);ChannelLOS(4,1) ChannelNC(4,1) ChannelMP(4,1);ChannelLOS(5,1) ChannelNC(5,1) ChannelMP(5,1);];
RelaySinNC=[1 ChannelLOS(1,1) ChannelMP(1,1);1 ChannelLOS(2,1) ChannelMP(2,1);1 ChannelLOS(3,1) ChannelMP(3,1);1 ChannelLOS(4,1) ChannelMP(4,1);1 ChannelLOS(5,1) ChannelMP(5,1)];
bar(RelaySinNC);
%%%%%%legend('Relay LOS','Relay NC','Relay BPZ');
legend('RS','LOS','RCLD_{Px}');
ylabel('Channel Load Normalized');
xlabel('Reception Zones');
ylim([0 1])
grid on
grid minor

figure()
RelayConNC=[1 NCChannelLOS(1,1) NCChannelMP(1,1);1 NCChannelLOS(2,1) NCChannelMP(2,1);1 NCChannelLOS(3,1) NCChannelMP(3,1);1 NCChannelLOS(4,1) NCChannelMP(4,1);1 NCChannelLOS(5,1) NCChannelMP(5,1)];
bar(RelayConNC);
legend('RS','LOS','RCLD_{Px}');
ylabel('Channel Load Normalized');
xlabel('Reception Zones');
ylim([0 1])
grid on
grid minor
