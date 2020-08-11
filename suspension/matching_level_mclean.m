% Mon 30 Mar 12:59:54 +08 2020
function z_m = matching_level_mclean(dune_l,z0_f)
	a1   = 0.1;
	% note, in 1977 a1 = 0.3 - 0.5 for elliots theory,
	% but in practice lower, table in 1977 paper has 0.0995
	z_m  = z0_f.*a1.*(dune_l./z0_f).^0.8;
end

