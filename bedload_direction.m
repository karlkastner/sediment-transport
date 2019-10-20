% Fri 18 May 18:24:46 CEST 2018
%% bedload transport direction
function [alpha, px, py] = bedload_direction(ub,vb,h,dzb_dx,dzb_dy,C,theta,d_mm)
	% f = 1.7*sqrt(theta);
	d_m = 1e-3*d_mm;
	f = 9*(d_m./h).^0.3.*sqrt(theta);
	
	ubmag     = hypot(ub,vb);
	cos_delta = ub./ubmag;
	sin_delta = vb./ubmag;
	
	% talmon 1995, eq 1
	alpha = atan2( f.*sin_delta - dzb_dy, ...
		       f.*cos_delta - dzb_dx);

	px = cos(alpha);
	py = sin(alpha);
end

