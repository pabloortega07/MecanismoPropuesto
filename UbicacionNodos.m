function [pos_vehX,pos_vehY] = UbicacionNodos(pos_vehX_xini,pos_vehX_xend,pos_vehY_yini,pos_vehY_yend,width_x,width_y,Veh_x,Veh_y)

pos_vehX_x = randi([-pos_vehX_xend -pos_vehX_xini],1,Veh_x) ;
pos_vehX_y = randi([0 width_x],1,Veh_x);
pos_vehX= [pos_vehX_x pos_vehX_y];
pos_vehX=reshape(pos_vehX,Veh_x,2);


pos_vehY_x = randi([0 width_y],1,Veh_y) ;
pos_vehY_y = randi([-pos_vehY_yend -pos_vehY_yini],1,Veh_y);
pos_vehY= [pos_vehY_x pos_vehY_y];
pos_vehY=reshape(pos_vehY,Veh_y,2);

end