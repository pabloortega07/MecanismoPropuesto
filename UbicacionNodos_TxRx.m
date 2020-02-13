function [pos_vehX_Rx,pos_vehY_Tx] = UbicacionNodos_TxRx(pos_vehX_xini_Rx,pos_vehX_xend_Rx,pos_vehY_yini_Tx,pos_vehY_yend_Tx,width_x,width_y,Veh_x_Rx,Veh_y_Tx)

pos_vehX_x_Rx = randi([-pos_vehX_xend_Rx -pos_vehX_xini_Rx],1,Veh_x_Rx) ;
pos_vehX_y_Rx = randi([0 width_x],1,Veh_x_Rx);
pos_vehX_Rx= [pos_vehX_x_Rx pos_vehX_y_Rx];
pos_vehX_Rx=reshape(pos_vehX_Rx,Veh_x_Rx,2);


pos_vehY_x_Tx = randi([0 width_y],1,Veh_y_Tx) ;
pos_vehY_y_Tx = randi([-pos_vehY_yend_Tx -pos_vehY_yini_Tx],1,Veh_y_Tx);
pos_vehY_Tx= [pos_vehY_x_Tx pos_vehY_y_Tx];
pos_vehY_Tx=reshape(pos_vehY_Tx,Veh_y_Tx,2);

end