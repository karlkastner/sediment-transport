% Mon  5 Aug 14:09:13 CEST 2019
%% bed load transport rate according to meyer-peter-mueller
% TODO hiding and exposure correction for gravel
% TODO hydraulic radius correction
% function [Qs_m,qss] = bed_load_transport_mpm(U,Csf,d_mm,W)
function [Qs_m,qss] = bed_load_transport_mpm(U,Csf,d_mm,W,d90_mm,H,tauc)
	d_m = 1e-3*d_mm;
	if (nargin()<4)
		W = 1;
	end
	if (~issym(U))
		rho_w   = Constant.density.water;
		rho_s   = Constant.density.quartz;
		g       = Constant.gravity;
	else
		syms rho_w rho_s g positive
	end
	%us     = sqrt(g)./Csf.*U;
	%tau    = rho_w*us.^2;
	if (nargin()<7)
		tauc   = 0.047;
	end

	%taus   = tau/((rho_s-rho_w)*g*D)
	taus  = shields_number(Csf,U,d_mm); %,rho_s,rho_w)

	% ripple factor
	% d3d docu writes here min, but it should be max
	%mu = min(1,
	% n' = d90^(1/6)/26;
	if (nargin()>4 && ~isempty(d90_mm))
		% note that (ng/n) = (C/Cg)
		% c.f. wu 2007
		n_g = grain_roughness_mpm(d90_mm);
		n   = chezy2manning(Csf,H);
		%r = grain_roughness_rijn(d90_mm,H);
		%n_g = double(r.n)
		% as in d3d and CFD by Bates
		%Cg = manning2chezy(n_g,H)
		%mu = (Csf/Cg)^1.5
		mu  = (n_g/n)^1.5;
	else
		mu = 1;
	end

	if (~issym(taus))
		qss    = 8*max(0, mu.*taus - tauc).^(3/2);
	else
		qss    = 8*(mu.*taus - tauc).^(3/2);
	end


	scale  = sediment_transport_scale(d_mm);
	%qs     = d_m.*sqrt((rho_s/rho_w-1).*g.*d_m.^3).*qss;
	qs     = scale.*qss;
	Qs_vol = W.*qs;
	Qs_m   = rho_s*Qs_vol;
end

