function [CountRelayLOS,Relay]=ExitoRelayLOS(dlvl,CountRelayLOS)

    if dlvl < 18
        Relay=0;
        CountRelayLOS= CountRelayLOS;    
    else
        Relay=1;
        CountRelayLOS= CountRelayLOS+1;
    end
end


