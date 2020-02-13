function [NCCountMPRelay]=ExitoNCMPRelay(ZonaTx,ZonaRx,Ax,Ay,NCCountMPRelay)

NCCountMPRelay= NCCountMPRelay;

if ZonaTx==1
    NCCountMPRelay= NCCountMPRelay;
end

if ZonaTx==2 & sum(Ax(1,5))>0
    NCCountMPRelay= NCCountMPRelay+1;
else NCCountMPRelay= NCCountMPRelay;
end

if ZonaTx==3 & sum(Ax(1,4:5))>0
    NCCountMPRelay= NCCountMPRelay+1;
    else NCCountMPRelay= NCCountMPRelay;
end

if ZonaTx==4 & sum(Ax(1,3:5))>0
    NCCountMPRelay= NCCountMPRelay+1;
    else NCCountMPRelay= NCCountMPRelay;
end

if ZonaTx==5 & sum(Ax(1,2:5))>0
    NCCountMPRelay= NCCountMPRelay+1;
    else NCCountMPRelay= NCCountMPRelay;
end


end