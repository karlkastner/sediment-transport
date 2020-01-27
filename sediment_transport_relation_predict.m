% Fri 27 Dec 15:47:33 +08 2019
function [Qs] = sediment_transport_relation_predict(Q,W,n,S,rc,d_mm)
	rho_s   = 2650;
	rho_w   = 1000;
	d_m     = 1e3*d_mm;
	g       = 9.81;

	C       = ( Q ./ (S.^(1/2).*W.*n.^9) ).^(1/10);
	U       = normal_flow_velocity(Q,W,C,S);

	theta   = shields_number(C,U,d_mm,rho_s,rho_w);
	
	Qs_     = rc.predict(theta);

	scale = sediment_transport_scale(d_mm);
	f     = 2*g./C.^2;
	Qs   = (rho_s.*W.*1./f.*scale).*Qs_;
end
