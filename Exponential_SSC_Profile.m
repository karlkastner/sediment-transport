% 2018-05-27 19:25:19.982510833 +0800

	% ikeda 1986, eq 35
	% c = c0 exp( - ws/epsz z )
	% c0 : near bed concentration
	function fit(ssc,z,)
		% epsz = 0.077 us h
		% c0 = 2.31 10^-4 (us/vs)^1.6, us/vs < 88.3
		A     = [ones(n,1), log(z)];
		param = A\log(ssc);
	end

	function c0 = reference_concentration()
		c0 = exp(obj.param(1,:));
	end

	function rouse = rouse_number()
		% rouse = ws/(kappa us)
		% p2    = ws/epsz = ws/(0.077 us h)
		p     = obj.param(2,:);
		rouse = p2*0.077*h/Constant.KARMAN;
	end

