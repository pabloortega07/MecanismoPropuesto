function [NCCountRelayLOS]=ExitoNCRelayLOS(dlvl,NCCountRelayLOS)

    if dlvl < 7
        NCCountRelayLOS= NCCountRelayLOS;    
    else
        NCCountRelayLOS= NCCountRelayLOS+1;
    end
end