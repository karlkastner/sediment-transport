% Wed 24 May 14:25:46 CEST 2017
% Karl Kastner, Berlin
%% critical shear stress, according to wu
function tau_ck = critical_shea_stress_wu(d)
	thetac = 0.03;
	m      = 0.6;
	tau_ck = (gammas - gammaw)*d*thetac*(pek/phk).^-m;
end

