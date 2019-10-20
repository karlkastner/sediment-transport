% Fri 18 May 18:39:51 CEST 2018
%% directed sediment transport
function [qsx,qsy] = sediment_tranport_directed(u,v,ub,vb,h,dzb_dx,dzb_dy,C,d_mm)
	umag = hypot(u,v);
	theta = shields_number(C,umag,d_mm);
	%qs    = a*u.^p;

	% per unit width
	W  = 1;
	qs = total_transport_engelund_hansen(C,d_mm,umag,h,W); %,rhos,rhow)
	qs = double(qs);
	[alpha, px, py] = bedload_direction(ub,vb,h,dzb_dx,dzb_dy,C,theta,d_mm);
	
	qsx = px.*qs;
	qsy = py.*qs;
end

