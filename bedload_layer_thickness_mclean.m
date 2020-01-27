% 2020-01-06 20:46:00.826541681 +0800
function dB_mm = bed_load_layer_thickness_mclean(d_mm,Ts)
	d_cm = 10*d_mm;
	A1  = 0.68;
	A2  = (   0.0204*(ln(d_cm)).^2 ...
	        + 0.0220*(ln(d_cm)) ...
		+ 0.0709 );
	dB_mm = d_m*(A1*Ts/(1 + A2*Ts));
end 

