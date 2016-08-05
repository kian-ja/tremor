function output = AfferentedMuscleModel(muscle_parameter,delay_parameter,gain_parameter,targetTrajectory,additionalInput)

%% muscle architectural parameters
alpha = muscle_parameter.pennationAngle;
mass = muscle_parameter.mass;
L0 = muscle_parameter.optimalLength;
L_tendon = muscle_parameter.tendonLength;
L0T = L_tendon*1.04;
Lm_initial = muscle_parameter.muscleInitialLength;
Lt_initial = muscle_parameter.tendonInitialLength;
Lmt = Lm_initial*cos(alpha)+Lt_initial;

% calculate initial length based on balance between stiffness of muscle and
% tendon 
cT = 27.8;
kT = 0.0047;
LrT = 0.964;
Normalized_SE_Length = kT*log(exp(Fpe1(1)/cT/kT)+1)+LrT;
SE_Length = Lt_initial * Normalized_SE_Length;
FasclMax = (Lmt - SE_Length)/L0;
Lmax = FasclMax/cos(alpha);

c1 = 23;
k1 = 0.046;
Lr1 = 1.17;

InitialLength = (Lmt-(-L0T*(kT/k1*Lr1-LrT-kT*log(c1/cT*k1/kT))))/(100*(1+kT/k1*L0T/Lmax*1/L0)*cos(alpha));
Lce = InitialLength/(L0/100);
Lse = (Lmt - InitialLength*100)/L0T;

% calculate maximal force output of the muscle based on PCSA
density = 1.06; %g/cm^3
PCSA = (mass*1000)/density/L0; %physiological cross-sectional area
Specific_Tension = 31.4;
F0 = PCSA * Specific_Tension;
Fmax = F0;

% viscosity of muscle (ref: Elias et al. 2014)
Bm = 0.005; %0.001

% assign delays
delay_efferent = delay_parameter.efferent;
delay_Ia = delay_parameter.Ia;
delay_II = delay_parameter.II;
delay_Ib = delay_parameter.Ib;
delay_cortical = delay_parameter.cortical;

% parameter initialization
Vce = 0;
Ace = 0;
MuscleAcceleration = 0;
MuscleVelocity = 0;
MuscleLength = Lce*L0/100;
ForceSE = 0;

Fs = 10000;
Fs_Feedback = 1000;
t = 0:1/Fs:(length(targetTrajectory)-1)/Fs;

% filter parameters for noise
[b100,a100] = butter(4,100/(Fs/2),'low');


%% Activation dynamics parameters
Y_dot = 0;
Y = 0;
Saf_dot = 0;
Saf = 0;
fint_dot = 0;
fint = 0;
feff_dot = 0;
feff = 0;

Af = 0;
Ueff = 0;

%% Feedback system parameters
%% Spindle Model
p = 2;
R = 0.46; %length dependency of the force-velocity relationship
a = 0.3;
K_SR = 10.4649;
K_PR = 0.15;
M = 0.0002; % intrafusal fiber mass

LN_SR = 0.0423;
LN_PR = 0.89;

L0_SR = 0.04; %in units of L0
L0_PR = 0.76; %polar region rest length

L_secondary = 0.04;
X = 0.7;


f_dynamic = 0;
f_static = 0;
T_ddot_bag1 = 0;
T_dot_bag1 = 0;
T_bag1 = 0;
T_ddot_bag2 = 0;
T_dot_bag2 = 0;
T_bag2 = 0;
T_ddot_chain = 0;
T_dot_chain = 0;
T_chain = 0;

%% GTO model
G1 = 60;
G2 = 4;

s = tf('s');
H = (1.7*s^2+2.58*s+0.4)/(s^2+2.2*s+0.4);
Hd = c2d(H,1/Fs_Feedback);
[num,den] = tfdata(Hd);
num = cell2mat(num);
den = cell2mat(den);


%% Transcortical loop
C3 = 0.01;

%% Gains
gamma_dynamic = gain_parameter.gammaDynamic; 
gamma_static = gain_parameter.gammaStatic;

spindleGain_Ia = gain_parameter.Ia;
spindleGain_II = gain_parameter.II;
GTOGain_Ib = gain_parameter.Ib;

