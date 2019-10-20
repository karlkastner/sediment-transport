% Fr 25. Sep 15:22:07 CEST 2015
% Karl Kastner, Berlin
%% bed load transport
%% method of van Rijn (1984)
%%
%% function [Q_b q_b Phi_b] = bed_load_transport_rijn(C,d50,d90,U,d,b)
%%
%% d50 [mm] (converted to m)
%% d90 [mm] (converted to m)
%%
%% d : depth
%% b : width
%% 
function [Q_bm, q_bm, Phi_b] = bed_load_transport_rijn(C,d50_mm,d90_mm,U,d,b)
	% fetch constants
	g     = Constant.gravity;
	rho_w = Constant.density.water;
	rho_s = Constant.density.quartz;

	% implicit use of bsxfun
	C   = Expanding_Double(C);
	d50 = Expanding_Double(d50_mm);
	d90 = Expanding_Double(d90_mm);
	U   = Expanding_Double(U);
	d   = Expanding_Double(d);
	b   = Expanding_Double(b);

	s     = rho_s ./ rho_w;

	% 1 eq 1
	% mm to m
	d50   = 1e-3*d50_mm;
	d90   = 1e-3*d90_mm;

	ds    = dimensionless_grain_size(d50);

	% hydraulic radius according to vanoni-brooks
	R     = b.*d./(b+2*d);
	R     = max(R,0);

	T = transport_stage_rijn(d50_mm,d90_mm,R,U);

	% 6 eq 22 transport capacity
	% c.f. wu 3.70
	% c.f. rijn 1984
	Phi_b =   (T <3).*0.053.*T.^2.1.*ds.^-0.3 ...
                + (T>=3).*0.100.*T.^1.5.*ds.^-0.3;
	Phi_b = sign(U).*Phi_b;

	% bed load transport volumetric
	q_bv  = sqrt(g*(s-1.0)*d50.^3).*Phi_b;

	% mass tranport
	q_bm   = rho_s*q_bv;

	% bed load through cross section
	Q_bm   = b.*q_bm;
end % function bed_load_transport

