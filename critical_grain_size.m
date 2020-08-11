% Sat 10 Mar 22:51:46 CET 2018
%
%% critical grain size for a given shear velocity
%
function d50_mm = critical_grain_size(tau,T_C,method)
	if (~issym(tau))
		g     = Constant.gravity;
		rho_s = Constant.density.quartz;
		rho_w = Constant.density.water;
	else
		syms g rho_s rho_w
	end	

	d_mm    = NaN;
	switch (method)
	case {'mpm','wu'}
		theta_c = critical_shear_stress_ratio(d_mm,T_C,method);
		d50_m  = tau/(theta_c*g*(rho_s - rho_w));
		d50_mm = 1e3*d50_m;
	otherwise
		% TODO use initial value for mpm method
		d50_mm  = 1*ones(size(tau)); % mm
		for idx=1:numel(tau)
			d50_mm(idx) = exp(fzero(@(d50_log) critical_shear_stress(exp(d50_log),T_C,method) - tau(idx),log(d50_mm(idx))));
		end
	end
%	d50_mm = fzero(@(d50_log) critical_shear_stress(d50_log,varargin{:}) - tau,d50_mm);
end