% Convert delays in ms to samples
delay_Ia_step = delay_Ia*Fs/Fs_Feedback;   %Ia + II 30
delay_II_step = delay_II*Fs/Fs_Feedback;
delay_Ib_step = delay_Ib*Fs/Fs_Feedback;   %Ib 40
delay_c = delay_cortical*Fs/Fs_Feedback;   %cortical 50

u_a_Ib_temp = 0;
OutputForceTendon = 0;
u_a_FB = 0;
count = 1;

% Convert force trajectory to unit of newton
Ftarget = targetTrajectory*Fmax;
%%

for i = 1:length(t)
    %%
    if i == count
        
        % Get spindle primary and secondary afferent activity 
        [Output_primary,Output_secondary] = Spindle(Lce,Vce,Ace);
        u_a_Ia(i) = Output_primary;
        u_a_II(i) = Output_secondary;
        
        % Get Ib activity 
        x(i) = G1*log((ForceSE/G2+1));
        if i > 1*Fs
            u_a_Ib_temp(i) = (num(3)*x(i-2*Fs/Fs_Feedback) + num(2)*x(i-Fs/Fs_Feedback) + num(1)*x(i) ...
                - den(3)*u_a_Ib_temp(i-2*Fs/Fs_Feedback) - den(2)*u_a_Ib_temp(i-Fs/Fs_Feedback))/den(1);
        else
            u_a_Ib_temp(i) = 0;
        end
        
        u_a_Ib(i) = u_a_Ib_temp(i);
        u_a_Ib(u_a_Ib<0) = 0;
        
        
        if i > delay_Ia_step && i <= delay_Ib_step
            %u_a_FF = Ftarget(i)/Fmax; % feedforward input
            u_a_Ia(i) = Output_primary;
            u_a_II(i) = Output_secondary;
            u_a(i) = u_a_Ia(i-delay_Ia_step)/spindleGain_Ia ...
                +u_a_FF; %input to the muscle
            
        elseif i > delay_Ib_step && i <= delay_c
            u_a_FF = Ftarget(i)/Fmax; % feedforward input
            u_a_Ia(i) = Output_primary;
            u_a_II(i) = Output_secondary; %feedback through spindle %FDI = 0.85
            u_a(i) = u_a_Ia(i-delay_Ia_step)/spindleGain_Ia ...
                -u_a_Ib(i-delay_Ib_step)/GTOGain_Ib ...
                +u_a_FF; %input to the muscle
            
        elseif i > delay_Ib_step && i <= delay_II_step
            u_a_FF = Ftarget(i)/Fmax; % feedforward input
            u_a_Ia(i) = Output_primary;
            u_a_II(i) = Output_secondary; %feedback through spindle %FDI = 0.85
            u_a(i) = u_a_Ia(i-delay_Ia_step)/spindleGain_Ia ...
                +u_a_II(i-delay_II_step)/spindleGain_II ...
                -u_a_Ib(i-delay_Ib_step)/GTOGain_Ib ...
                +u_a_FF; %input to the muscle
            
            
        elseif i > delay_c
            %u_a_FF = Ftarget(i)/Fmax; % feedforward input
            u_a_FB = C3*(Ftarget(i)-OutputForceTendon(i-delay_c))/Fmax + u_a_FB;  % feedback input through cortical pathway
            u_a_Ia(i) = Output_primary;
            u_a_II(i) = Output_secondary; %feedback through spindle %FDI = 0.85
            u_a(i) = u_a_Ia(i-delay_Ia_step)/spindleGain_Ia ...
                +u_a_II(i-delay_II_step)/spindleGain_II ...
                -u_a_Ib(i-delay_Ib_step)/GTOGain_Ib ...
                +u_a_FB; %input to the muscle
            
        else
            u_a_FF = Ftarget(i)/Fmax;
            u_a(i) = u_a_FF;
            
        end
        count = Fs/Fs_Feedback+count;
    else
        u_a_Ia(i) = u_a_Ia(i-1);
        u_a_II(i) = u_a_II(i-1);
        u_a_Ib(i) = u_a_Ib(i-1);
        u_a_Ib_temp(i) = u_a_Ib_temp(i-1);
        u_a(i) = u_a(i-1);
        
    end
    %% Feedforward only
    %u_a(i) = input(i); %Ftarget(i)/Fmax;
    %%
    %% noise + additional input
    if u_a(i) < 0
        u_a(i) = 0;
    elseif u_a(i) > 1
        u_a(i) = 1;
    end
    
    u_a_cortical(i) = additionalInput(i);
    
    if i > 5
        noise(i) = 2*(rand(1)-0.5)*(sqrt(0.01*u_a(i))*sqrt(3));
        noise_filt(i) = (b100(5)*noise(i-4) + b100(4)*noise(i-3) + b100(3)*noise(i-2) + b100(2)*noise(i-1) + b100(1)*noise(i) ...
            - a100(5)*noise_filt(i-4) - a100(4)*noise_filt(i-3) - a100(3)*noise_filt(i-2) - a100(2)*noise_filt(i-1))/a100(1);
    else
        noise(i) =0;
        noise_filt(i) = noise(i);
    end
    
    u_a_temp(i) = u_a(i);
    
    u_a(i) = u_a(i) + noise_filt(i) + u_a_cortical(i);
    if u_a(i) < 0
        u_a(i) = 0;
    elseif u_a(i) > 1
        u_a(i) = 1;
    end
   
    % add delay along efferent pathway
    if i > delay_efferent*Fs/Fs_Feedback
        u_a_long(i) = u_a(i-delay_efferent*Fs/Fs_Feedback);
    else
        u_a_long(i) = 0;
    end
    
    % add activation filter 
    if u_a_long(i) >= Ueff
        TU = 0.03;
    elseif u_a_long(i) < Ueff
        TU = 0.15;
    end
    
    Ueff_dot = (u_a_long(i) - Ueff)/TU;
    Ueff = Ueff_dot*1/Fs + Ueff; % effective neural drive
    
    Af = ActivationFrequency_slow(Ueff,Lce,Vce); % not used 
    
    % force-velocity relationship
    if Vce <= 0
        ForceVelocity = FVcon(Lce,Vce);
    elseif Vce > 0
        ForceVelocity = FVecc(Lce,Vce);
    end
    
    % force-length relationship
    ForceLength = FL(Lce);
    ForceCE = ForceLength*ForceVelocity;
    % viscous property 
    ForceViscocity = Bm * Vce;
    % passive element 1
    ForcePassive1 = Fpe1(Lce/Lmax);
    % passive element 2
    ForcePassive2 = Fpe2(Lce);
    if ForcePassive2 > 0
        ForcePassive2 = 0;
    end
    
    % total force from contractile element
    ForceTotal = (Ueff*(ForceCE + ForcePassive2) + ForcePassive1 + ForceViscocity)*F0;
    if ForceTotal < 0.0
        ForceTotal = 0.0;
    end
    
    % force from series elastic element
    ForceSE = Fse(Lse) * F0;
    
    % calculate muscle excursion acceleration based on the difference
    % between muscle force and tendon force
    MuscleAcceleration(i+1) = (ForceSE*cos(alpha) - ForceTotal*(cos(alpha)).^2)/(mass) ...
        + (MuscleVelocity(i)).^2*tan(alpha).^2/(MuscleLength(i));
    % integrate acceleration to get velocity 
    MuscleVelocity(i+1) = (MuscleAcceleration(i+1)+ ...
        MuscleAcceleration(i))/2*1/Fs+MuscleVelocity(i);
    % integrate velocity to get length 
    MuscleLength(i+1) = (MuscleVelocity(i+1)+ ...
        MuscleVelocity(i))/2*1/Fs+MuscleLength(i);
    
    % normalize each variable to optimal muscle length or tendon legnth
    Ace = MuscleAcceleration(i+1)/(L0/100);
    Vce = MuscleVelocity(i+1)/(L0/100);
    Lce = MuscleLength(i+1)/(L0/100);
    Lse = (Lmt - Lce*L0*cos(alpha))/L0T;
    
    % store data
    OutputForceMuscle(i) = ForceTotal;
    OutputForceTendon(i) = ForceSE;
    OutputForceLength(i) = ForceLength;
    OutputForceVelocity(i) = ForceVelocity;
    OutputForcePassive1(i) = ForcePassive1;
    OutputForcePassive2(i) = ForcePassive2;
    OutputLse(i) = Lse;
    OutputLce(i) = Lce;
    OutputVce(i) = Vce;
    OutputAce(i) = Ace;
    OutputAf(i) = Af;
    OutputUeff(i) = Ueff;
    
    %L0 = L0_initial*(0.15*(1-act)+1);
    
