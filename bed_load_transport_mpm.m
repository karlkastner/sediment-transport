% Mon  5 Aug 14:09:13 CEST 2019
%% bed load transport rate according to meyer-peter-mueller
function [Qs_m,qss] = bed_load_transport_mpm(U,Csf,d_mm,W)
	D = 1e-3*d_mm;
	if (nargin()<4)
		W = 1;
	end
	rhow   = 1e3;
	rhos   = 2650;
	g      = 9.81;
	us     = sqrt(g)./Csf.*U;
	tau    = rhow*us.^2;
	tauc   = 0.047;
	taus   = tau/((rhos-rhow)*g*D);
	qss    = 8*max(0,taus - tauc).^(3/2);
	qs     = qss*D*((rhos-rhow)/rhow*g*D);
	Qs_vol = W*qs;
	Qs_m   = rhos*Qs_vol;
end

