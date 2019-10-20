% Sat 10 Mar 22:51:46 CET 2018
%
%% critical grain size for a given shear velocity
%
function d50_mm = critical_grain_size(tau,varargin)
	d50_mm = 1*ones(size(tau)); % mm
	for idx=1:numel(tau)
		d50_mm(idx) = exp(fzero(@(d50_log) critical_shear_stress(exp(d50_log),varargin{:}) - tau(idx),log(d50_mm(idx))));
	end
%	d50_mm = fzero(@(d50_log) critical_shear_stress(d50_log,varargin{:}) - tau,d50_mm);
end

