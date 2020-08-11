% Wed  1 Apr 17:58:30 +08 2020
function [H_d, L_d] = dune_height_karim(C,u,h,d50_mm,T_C)
	g = Physics.gravity;	
	d50_m = 1e-3*d50_mm;

	us = shear_velocity(u,C);
	ws = settling_velocity(d50_mm,T_C);

	F = u./sqrt(g*h);

	% trainsition regime
	Fl   = 2.716*(h./d50_m).^-0.25;
	Fu   = 4.785*(h./d50_m).^-0.27;
	H_d = h.*( - 0.04 ...
		   + 0.294  *(us./ws) ...
		   + 0.00316*(us./ws).^2 ...
		   - 0.0319 *(us./ws).^3 ...
		   + 0.00272*(us./ws).^4 ...
		);
	fdx = (us./ws) < 0.15 | (us./ws) > 3.64 | F>Fu;
	H_d(fdx) = 0;

	H_d_t = 0.2*h.*(max(Fu-F,0)./(Fu-Fl) );

	fdx = (F>Fl & F<Fu);
	H_d(fdx) = min(H_d(fdx),H_d_t(fdx));
	L_d = 6.25;
end

