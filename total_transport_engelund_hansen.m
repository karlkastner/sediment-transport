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
function [Qs_m, qs_m, Phi] = total_transport_engelund_hansen(C,d_mm,U,H,W,rho_s,rho_w)
	if (~issym(C) && ~isa(C,'symfun'))
		g = Constant.gravity;
	else
		syms g kg m
	end
	if (nargin() < 4 || isempty(H))
		H = NaN;
	end

	if (nargin() < 5 || isempty(W))
		W = 1;
	end
	if (nargin() < 6 || isempty(rho_s))
		if (~issym(C) && ~isa(C,'symfun'))
			rho_s = Constant.density.quartz;
		else
			syms rho_s positive; % = rhos; %*kg/m^3;
		end
	end
	if (nargin() < 7 || isempty(rho_w))
		if (~issym(C) && ~isa(C,'symfun'))
			rho_w = Constant.density.water;
		else
			syms rho_w positive; % = rhow; %*kg/m^3;
		end
	end

	if (0)
	if (~issym(C))
	C      = Expanding_Double(C);
	d_mm   = Expanding_Double(d_mm);
	U      = Expanding_Double(U);
	H      = Expanding_Double(H);
	W      = Expanding_Double(W);
	end
	end	

	% mm to meter
	d_m = 1e-3*d_mm;
	%U = Qw./(W.*H);

	% relative density of the sediment
	%s = rho_s./rho_w;
	%gammaw = g*rhow;

	% friction factor (3.1.4)
	f = 2*g./C.^2;

	% shear velocity squared (3.1.2)
	%us2 = g./C.^2.*U.^2;
	%us2 = btimes(g./C.^2,U.^2);

	% bed shear stress
	% 3.6.2
	%tau = rho_w*us2;

	% dimensionless shear stress (shields number)
	% (3.2.3,4.2.7)
	theta = shields_number(C,U,d_mm);

	% non dimensional total transport
	% 4.3.5
	if (~issym(U) & ~issym(H))
		Phi = 0.1*sign(U).*1./f.*theta.^(5/2);
		Phi(H<=0) = 0;
	else
		Phi = 0.1*1./f.*theta.^(5/2);
	end

	% volumetric transport per unit with
	% above 4.1.6, 4.3.2
	% c.f. wu 3.105
	% before 3.3.1
	scale = sediment_transport_scale(d_mm);

	%qs_v = sqrt(g*(s-1).*d_m.^3).*Phi;
	qs_v = scale.*Phi;
	%qs_v = btimes(sqrt(g*(s-1).*d_m.^3),Phi);

	% mass transport per unit width
	qs_m = rho_s.*qs_v;

	% mass transport trhough cross section
	Qs_m = W.*qs_m;
	%Qs_v = W.*qs_v;
	%/home/pia/phd/literature/sediment/theory/monograph-on-sediment-in-alluvial-transport-streams-engelund-hansen-1967.pdfQs = btimes(W,qs_m);
end % sediment_transport_eh
 
