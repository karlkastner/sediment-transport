% Tue  9 May 10:25:13 CEST 2017
%% Settling velocity
%% 5.23d in julien-2010
% d given in mm
% function ws = settling_velocity(d_mm,mode)
function ws   = settling_velocity(d_mm,T_C,mode)
	nu    = Constant.viscosity_kinematic_water(T_C);
	mu    = Constant.viscosity_dynamic_water(T_C);
	g     = Constant.gravity; % m/s^2
	rho_w = Constant.density.water; % kg/m^3
	rho_s = Constant.density.quartz; % kg/m^3
	ds    = dimensionless_grain_size(d_mm,T_C);
	d_m   = 1e-3*d_mm;
	if (nargin()<2)
		T_C = 20;
	end
	if (nargin()<3 || isempty(mode))
		mode = 'default';
	end
	% mm to m
	switch (mode)
	case {'sym'}
		syms ws
	case {'cheng'}
		% 2017-05-17 17:53:45.763056219 +0200
		%% settling velocity according to cheng
		% c.f. sassi
		% mm to m
		a = 32;
		B = 1;
		M = 1.5;
		ws = nu./d_m.*(sqrt(1/4*(a/B).^(2/M) + (4/3*ds.^3./B).^(1/M)) - 1/2*(a/B).^(1/M)).^M;
	case {'dietrich'}
		% note, dietrichs relation seems to strongly understimate the settling of gravel (factor 10!)
		% in general, settling velocity is lower than with other relations
		ws = settling_velocity_dietrich_1982(d_mm,T_C);
	case {'gravel'}
		% 2017-05-09 12:24:09.365833309 +0200
		%% settling velocity in water
		Cd = 1.5;
		ws = sqrt(1/Cd*4/3*(rho_s/rho_w - 1)*g*d_m);
	case {'julien','default'}
		ws   = 8*nu./d_m.*(sqrt(1 + 0.0139*ds.^3) - 1);
	case {'rijn'} % c.f. 11.31 in documentation
		% TODO mud settling is again different
		s = (rho_s/rho_w);
		% stokes
		ws      = g/(18*nu)*(s-1)*d_m.^2;
		fdx     = (d_mm > 0.1 & d_mm < 1); 
		% zanke
		ws(fdx) = 10*nu./d_m(fdx).*( sqrt(1 + 0.01*(s-1).*g.*d_m(fdx).^3./nu.^2) - 1); 
		% newtonian range
		fdx     = (d_mm > 1);
		ws(fdx) = 1.1*sqrt((s-1)*g*d_m(fdx));
		% TODO reduction for concentration
		% ws = (1-c)^4*ws;
	case {'stokes'}
		% Fri Aug  9 17:34:28 UTC 2013
		% 2017-05-09 12:26:48.065539033 +0200
		% Karl Kästner, Berlin
		%% stokes settling velocity
		%% d : [mm] diameter of sediment particle
		%% ws : [m/s] settling velocity
		%%            signed ws < 0 : falling
		%% (Note: was R, radius in m)
		%%
		%% valid for small particles
		% dynamic viscosity Pa*s = kg/(m*s)
		% mm to m
		% sign inverted
		ws   = g/(18*mu).*(rho_s - rho_w).*d_m.^2;
	otherwise 
		error('here');
	end
end

function ws = settling_velocity_dietrich_1982(d_mm,T_C)
	nu = Constant.viscosity_kinematic_water(T_C);
	Ds = dimensionless_grain_size(d_mm,T_C).^3;
	rho_s = 2650;
	rho_w = 1e3;
	g = 9.81;

	% p 1623 "typical coarse sand"
	P   = 3.5;
	CSF = 0.7;
	% rhs of eq 9
	R1 = (  - 3.76715 ...
                + 1.92944*log10(Ds) ...
		- 0.09815*log10(Ds).^2 ...
		- 0.00575*log10(Ds).^3 ...
		- 0.00056*log10(Ds).^4 ...
	     );
	% follows 15 c
	R2 = ( log10(1-(1-CSF)./0.85) ...
	 	- (1-CSF).^2.3*tanh(log10(Ds)-4.6) ...
		+ 0.5*(0.5 - CSF)*(1-CSF).^2.0*(log10(Ds)-4.6) ...
	     );
	% eq 18
	R3 = (0.65-(CSF/2.83*tanh(log10(Ds)-4.6))).^(1+(3.5-P)/2.5);
	W_star = R3.*10.^(R1 + R2);

	ws = cbrt(W_star.*(((rho_s - rho_w)./rho_w).*g.*nu));
end

