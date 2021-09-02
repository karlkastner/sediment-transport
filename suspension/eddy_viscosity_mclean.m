% 2020-11-15 13:43:21.748005372 +0800
% c.f. mclean 1992
%
% Km : eddy viscosity
% Ks : eddy diffisuvity
% Kn : clear water diffusivity and viscosity
function [Km, Ks, Kn] = eddy_viscosity_mclean(eta,h,us,ws_n,Cs_n)
	g      = Physics.gravity;
	rhow   = Physics.density.water;
	rhos   = Physics.density.quartz;
	kappa  = Physics.Karman;

	gamma  = 5.4;
	sigma  = 1;
	beta   = 0.25*gamma^2; % = 7.3


	% total concentration of combined size fractions
	Cs  = sum(Cs_n,2);
	Cs  = min(Cs,1);

	% clear water eddy viscosity profile
	% below eq. 30 in 1992
	f_eta = eta.*(1-eta);
	
	% clear water eddy viscosity
	% eq 30 in 1992
	Kn  = kappa.*abs(us).*h.*f_eta;

	% stratification parameter
	% 1992, eq 29
	chi = g*kappa*(rhos-rhow)/rhow*sum(ws_n.*Cs_n,2).*(1-Cs).*h.*f_eta./(abs(us).^3.*(1-eta).^2);
	chi((1-eta)==0|us==0) = 0;

	% eddy viscosity
	% 13 a, (25 1992)
	Km = Kn./(1 + gamma*chi);		
	
	% eddy diffusivity
	% 13 b (26 in 1992)
	Ks = Kn./(sigma + beta*chi);
end % eddy_viscosity_mclean

