% 2019-05-12 17:28:31.562709808 +0800
% mclean 1992
% form drag influence on sediment concentration profile?
function Qs = suspended_sediment_transport_mclean(u,h,w,d50_mm)
	d84_mm = d50_mm;

	% eq 2
	% I = 1/h*int_a^h u/ubar Cs/Ca dz

	% velocity profile : eq 5
	%% u := us/kappa*log(z/z0);
	% concentration profile
	%% C := Ca*(a/z*(h-z)/(h-a)).^p;
	% numerically integrate to get I

	ws = settling_velocity(d50_mm);
	p  = ws/(kappa*us);

	% Transport stage
	[Ts,S] = transport_stage_mclean(u,h,d50_mm);

	% it is unclear, that this is here really d84 and not d50
	dB = bed_load_layer_thickness_mclean(d84_mm,Ts)
	a0 = 0.056;
	z0 = a0*dB;

	%ubar = log_profile_ubar(us,H,z0);
	ubar = us/kappa*(log(h/z0)-1);

	% p5767 
	a = bed_load_layer_thickness_mclean(d84_mm,Ts);

	% eq 31
	gamma0 = 0.004;
	cb     = 0.6;
	Ca     = gamma0*cb*S/(1+gamma0*S);

	% eq 1
	qs     = Ca*ubar*h*I;
end

function I(a,z0,h,p)
	a_ = max(a,z0);
	n  = 1e2;
	z  = linspace(a_,h,n);
	dz = (h-a_)/(n-1); 
	% normalized velocity
	u  = log(z/z0)/(log(h/z0)-1);
	% normalized concentration
	c  = ((a./z.*(h-z)./(h-a)).^p
	I = dz*sum(u.*c);
end

