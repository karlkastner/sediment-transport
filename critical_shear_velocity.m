% Sat 20 May 16:37:41 CEST 2017
%% critical shear velocity
% function usc = critical_shear_velocity(d50)
function usc = critical_shear_velocity(d50,T_C)
	rhow = Constant.density.water;
	tau_c = critical_shear_stress(d50,T_C);
	usc = sqrt(tau_c/rhow);
end

