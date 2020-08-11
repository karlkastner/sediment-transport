% Sat 27 Jul 23:49:57 CEST 2019
function [Cz,C_sk] = total_roughness_parker(d_mm,h,U)
	d_m = 1e-3*d_mm;
	ks  = 2.5*d_m;
	kappa = 0.41;
	g = 9.81;
	rho_w = 1e3;

	Fr = U./sqrt(g*h);

	C_sk  = 1/kappa*log(11*h./ks);

	us_sk  = U.*sqrt(g)./C_sk;
	tau_sk = rho_w*us_sk.^2;

	% tau_sk = 0.05 + 0.7*(tau*Fr^0.7)^0.8;
	tau = (1/0.7*max(tau_sk-0.05,0)).^(1/0.8).*1./Fr.^0.7;

	% total roughenss
	kc = ks.*(tau./tau_sk).^4;
	kc = max(ks,kc);
	% 2.17b in garcia
	c = 1/kappa*log(11*h./kc);
	Cz = sqrt(g)*c;
	%1/0.4*log(11*h/kc) = 1/0.4*log(11*h/ks*(tau_sk/tau)^4)
	%	   = 1/0.4*(log(11h/ks) + 4*log(tau_sk/tau))
limits(tau_sk)
end

