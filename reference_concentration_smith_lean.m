% Tue 10 Jul 10:10:44 CEST 2018
%% reference concentration according to smith and mclean
% c.f. Parker 1991
% D : mm
function [cr,zr] = reference_concentration_smith_mclean(us,D)
	rhow = 1e3;
	gamma = 2.4e-3;
	a0 = 26.3;
	usc   = critical_shear_velocity(D);
	S0    = (us.^2 - usc.^2)./(usc.^2);
	ks    = 5*(1e-3*D);
	% TODO what roughness for us? grain roughness?
	cr   = 0.65*gamma*S0./(1+gamma*S0);
	zr = a0*rhow*(us.^2-usc.^2).*(1e-3*D) + ks;
end

