% Tue  9 May 10:38:37 CEST 2017
% Karl Kastner, Berlin
%% total sediment transport accoding to bagnold
% d : given in mm
function [Qt, Qb, Qs, qt, Phi] = total_transport_bagnold(C,d_mm,U,H,W,T_C)

	if (nargin() < 5 || isempty(W))
		W = 1;
	end
	if (~issym(C))
	%if (nargin() < 6 || isempty(rho_s))
		rho_s = Constant.density.quartz;
	%end
	%if (nargin() < 7 || isempty(rho_w))
		rho_w = Constant.density.water;
	%end
		g = Constant.gravity;
	else
		syms rho_s rho_w
		syms g
	end
	% s = rho_s/rho_w;
	% mm to m
	d_m    = 1e-3*d_mm;

	% implicit use of bsxfun
%	C   = Expanding_Double(C);
%	d   = Expanding_Double(d);
%	U   = Expanding_Double(U);
%	H   = Expanding_Double(H);
%	W   = Expanding_Double(W);

	if (~issym(C))
	% bed load efficiency (eB<1)
	% bagnold 1966, p 18
	% note julien has eB = 0.25 in julien, as he doesn not explicitely
	% diveds by the tangens of the angle of repose
	eB = 0.13;

	% suspended load coefficient
	% bagnold 1966, p I14,
	% note julien has eS = 0.01, as he does not factor in (1-eB) ~ 0.87
	eS = 0.015;
	mode = [];
	else
		syms eB eS
		mode = 'sym';
	end

	% flow velocity
	%U = (Qw./(H.*W));

	% shear stress
	% tau = rho_w*g./C.^2.*U.^2;
	%tau = btimes(rho_w*g./C.^2,U.^2);
	%tau = rho_w*g./C.^2.*U.^2;
	us=shear_velocity(U,C);
	tau = rho_w*us.^2;

	% stream power per unit width
	omega = tau.*U;

	% settling velocity
	ws = settling_velocity(d_mm,T_C,mode);

	if (0)
		% proportionality coefficient for graded sediment
		% K = 1.8*sqrt(D_mu/250) = 1.8*sqrt(4*D_mm) = 3.6*sqrt(D_mm)
		K     = 3.6*sqrt(D_mm);
		K     = 0.69*exp(0.005*(tau0/tauc -1));
		omega = tau*U;
		qs    = 1/g*rho_w/(rho_s - rho_w)*K*Omega;
	end

	% total mass transport per unit width
	% julien, 11.8
	% qt = 1/g*1/(rho_s/rho_w-1)*omega.*(eB + eS*abs(U)./ws);
	% bagnold 1966, p. eq 7, p 16
	a = angle_of_repose();
	% qb ~ U^3
	qb = 1./g.*(rho_s./(rho_s-rho_w)).*omega.*(eB/tan(a));
	% qs ~ U^4
	qs = 1./g.*(rho_s./(rho_s-rho_w)).*omega.*(eS*(1-eB)*abs(U)./ws);
	%qt = 1/g*1/(s-1)*omega.*(eB + eS*btimes(abs(U),1./ws));

	% volumetric transport
	%qb_v = (1./rho_s).*qb;
	qb_v = qb;
	qs_v = qs;

	% transport capacity
	% Phi  = qt_v./sqrt(g*(s-1.0)*d.^3);
	%Phi  = qt_v./sqrt(g*(s-1.0)*d_m.^3);
	Phi_b  = qb_v./sediment_transport_scale(d_mm);
	Phi_s  = qs_v./sediment_transport_scale(d_mm);
	%Phi  = btimes(qt_v,1./sqrt(g*(s-1.0)*d.^3));

	% total mass transport through cross section
	Qb = W.*qb;
	Qs = W.*qs;
	Qt = Qb+Qs;
end % sediment_transport_bagnold

