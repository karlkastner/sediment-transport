% Fri 27 Dec 15:46:22 +08 2019
% fit a general transport relation to observations
function [rc,p] = fit_sediment_transport_relation(Qs,Q,W,n,S,d_mm)
	rho_s   = 2650;
	rho_w   = 1000;
	g = 9.81;

	C       = ( Q ./ (S.^(1/2).*W.*n.^9) ).^(1/10);
	U       = normal_flow_velocity(Q,W,C,S);

	theta   = shields_number(C,U,d_mm,rho_s,rho_w);

	Qs_     = Qs.*(2*g./(W.*rho_s.*C.^2));
	
	rc      = PowerLS();

	scale = sediment_transport_scale(d_mm);
	f     = 2*g./C.^2;
	Qs_   = Qs./(rho_s.*W.*1./f.*scale);
	rc.fit(theta,Qs_);
	p       = rc.param;
	p(1)    = exp(p(1));
end



