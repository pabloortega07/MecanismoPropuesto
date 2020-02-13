function [Ps]=Review(ZonaTx,ZonaRx,Ax,Ay,Pa,TwoPa)
Psr=1;Phn=1;Ps=1;ni=0;nh=0; 

% ---------------------------------------------------------------------
        %% ZonaTx=1
%------------------------------------------------------------------------

 if ZonaTx==1       
    Psr=1;Phn=1;Ps=1;Ps_sr=1; Psr_rsux=1; Psr_rsuy=1; nirsux=0; nirsuy=0;
       
        if  ZonaTx==1 & ZonaRx==1
             ni=sum((Ax)) + sum((Ay))+ 1 ;
            for xi=1:1:ni
             Psr=Psr*((1-Pa)^xi);
            end
            Phn=1;
            Ps=Psr*Phn;         
        end
        
        
        if  ZonaTx==1 & ZonaRx==2
             ni=sum((Ax)) + sum((Ay(1,1:4))) + 1 ;  
            for xi=1:1:ni
             Psr=Psr*((1-Pa)^xi);
            end
            Phn=1;    
            Ps=Psr*Phn;
            
        end
        
        if  ZonaTx==1 & ZonaRx==3
             ni=sum((Ax)) + sum((Ay(1,1:3)))+ 1 ;
            for xi=1:1:ni
             Psr=Psr*((1-Pa)^xi);
            end
            Phn=1;
            Ps=Psr*Phn;      
        end
        
        if  ZonaTx==1 & ZonaRx==4
               ni=sum((Ax)) + sum((Ay(1,1:2)))+ 1 ;
            for xi=1:1:ni
             Psr=Psr*((1-Pa)^xi);
            end
            Phn=1;
            Ps=Psr*Phn;
            
        end
        
        if  ZonaTx==1 & ZonaRx==5
            ni=sum((Ax)) + sum((Ay(1,1:1)))+ 1 ;

            for xi=1:1:ni
             Psr=Psr*((1-Pa)^xi);
            end
            Phn=1;
            Ps=Psr*Phn;
        end

 end
 
% ---------------------------------------------------------------------
        %% ZonaTx=2
%------------------------------------------------------------------------

 if ZonaTx==2  
     Psr=1;Phn=1;Ps=1;
        
        if  ZonaTx==2 & ZonaRx==1
            ni=  sum(Ax(1,1:4)) + sum(Ay(1,1:5)) + 1 ; 
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,5:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end
          Ps=Psr*Phn;
        end
        
        
        if  ZonaTx==2 & ZonaRx==2
            ni= sum(Ax(1,1:4)) + sum(Ay(1,1:4))+ 1 ;
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,5:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end
            Ps=Psr*Phn;
          end
        
        if  ZonaTx==2 & ZonaRx==3
           ni= sum(Ax(1,1:4)) + sum(Ay(1,1:3))+ 1 ; 
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,5:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end 
            Ps=Psr*Phn;
        end
        
        
        if  ZonaTx==2 & ZonaRx==4
           ni= sum(Ax(1,1:4)) + sum(Ay(1,1:2))+ 1 ; 
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,5:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end 
             Ps=Psr*Phn;
        end
        
      if  ZonaTx==2 & ZonaRx==5
        Psr=0;
        Phn=0;
        Ps=Psr*Phn;
      end
        
        
 end
 
 
% ---------------------------------------------------------------------
        %% ZonaTx=3
%------------------------------------------------------------------------
 
if ZonaTx==3
     Psr=1;Phn=1;Ps=1;
            
         if  ZonaTx==3 & ZonaRx==1
             ni= sum(Ax(1,1:4)) + sum(Ay)+ 1 ;
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,5:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end
            Ps=Psr*Phn;
         end
        
        if  ZonaTx==3 & ZonaRx==2
            ni= sum(Ax(1,1:4)) + sum(Ay(1,1:4))+ 1 ;
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,5:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end
        Ps=Psr*Phn;
        Ps_rsux=0; Ps_rsuy=0;
        end   
        
        
        if  ZonaTx==3 & ZonaRx==3
            ni= sum(Ax(1,1:4)) + sum(Ay(1,1:3))+ 1 ;
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,5:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end
            Ps=Psr*Phn;
        end
         
        if  ZonaTx==3 & ZonaRx==4
        
            Psr=0; Phn=0;
            Ps=Psr*Phn;
        end
         
        if  ZonaTx==3 & ZonaRx==5
            Psr=0; Phn=0;
            Ps=Psr*Phn;
         end
        
 end   
 
 
 % ---------------------------------------------------------------------
        %% ZonaTx=4
%------------------------------------------------------------------------
if ZonaTx==4 
    Psr=1;Phn=1;Ps=1;

    if  ZonaTx==4 & ZonaRx==1
           ni= sum(Ay) + sum(Ax(1,1:3))+ 1 ;
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,4:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end
            Ps=Psr*Phn;
        end
        
        if  ZonaTx==4 & ZonaRx==2
            ni= sum(Ay(1,1:4)) + sum(Ax(1,1:3))+ 1 ;
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,4:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end
            Ps=Psr*Phn;
        end        
        
        if  ZonaTx==4 & ZonaRx==3 
            Psr=0;Phn=0;
            Ps=Psr*Phn;
        end
        
        
         if  ZonaTx==4 & ZonaRx==4
            Psr=0;Phn=0;
            Ps=Psr*Phn;
         end
         
         if  ZonaTx==4 & ZonaRx==5
             Psr=0;Phn=0;
             Ps=Psr*Phn;
         end
         
        
end


if ZonaTx==5 
    
    Psr=1;Phn=1;Ps=1;
          if  ZonaTx==5 & ZonaRx==1
           ni= sum(Ay) + sum(Ax(1,1:1))+ 1 ;
                for xi=1:1:ni
                 Psr=Psr*((1-Pa)^xi);
                end
            nh=sum(Ax(1,2:5));
                for xii=1:1:nh
                 Phn=Phn*((1-TwoPa)^xii);
                end
            Ps=Psr*Phn;
            
          end
    
        if  ZonaTx==5 & ZonaRx==2
            Psr=0;Phn=0;
            Ps=Psr*Phn;
        end
        
        if  ZonaTx==5 & ZonaRx==3
            Psr=0;Phn=0;
            Ps=Psr*Phn;
        end
        

        if  ZonaTx==5 & ZonaRx==4
            Psr=0;Phn=0;
            Ps=Psr*Phn;
        end
            
        if  ZonaTx==5 & ZonaRx==5
            Psr=0;Phn=0;
            Ps=Psr*Phn;
       end
             
    
    
    
end    



  
end