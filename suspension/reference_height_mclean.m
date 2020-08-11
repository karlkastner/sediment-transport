% 2017-05-20 18:10:42.399224785 +0200
% 2019-05-12 17:28:31.562709808 +0800
function a_m = reference_level_mclean(d84_mm,Ts)
	% bed load layer thickness
	% it is unclear, that this is here really d84 and not d50
	% p 5767 
	delta_B_mm = bedload_layer_thickness_mclean(d84_mm,Ts);

	% reference level for concentration
	a_m   = 1e-3*delta_B_mm;
end

