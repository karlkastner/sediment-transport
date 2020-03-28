% Fri 27 Mar 11:55:42 +08 2020
% U : depth averaged velocity (V in Yang)
function [Qs,qs_m,Phi,C] = total_transport_yang(C,d_mm,U,H,W,T_C,flag)
	g     = Constant.gravity;
	rho_w = 1000;

	if (nargin()<7)
		flag = false;
	end

	% settling velocity (omega in Yang)
	ws = settling_velocity(d_mm,T_C);

	% kineamtic viscosity
	nu    = Constant.viscosity_kinematic_water(T_C);

	% shear velocity
	u_s = shear_velocity(U,C);

	% S : energy slope (= surface slope)
	S = u_s.^2./(g*H);

	d_m = 1e-3*d_mm;

	% d50 : median sieve diameter of sediment (d50_mm)
	if (flag)
	% note brownlie has typos: he misses to factor in ws,
	% and also the offset 0.66
	u_cr = (2.5./(log10(u_s.*d_m./nu)-0.06)+0.66).*ws;
	u_cr(u_s.*d_m./nu>70) = 2.05.*ws;


	% apply critical shear stress
	% note: it is not apparent from Yalin's paper and most citations,
	% that he uses the log10, but it is obvious by brownlies comment,
	% that he uese -0.565 instead of 5.435, as -6 has to be added for ppm
	log10_Cest = (    5.435 ...
			- 0.286*log10(ws.*d_m./nu) ...
			- 0.457*log10(u_s./ws) ...
			+ (  1.799 ...
                           - 0.409*log10(ws.*d_m./nu) ... 
			   - 0.314*log10(u_s./ws) ...
                          ).*log10(max(0,U.*S./ws - u_cr.*S./ws)) ...
		   );
	else

	% log10 of depth averaged sediment concentration
	log10_Cest = (     5.156 ...
		         - 0.153*log10(ws.*d_m./nu) ...
			 - 0.297*log10(u_s./ws) ...
			 + (   1.780 ...
			     - 0.360*log10(ws.*d_m./nu) ...
		             - 0.480*log10(u_s./ws) ...
                           ).*log10(U.*S./ws) ...
                   );
	end
	% concentration by weight to mass concentration
	% ppm by weight
	Cest = rho_w*1e-6*exp10(log10_Cest);
	qs   = Cest.*U.*H;
	Qs   = W.*qs;
end %
