clear all;
clc

iteracciones=500;  
    % ------------------- Variables globales -----------------------------
            Ts=40e-6; %time to transmit the Preamble + Physical Layer
            S=200; %size of a beacon message in byte
                S=S*8; %size of a beacon message in bits
            Drate=6e6; % Data rate
            Ib=0.1; % Intervalo de beacons [s]
            Tslot=S/Drate; % Demora de transmisión
            Dtx=Ts+Tslot ; % Delay in the transmission of a message
            nslot=round(Ib/Dtx);
            Pa=1/nslot;
            TwoPa=2*Pa;
   %---------------------------------------------------------------------
    
   % ----------------------- Autos ---------------------------------------
            length_x=160;  % Intervalo de la carretera HORIZONTAL de la intersección
            length_y=160;  % Intervalo de la carretera VERTICAL de la intersección
            length_x_street=0.16; % Largo de la carretera HORIZONTAL [m]
            length_y_street=0.16; % Largo de la carretera HORIZONTAL [m]
            width_carril= 3; % Ancho de carril [m]
            carriles_x= 6; % Numero de carriles HORIZONTAL 
            carriles_y= 6; % Numero de carriles VERTICAL
            width_x=width_carril*carriles_x;  % Ancho carretera HORIZONTAL de la intersección
            width_y=width_carril*carriles_y;  % Ancho carretera VERTICAL de la intersección

            pos_vehX_xini= 1;   % Rango donde se crean los vehiculos 
            pos_vehX_xend= 159;  % Rango donde se crean los vehiculos
            
                    
            pos_vehY_yini= 1;   % Rango donde se crean los vehiculos
            pos_vehY_yend= 159;  % Rango donde se crean los vehiculos
            
            
            pos_vehX_xini_Rx= 1;   % Rango donde se crean los vehiculos Rx a evaluar puntualmente 
            pos_vehX_xend_Rx= 9;  % Rango donde se crean los vehiculos Rx a evaluar puntualmente
            
            pos_vehY_yini_Tx=61;   % Rango donde se crean los vehiculos Tx a evaluar puntualmente 
            pos_vehY_yend_Tx=159; % Rango donde se crean los vehiculos Tx a evaluar puntualmente 
            
    % Variables de Inicialización        
   
            PosRSU_x=5;
            PosRSU_y=5;
            
            
            
      %-------------- Densidades Vehiculares -------------------------------- 
     
            %Density=4;
            %%%VeryLow=4; Low=10; Medium=30; High=35; VeryHigh=60; 
            VeryLow=4; Low=10; Medium=30; High=50; VeryHigh=80;
                         % Vehiculos: Density*(km)*carriles
           % Cantidad de Vehiculos HORIZONTAL de la intersección
                   Veh_x(1,1)=round(VeryLow*(length_x_street)*carriles_x);
                   Veh_x(1,2)=round(Low*(length_x_street)*carriles_x);
                   Veh_x(1,3)=round(Medium*(length_x_street)*carriles_x);
                   Veh_x(1,4)=round(High*(length_x_street)*carriles_x);
                       

          % Cantidad de Vehiculos VERTICAL de la intersección
                   Veh_y(1,1)=round(VeryLow*(length_y_street)*carriles_y);
                   Veh_y(1,2)=round(Low*(length_y_street)*carriles_y);
                   Veh_y(1,3)=round(Medium*(length_y_street)*carriles_y);% -14;
                   Veh_y(1,4)=round(High*(length_y_street)*carriles_y); %-20;
                  
                   
save('VariablesGlobales.mat')                      
