% Sat 27 Jul 14:30:28 CEST 2019
%% roughness lenght according to engelund and fredsoe
% function [C,Ct] = total_roughness_engelund_fredsoe(d_mm,h,U)
function [C,Ct] = total_roughness_engelund_fredsoe(d_mm,h,U)
	if (~issym(d_mm))
		g     = Constant.gravity;
		rho_w = Constant.density.water;
		rho_s = Constant.density.quartz;
	else
		syms g rho_s rho_w
	end
	Delta = (rho_s-rho_w)/rho_w;;
	d_m   = 1e-3*d_mm;

	% total shear velocity
	us    = sqrt(g*h*S);

	% total shear stress
	tau_s =  
       
	[Ct, dC_dD_rel] = chezy_roughness_engelund_fredsoe(d_mm,h);     

        St      = (U.^2./(Ct.^2.*h));                                   
        theta_t = St.*h./(Delta.*d_m);                                   

        [theta,C] = skin_2_total_friction_eh(theta_t,Ct);
end

