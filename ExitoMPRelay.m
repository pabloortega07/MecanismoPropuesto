function [CountMPRelay]=ExitoMPRelay(ZonaTx,ZonaRx,Ax,Ay,CountMPRelay)

CountMPRelay= CountMPRelay;

if ZonaTx==1
    CountMPRelay= CountMPRelay;
end

if ZonaTx==2 & sum(Ax(1,5))>0
    CountMPRelay= CountMPRelay+1;
else CountMPRelay= CountMPRelay;
end

if ZonaTx==3 & sum(Ax(1,4:5))>0
    CountMPRelay= CountMPRelay+1;
    else CountMPRelay= CountMPRelay;
end

if ZonaTx==4 & sum(Ax(1,3:5))>0
    CountMPRelay= CountMPRelay+1;
    else CountMPRelay= CountMPRelay;
end

if ZonaTx==5 & sum(Ax(1,2:5))>0
    CountMPRelay= CountMPRelay+1;
    else CountMPRelay= CountMPRelay;
end


end