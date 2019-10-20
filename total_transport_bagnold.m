% Tue  9 May 10:38:37 CEST 2017
% Karl Kastner, Berlin
%% total sediment transport accoding to bagnold
% d : given in mm
function [Qt qt Phi] = total_transport_bagnold(C,d,U,H,W)

	if (nargin() < 5 || isempty(W))
		W = 1;
	end
	if (nargin() < 6 || isempty(rhos))
		rhos = Constant.density.quartz;
	end
	if (nargin() < 7 || isempty(rhow))
		rhow = Constant.density.water;
	end
	g = Constant.gravity;
	s = rhos/rhow;

	% implicit use of bsxfun
	C   = Expanding_Double(C);
	d   = Expanding_Double(d);
	U   = Expanding_Double(U);
	H   = Expanding_Double(H);
	W   = Expanding_Double(W);

	% bed load coefficient
	eB = 0.25;

	% suspended load coefficient
	eS = 0.01;

	% flow velocity
	%U = (Qw./(H.*W));

	% shear stress
	% tau = rhow*g./C.^2.*U.^2;
	tau = btimes(rhow*g./C.^2,U.^2);

	% stream power per unit width
	omega = tau.*U;

	% settling velocity
	ws = settling_velocity(d);

	if (0)
		% proportionality coefficient for graded sediment
		% K = 1.8*sqrt(D_mu/250) = 1.8*sqrt(4*D_mm) = 3.6*sqrt(D_mm)
		K     = 3.6*sqrt(D_mm);
		K     = 0.69*exp(0.005*(tau0/tauc -1));
		Omega = rho*us^3; % this ignores C
		qs    = rw/(rs - rw) * 1/g * K*Omega;
	end

	% total mass transport per unit width
	% julien, 11.8
	% qt = 1/g*1/(rhos/rhow-1)*omega.*(eB + eS*abs(U)./ws);
	qt = 1/g*1/(s-1)*omega.*(eB + eS*btimes(abs(U),1./ws));

	% volumetric transport
	qt_v = (1./rhos).*qt;
	
	% mm to m
	d    = 1e-3*d;

	% transport capacity
	% Phi  = qt_v./sqrt(g*(s-1.0)*d.^3);
	Phi  = btimes(qt_v,1./sqrt(g*(s-1.0)*d.^3));

	% total mass transport through cross section
	Qt = W.*qt;
end % sediment_transport_bagnold

