function [Relay]= control(ZonaTx,Ax) 

Relay=0;

if ZonaTx==5 && sum(Ax(1,2:5))>0 
    Relay=1;
  end

if ZonaTx==4 && sum(Ax(1,3:5))>0
    Relay=1;
 end

if ZonaTx==3 && sum(Ax(1,4:5))>0
    Relay=1;
  end

if ZonaTx==2 && sum(Ax(1,5:5))>0
    Relay=1;
end

end