% Mon 19 Mar 15:34:25 CET 2018
% Karl Kastner, Berlin
%% bar mode of a river according to crosato
% crosato 2009
function [m,b,mu] = bar_mode_crosato(Q,w,h,C,d50_mm,d90_mm,b)
	g     = Constant.gravity;
	rho_s = Constant.density.quartz;
	rho_w = Constant.density.water;
	d50_m = 1e-3*d50_mm;
	d90_m = 1e-3*d90_mm;
	mu    = [];

	U       = Q./(w.*h);
	S       = U.^2./(C.^2.*h);
	theta0  = (U.^2./(C.^2.*(rho_s./rho_w-1).*d50_m));

%	b = 5; % eh, crossato used 4 for sand and 10 for gravel
%	b = 4;
	beta    = w./h;
	if (nargin()<7 || isempty(b))
		C90 = 18*log10(12*h./d90_m);
		mu  = (C./C90).^(3/2);
		b   = 3*mu.*theta0./(mu.*theta0-0.047);
	end
	f_theta = 1.7*sqrt(theta0);
	C_f     = g./C.^2;
	if (0)
		% eq 18
		m       = beta./pi.*sqrt((b - 3).*f_theta.*C_f);
	else
		% eq 19, gives identical results
		m = sqrt(    (0.17*g.*(b-3).*w.^3.*S) ...
        	           ./ (sqrt((rho_s/rho_w-1).*d50_m).*C.*Q) ...
                	);
	end
end % bar_mode_crosato

	 
 
