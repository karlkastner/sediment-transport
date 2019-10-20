% Thu 25 Jul 10:43:54 CEST 2019
%% chezy rougness according to engelund and fredsoe
% C : chezy
% dc_dD_rel = D0./c0*dc_dD
% engelund fredsoe 1982 and eh 1967, 3.6.6
% Note : redolfi references wrong paper, also by eh in 1982
function [C, dC_dD_rel] = chezy_roughness_engelund_fredsoe(d_mm,D)
	if (issym(d_mm))
		syms g kappa
	else
		g = 9.81;
		kappa = 0.4;
	end
	d_m       = 1e-3*d_mm;
	% nikuradse rouhgness length
	k         = 2.5*d_m;
	% note this is Redolfi writes log but means ln
	% EH 3.6.6, see einstein, keluarga
	c         = 1/kappa*log(11*D/k);
%	c         = 6 + 2.5*log(D./k);
%	c         = 6 + 2.5*log(1./(2.5*d_m./D));
	dc_dD_rel = 1./(kappa*c);

	% de-normalize
	C         = sqrt(g)*c;
	dC_dD_rel = dc_dD_rel/sqrt(g);
end


	

