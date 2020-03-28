% Thu 25 Jul 12:01:45 CEST 2019
% note : http://onlinecalc.sdsu.edu/onlineengelundhansen.php fails for small slope
% and seems to be off by a factor of two (too large)
%% sediment transport according to engelund and hansen
% Thu 25 Jul 11:09:57 CEST 2019
function [Phi, Phi_D, Phi_T] = sediment_transport_engelund_hansen_2(C,C_D,D,d_mm,theta)
	if (issym(C))
		syms g
	else
		g        = Constant.gravity;
	end

	% normalize
	c     = C/sqrt(g);

	% note : as C_D is defined as ratio, it is implicitely normalized
	c_D   = C_D;

	% Redolfi 2019, B5
	% 4.3.5 in EH 1967 (note the factor 2)
	% NOTE that EH has factor 0.1 -> different definition of friciton coefficient?
	Phi   = 0.05*c.^2.*theta.^2.5;

	% B4,B6 : Phi_D = D0./Phi0*dPhi_dD
	Phi_D = 2*c_D;

	% B4,B6 : Phi_T = theta_0./Phi0*dPhi_dtheta
	Phi_T = 2.5;
end

