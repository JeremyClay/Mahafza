function [SNR] = fluct(pd, nfa, np, sw_case)
% This function calculates the SNR fluctuation loss for Swerling models
% A negative Lf value indicates SNR gain instead of loss 
% Inputs
    % pd        == desired probability of detection
    % nfa       == desired number of false alarms
    % np        == number of pulses
    % sw_case	== 0, 1, 2, 3, or 4 depending on the desired Swerling case
% Output
    % SNR       == Resulting SNR
%
format long
% *************** Swerling 5 case ****************
% check to make sure that np>1
pfa =  np * log(2) / nfa;
if (sw_case == 0)
if (np ==1)
    nfa = 1/pfa;
    b = sqrt(-2.0 * log(pfa));
    Pd_Sw5 = 0.001;
    snr_inc = 0.1 - 0.005;
    while(Pd_Sw5 <= pd)
        snr_inc = snr_inc + 0.005;
        a = sqrt(2.0 * 10^(.1*snr_inc));
        Pd_Sw5 = marcumsq(a,b);
    end
    PD_SW5 = Pd_Sw5;
    SNR = snr_inc;
else
    % np > 1 use MATLAB function pd_swerling5.m
    snr_inc = 0.1 - 0.001;
    Pd_Sw5 = 0.001;
    while(Pd_Sw5 <= pd)
        snr_inc = snr_inc + 0.001;
        Pd_Sw5 = pd_swerling5(pfa, 1, np, snr_inc);
    end
    PD_SW5 = Pd_Sw5;
    SNR = snr_inc;
end
end

% *************** End Swerling 5 case ************
% *************** Swerling 1 case ****************
% compute the false alarm number
if (sw_case == 1)
    Pd_Sw1 = 0.001;
    snr_inc = 0.1 - 0.001;
    while(Pd_Sw1 <= pd)
        snr_inc = snr_inc + 0.001;
        Pd_Sw1 = pd_swerling1(nfa, np, snr_inc);
    end
    PD_SW1 = Pd_Sw1;
    SNR = snr_inc;
end

% *************** End Swerling 1 case ************
% *************** Swerling 2 case ****************
if (sw_case == 2)
    Pd_Sw2 = 0.001;
    snr_inc = 0.1 - 0.001;
    while(Pd_Sw2 <= pd)
        snr_inc = snr_inc + 0.001;
        Pd_Sw2 = pd_swerling2(nfa, np, snr_inc);
    end
    PD_SW2 = Pd_Sw2;
    SNR = snr_inc;
    
end

% *************** End Swerling 2 case ************
% *************** Swerling 3 case ****************
if (sw_case == 3)
    Pd_Sw3 = 0.001;
    snr_inc = 0.1 - 0.001;
    while(Pd_Sw3 <= pd)
        snr_inc = snr_inc + 0.001;
        Pd_Sw3 = pd_swerling3(nfa, np, snr_inc);
    end
    PD_SW3 = Pd_Sw3;
    SNR = snr_inc;
 
end

% *************** End Swerling 3 case ************
% *************** Swerling 4 case ****************
if (sw_case == 4)
    Pd_Sw4 = 0.001;
    snr_inc = 0.1 - 0.001;
    while(Pd_Sw4 <= pd)
        snr_inc = snr_inc + 0.001;
        Pd_Sw4 = pd_swerling4(nfa, np, snr_inc);
    end
    PD_SW4 = Pd_Sw4;
    SNR = snr_inc;
    
end

% *************** End Swerling 4 case ************
return