% Sa 12. Mär 16:15:49 CET 2016
% Fri 27 Jan 15:36:18 CET 2017
%
%% total sediment transport according to Engelund and Hansen
%
% C : chezy
% d : grain size (mm)
% Q : discharge (m^3/s)
% U : velocity (m/s)
% W : width (m)
% rhos : denisty of sediment kg/m^3
% rhow : density of water kg/m^3
%
% function [Qs qs_m Phi] = total_transport_engelund_hansen(C,d_mm,U,H,W,rhos,rhow)
function [Qs_m, qs_m, Phi] = total_transport_engelund_hansen(C,d_mm,U,H,W,rhos,rhow)
	if (~issym(C))
		g = Constant.gravity;
	else
		syms g kg m
	end

	if (nargin() < 5 || isempty(W))
		W = 1;
	end
	if (nargin() < 6 || isempty(rhos))
		rhos = Constant.density.quartz;
		if (issym(C))
			syms rhos positive; % = rhos; %*kg/m^3;
		end
	end
	if (nargin() < 7 || isempty(rhow))
		rhow = Constant.density.water;
		if (issym(C))
			syms rhow positive; % = rhow; %*kg/m^3;
		end
	end

	if (~issym(C))
	C      = Expanding_Double(C);
	d_mm   = Expanding_Double(d_mm);
	U      = Expanding_Double(U);
	H      = Expanding_Double(H);
	W      = Expanding_Double(W);
	end	

	% mm to meter
	d_m = 1e-3*d_mm;
	%U = Qw./(W.*H);

	% relative density of the sediment
	s = rhos./rhow;
	%gammaw = g*rhow;

	% friction factor (3.1.3)
	f = 2*g./C.^2;

	% shear velocity squared (3.1.2)
	us2 = g./C.^2.*U.^2;
	%us2 = btimes(g./C.^2,U.^2);

	% bed shear stress
	% 3.6.2
	tau = rhow*us2;

	% dimensionless shear stress (shields number) (3.2.3,4.2.7)
	theta = tau./(g*(rhos-rhow).*d_m);
	%theta = btimes(tau,1./(g*(rhos-rhow).*d_m));
	%theta = tau./(g*rho_w*(s-1)*d_m);
	%theta = tau./(gammaw*(s-1)*d_m);

	% non dimensional total transport
	% 4.3.5
	Phi = 0.1*sign(U).*1./f.*theta.^(5/2);
	%Phi = 0.1*btimes(1./f,sign(U).*theta.^(5/2));

	% volumetric transport per unit with
	% above 4.1.6, 4.3.2
	% c.f. wu 3.105
	% before 3.3.1
	qs_v = sqrt(g*(s-1).*d_m.^3).*Phi;
	%qs_v = btimes(sqrt(g*(s-1).*d_m.^3),Phi);

	% mass transport per unit width
	qs_m = rhos.*qs_v;

	% mass transport trhough cross section
	Qs_m = W.*qs_m;
	%Qs_v = W.*qs_v;
	%Qs = btimes(W,qs_m);
end % sediment_transport_eh
 
