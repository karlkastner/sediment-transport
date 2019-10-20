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
function ws = settling_velocity_stokes(d)
	g     = Constant.gravity; % m/s^2
	rho_w = Constant.density.water; % kg/m^3
	rho_s = Constant.density.quartz; % kg/m^3
	% dynamic viscosity Pa*s = kg/(m*s)
	mu = Constant.viscosity.dynamic.water;
	% mm to m
	d = 1e-3*d;
	ws = -g/(18*mu).*(rho_s - rho_w).*d.^2;
end % settling_velocity

