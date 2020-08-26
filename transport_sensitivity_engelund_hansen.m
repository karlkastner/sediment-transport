% Fri 21 Aug 13:07:35 +08 2020
function dQs_dh = sensitivity_engelund_hansen(Qs,h,w)
	p      = Physics.packing_density.spheres;
	rho    = Physics.density.quartz;
	dQs_dh = 5./(p.*rho.*w.*h).*Qs;
end

