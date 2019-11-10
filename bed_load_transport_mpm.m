% Mon  5 Aug 14:09:13 CEST 2019
%% bed load transport rate according to meyer-peter-mueller
% function [Qs_m,qss] = bed_load_transport_mpm(U,Csf,d_mm,W)
function [Qs_m,qss] = bed_load_transport_mpm(U,Csf,d_mm,W)
	D = 1e-3*d_mm;
	if (nargin()<4)
		W = 1;
	end
	rhow   = Constant.density.water;
	rhos   = Constant.density.quartz;
	g      = Constant.gravity;
	%us     = sqrt(g)./Csf.*U;
	%tau    = rhow*us.^2;
	tauc   = 0.047;
	%taus   = tau/((rhos-rhow)*g*D)
	taus  = shields_number(Csf,U,d_mm); %,rhos,rhow)
	qss    = 8*max(0,taus - tauc).^(3/2);
	% sqrt was missing
	qs     = qss*D*sqrt((rhos-rhow)/rhow*g*D);
	Qs_vol = W*qs;
	Qs_m   = rhos*Qs_vol;
end

