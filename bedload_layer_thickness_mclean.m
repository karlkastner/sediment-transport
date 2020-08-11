% 2020-01-06 20:46:00.826541681 +0800
function dB_mm = bed_load_layer_thickness_mclean(d_mm,Ts)
	d_cm = 10*d_mm;
	A1  = 0.68;
	% note: mclean explicitely notes ln, i.e. the natural logarithm
	A2  = (   0.0204*(log(d_cm)).^2 ...
	        + 0.0220*(log(d_cm)) ...
		+ 0.0709 );
	% it is not directly clear from McLean, that
	% A2 is evaluated with dcm, but dB_mm scaled by d_mm,
	% but this seesm to be the case when having a closer look at
	% mcleans reference wiberg and rubin
	dB_mm = d_mm.*(A1*Ts./(1 + A2*Ts));
end 

