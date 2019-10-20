% Thu 14 Jun 18:28:24 CEST 2018
%% sediment transport by waves
% bailard 1981
% note that bailard uses <u^p> not <u>^p
function [qtotal,qbo,qso] = sediment_transport_waves(cd,u,ws)
	% TODO consider bed slope
	% soulsby 1997
	rhos = 2650;
	g    = 9.81;
	s    = rhos/1000;
	epsb = 0.1;
	epss = 0.02;

	% friction angle
	tanfi = 0.63;

	qbo = cd*epsb*u.^3/(g*(s-1)*tanfi);
	qso = cd*epss*abs(u.^3).*u/(g*(s-1)*ws);

	qtotal = qbo + qso;

	% this is volumetric -> conversion to mass
	qbo = rhos*qbo;
	qso = rhos*qso;
	qtotal = rhos*qtotal;
end

