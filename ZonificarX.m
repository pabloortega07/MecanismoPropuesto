function [ZonaA]= ZonificarX(dist_veh,pos_x)
              if dist_veh >=170 || pos_x>0
              ZonaA=7;
              else if dist_veh >=60 & dist_veh<170
              ZonaA=5;
                 else if dist_veh>=40 & dist_veh<60
                    ZonaA=4;
                    else if dist_veh>=20 & dist_veh<40
                    ZonaA=3;
                        else if dist_veh>=10 & dist_veh<20
                         ZonaA=2;
                            else 
                            ZonaA=1;
                end
               end
              end
             end
            end
            
end