end

figure()
plot(t,OutputForceTendon)
hold on
plot(t,Ftarget,'r')
legend('Output Force','Target Force')
xlabel('Time(sec)','Fontsize',14)
ylabel('Force(N)','Fontsize',14)

% save data as output in structure format
output.Force = OutputForceMuscle;
output.ForceTendon = OutputForceTendon;
output.FL = OutputForceLength;
output.FV = OutputForceVelocity;
output.Fpe1 = OutputForcePassive1;
output.Fpe2 = OutputForcePassive2;
output.Target = Ftarget;
output.Lce = OutputLce;
output.Vce = OutputVce;
output.Ace = OutputAce;
output.Lse = OutputLse;
output.Af = OutputAf;
output.u_a = u_a;
output.u_a_temp = u_a_temp;
output.noise = noise;
output.noise_filt = noise_filt;
output.u_a_cortical = u_a_cortical;
output.U = OutputUeff;
output.Ia = u_a_Ia;
output.II = u_a_II;
output.Ib = u_a_Ib;

% below are functions used in the model
    function [OutputPrimary,OutputSecondary] = Spindle(L,L_dot,L_ddot)
        S = 0.156;
        AP_bag1 = bag1_model(L,L_dot,L_ddot);
        [AP_primary_bag2,AP_secondary_bag2] = bag2_model(L,L_dot,L_ddot);
        [AP_primary_chain,AP_secondary_chain] = chain_model(L,L_dot,L_ddot);
        
        if AP_bag1 < 0
            AP_bag1 = 0;
        end
        
        if AP_primary_bag2 < 0
            AP_primary_bag2 = 0;
        end
        
        if AP_primary_chain < 0
            AP_primary_chain = 0;
        end
        
        
        if AP_secondary_bag2 < 0
            AP_secondary_bag2 = 0;
        end
        
        if AP_secondary_chain < 0
            AP_secondary_chain = 0;
        end
        
        
        if AP_bag1 > (AP_primary_bag2+AP_primary_chain)
            Larger = AP_bag1;
            Smaller = AP_primary_bag2+AP_primary_chain;
        else
            Larger = AP_primary_bag2+AP_primary_chain;
            Smaller = AP_bag1;
        end
        OutputPrimary = Larger + S * Smaller;
        OutputSecondary = AP_secondary_bag2 + AP_secondary_chain;
        
        if OutputPrimary < 0
            OutputPrimary = 0;
        elseif OutputPrimary > 100000
            OutputPrimary = 100000;
        end
        if OutputSecondary < 0
            OutputSecondary = 0;
        elseif OutputSecondary > 100000
            OutputSecondary = 100000;
        end
    end

    function AP_bag1 = bag1_model(L,L_dot,L_ddot)
        tau_bag1 = 0.149;
        freq_bag1 = 60;
        
        beta0 = 0.0605;
        beta1 = 0.2592;
        Gamma1 = 0.0289;
        
        G = 20000;  %7000
        
        if L_dot >= 0
            C = 1;
        else
            C = 0.42;
        end
        
        
        
        df_dynamic = (gamma_dynamic^p/(gamma_dynamic^p+freq_bag1^p)-f_dynamic)/tau_bag1;
        f_dynamic = 1/Fs_Feedback*df_dynamic + f_dynamic;
        
        beta = beta0 + beta1 * f_dynamic;
        Gamma = Gamma1 * f_dynamic;
        
        T_ddot_bag1 = K_SR/M * (C * beta * sign(L_dot-T_dot_bag1/K_SR)*((abs(L_dot-T_dot_bag1/K_SR))^a)*(L-L0_SR-T_bag1/K_SR-R)+K_PR*(L-L0_SR-T_bag1/K_SR-L0_PR)+M*L_ddot+Gamma-T_bag1);
        T_dot_bag1 = T_ddot_bag1*1/Fs_Feedback + T_dot_bag1;
        T_bag1 = T_dot_bag1*1/Fs_Feedback + T_bag1;
        
        AP_bag1 = G*(T_bag1/K_SR-(LN_SR-L0_SR));
    end

    function [AP_primary_bag2,AP_secondary_bag2] = bag2_model(L,L_dot,L_ddot)
        tau_bag2 = 0.205;
        freq_bag2 = 60;
        
        beta0 = 0.0822;
        beta2 = -0.046;
        Gamma2 = 0.0636;
        
        if L_dot >= 0
            C = 1; %constant describing the experimentally observed asymmetric effect of velocity on force production during lengthening and shortening
        else
            C = 0.42;
        end
        
        G = 10000; %7250 %3800
        
        df_static = (gamma_static^p/(gamma_static^p+freq_bag2^p)-f_static)/tau_bag2;
        f_static = 1/Fs_Feedback*df_static + f_static;
        
        beta = beta0 + beta2 * f_static;
        Gamma = Gamma2 * f_static;
        
        T_ddot_bag2 = K_SR/M * (C * beta * sign(L_dot-T_dot_bag2/K_SR)*((abs(L_dot-T_dot_bag2/K_SR))^a)*(L-L0_SR-T_bag2/K_SR-R)+K_PR*(L-L0_SR-T_bag2/K_SR-L0_PR)+M*L_ddot+Gamma-T_bag2);
        T_dot_bag2 = T_ddot_bag2*1/Fs_Feedback + T_dot_bag2;
        T_bag2 = T_dot_bag2*1/Fs_Feedback + T_bag2;
        
        AP_primary_bag2 = G*(T_bag2/K_SR-(LN_SR-L0_SR));
        AP_secondary_bag2 = G*(X*L_secondary/L0_SR*(T_bag2/K_SR-(LN_SR-L0_SR))+(1-X)*L_secondary/L0_PR*(L-T_bag2/K_SR-L0_SR-LN_PR));
        
    end

    function [AP_primary_chain,AP_secondary_chain] = chain_model(L,L_dot,L_ddot)
        
        freq_chain = 90;
        
        beta0 = 0.0822;
        beta2_chain = - 0.069;
        Gamma2_chain = 0.0954;
        
        
        if L_dot >= 0
            C = 1; %constant describing the experimentally observed asymmetric effect of velocity on force production during lengthening and shortening
        else
            C = 0.42;
        end
        G = 10000; %7250    %3000
        
        f_static_chain = gamma_static^p/(gamma_static^p+freq_chain^p);
        
        beta = beta0 + beta2_chain * f_static_chain;
        Gamma = Gamma2_chain * f_static;
        
        T_ddot_chain = K_SR/M * (C * beta * sign(L_dot-T_dot_chain/K_SR)*((abs(L_dot-T_dot_chain/K_SR))^a)*(L-L0_SR-T_chain/K_SR-R)+K_PR*(L-L0_SR-T_chain/K_SR-L0_PR)+M*L_ddot+Gamma-T_chain);
        T_dot_chain = T_ddot_chain*1/Fs_Feedback + T_dot_chain;
        T_chain = T_dot_chain*1/Fs_Feedback + T_chain;
        
        AP_primary_chain = G*(T_chain/K_SR-(LN_SR-L0_SR));
        AP_secondary_chain = G*(X*L_secondary/L0_SR*(T_chain/K_SR-(LN_SR-L0_SR))+(1-X)*L_secondary/L0_PR*(L-T_chain/K_SR-L0_SR-LN_PR));
        
    end

    function Af_slow = ActivationFrequency_slow(Activation,L,L_dot)
        Uth = 0.001;
        f_half = 8.5; %f_half = 34; %can be found in Table 2 of Brown and Loeb 2000
        fmin = 4; %fmin = 15;
        fmax = 2*f_half; %fmin = 0.5*f_half %can be found in Song et al. 2008
        af = 0.56;
        nf0 = 2.11;
        nf1 = 5;
        cy = 0.35;
        Vy = 0.1;
        Ty = 0.2;
        
        Tf1 = 0.0484;
        Tf2 = 0.032;
        Tf3 = 0.0664;
        Tf4 = 0.0356;
        
        Y_dot = (1 - cy*(1-exp(-abs(L_dot)/Vy))-Y)./Ty;
        Y = Y_dot*1/Fs + Y;
        
        fenv = (fmax-fmin)/(1-Uth).*Activation+fmin-(fmax-fmin)*Uth;
        fenv = fenv/f_half;
        
        if feff_dot >= 0
            Tf = Tf1 * L^2 + Tf2 * fenv;
        elseif feff_dot < 0
            Tf = (Tf3 + Tf4*Af)/L;
        end
        
        fint_dot = (fenv - fint)/Tf;
        fint = fint_dot*1/Fs + fint;
        feff_dot = (fint - feff)/Tf;
        feff = feff_dot*1/Fs + feff;
        
        nf = nf0 + nf1*(1/L-1);
        Af_slow = 1 - exp(-(Y*feff/(af*nf))^nf);
        
    end

    function Af_fast = ActivationFrequency_fast(Activation,L)
        Uth = 0.001;
        f_half = 34; %f_half = 34; %can be found in Table 2 of Brown and Loeb 2000
        fmin = 15; %fmin = 15;
        fmax = 2*f_half; %fmin = 0.5*f_half %can be found in Song et al. 2008
        af = 0.56;
        nf0 = 2.11;
        nf1 = 3.3;
        as1 = 1.76;
        as2 = 0.96;
        Ts = 0.043;
        
        Tf1 = 0.0206;
        Tf2 = 0.0136;
        Tf3 = 0.0282;
        Tf4 = 0.0151;
        
        
        fenv = (fmax-fmin)/(1-Uth).*Activation+fmin-(fmax-fmin)*Uth;
        fenv = fenv/f_half;
        
        if feff_dot >= 0
            Tf = Tf1 * L^2 + Tf2 * fenv;
        elseif feff_dot < 0
            Tf = (Tf3 + Tf4*Af)/L;
        end
        
        if feff < 0.1
            as = as1;
        elseif feff >= 0.1
            as = as2;
        end
        
        Saf_dot = (as - Saf)/Ts;
        Saf = Saf_dot*1/Fs + Saf;
        
        
        fint_dot = (fenv - fint)/Tf;
        fint = fint_dot*1/Fs + fint;
        feff_dot = (fint - feff)/Tf;
        feff = feff_dot*1/Fs + feff;
        
        nf = nf0 + nf1*(1/L-1);
        Af_fast = 1 - exp(-(S_af*feff/(af*nf))^nf);
        
    end

    function FL = FL(L)
        
        beta = 2.3;
        omega = 1.12;
        rho = 1.62;
        
        FL = exp(-abs(((L^beta - 1)/omega)^rho));
    end

    function FVcon = FVcon(L,V)
        Vmax = -7.88;
        cv0 = 5.88;
        cv1 = 0;
        
        FVcon = (Vmax - V)/(Vmax + (cv0 + cv1*L)*V);
    end

    function FVecc = FVecc(L,V)
        
        av0 = -4.7;
        av1 = 8.41;
        av2 = -5.34;
        bv = 0.35;
        FVecc = (bv - (av0 + av1*L + av2*L^2)*V)/(bv+V);
    end

    function Fpe1 = Fpe1(L)
        
        c1_pe1 = 23;  %355, 67.1
        k1_pe1 = 0.046; %0.04, 0.056
        Lr1_pe1 = 1.17;  %1.35, 1.41
        
        
        Fpe1 = c1_pe1 * k1_pe1 * log(exp((L - Lr1_pe1)/k1_pe1)+1);
        
    end

    function Fpe2 = Fpe2(L)
        c2_pe2 = -0.02; %0.01  -0.1
        k2_pe2 = -21;
        Lr2_pe2 = 0.70; %0.79 0.59
        
        Fpe2 = c2_pe2*exp((k2_pe2*(L-Lr2_pe2))-1);
        
    end

    function Fse = Fse(LT)
        
        cT_se = 27.8;
        kT_se = 0.0047;
        LrT_se = 0.964;
        
        Fse = cT_se * kT_se * log(exp((LT - LrT_se)/kT_se)+1);
        
    end


end