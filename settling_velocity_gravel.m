% 2017-05-09 12:24:09.365833309 +0200
%% settling velocity in water
function ws = settling_velocity_gravel(d)
	rhow = Constant.density.water;
	rhos = Constant.density.quartz;
	g    = Constant.gravity;
	% mm to m
	d  = 1e-3*d;
	Cd = 1.5;
	ws = sqrt(1/Cd*4/3*(rhos/rhow - 1)*g*d);
end
