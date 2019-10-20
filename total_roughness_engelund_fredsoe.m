% Sat 27 Jul 14:30:28 CEST 2019
%% roughness lenght according to engelund and fredsoe
% function [C,Ct] = total_roughness_engelund_fredsoe(d_mm,h,U)
function [C,Ct] = total_roughness_engelund_fredsoe(d_mm,h,U)
	Delta = 1.65;
	g     = 9.81; 
	d_m   = 1e-3*d_mm;
        [Ct, dC_dD_rel] = chezy_roughness_engelund_fredsoe(d_mm,h);     

        St      = (U.^2./(Ct.^2.*h));                                   
        theta_t = St.*h./(Delta.*d_m);                                   

        [theta,C,D_] = skin_2_total_friction_eh(theta_t,Ct,h);
end

