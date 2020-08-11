% 2020-01-06 21:41:17.850777883 +0800                                           

T_C = 20;

%tau_c = 

% Figure 1
if (0)
h  = 10;
u  =  2;
% note that he has d84=d50=ks
d50_mm_ = [0.12,0.24,0.48];

figure(1);
clf
for idx=1:length(d50_mm_)
d50_mm = d50_mm_(idx);
d84_mm = d50_mm;
ks = d50_mm;
%C = z02chezy(ks2z0(ks),h);
%a0_dB  = 0.056; % eq 17, page 5761 
%a0_d84 = 0.12;  % page 5766

 %       [Ts,S] = transport_stage_mclean(u,h,d50_mm,T_C);                        
  %      delta_B_mm = bedload_layer_thickness_mclean(d84_mm,Ts);                 
        % z0 = max(ad*D84,a0*delta_B);                  
   %     z0 = 1e-3*a0*delta_B_mm
%	C = z02chezy(z0,h);
C = [];
[Qs,C,u_z,z,z0,z0_f,us] = suspended_transport_mclean(C,u,h,width,d50_mm,d84_mm,T_C);


subplot(3,2,2*(idx-1)+1);
semilogy(u_z./us,z./h)
%axis equal
axis square
%ylim([1e-6,1]);
ylim([1e-6,1]);
xlim([0,50]);
subplot(3,2,2*(idx-1)+2);
loglog(C,z./h)
%axis equal
xlim([1e-5,1])
ylim([1e-6,1]);
set(gca,'xtick',10.^(-5:0));
axis square
end
pause
end

% table 1
h = 1.0; % m
u = 1.25; % m/s
d50_mm = 0.12;
d84_mm = d50_mm;
%d84_mm = 1.4*d50_mm; % to have the same critical shear stress
tau_c = 0.146; % N/m^2
tau_c_control = critical_shear_stress(d50_mm,T_C)
%pause
ws = 9.3  % somewhat less than determined by the relation
ws_control = settling_velocity(0.12,T_C)
width = 1;

C    = [];
rhow = 1000;
% case 0, no bedforms
[Qs,Cs,z,u_z,us_f,us_T,z0_f,z0_T,scale] = suspended_transport_mclean(C,u,h,width,d50_mm,d84_mm,T_C);
T{1,1} = rhow*us_f.^2;
T{2,1} = z0_f;
T{3,1} = rhow*us_T.^2;
T{4,1} = Qs*1e3/2650;
T{8,1} = mean(Cs)*1e3;

%table 2
%[Ts,S] = transport_stage_mclean(u,h,d50_mm,T_C);                        
%delta_B_mm = bedload_layer_thickness_mclean(d84_mm,Ts);                 
%z0 = 1e-3*a0*delta_B_mm
%C = z02chezy(z0,h);
%us = shear_velocity(u,C)
z0_f
taub_ = 1000*us.^2
Csbar = mean(Cs.*u_z)./mean(u_z)

% case 3, with bedforms
l_d = 0.15;
h_d = 0.015;
[Qs,Cs,z,u_z,us_f,us_T,z0_f,z0_T,scale] = suspended_transport_mclean(C,u,h,width,d50_mm,d84_mm,T_C,h_d,l_d);
T{1,3} = rhow*us_f.^2;
T{2,3} = z0_f;
T{3,3} = rhow*us_T.^2;
T{4,3} = Qs*1e3/2650;
T{8,3} = mean(Cs)*1e3;
T

tauT = rhow*us_T.^2

Csbar = mean(Cs.*u_z)./mean(u_z)



