% Mon 30 Mar 14:28:20 +08 2020
function z0_T = total_roughness_length_mclean(dune_h,dune_l,z0_f,z_m)
	tr    = shear_stress_ratio_mclean(dune_h,dune_l,z0_f);
	z0_T  = z_m.*(z_m./z0_f).^sqrt(1./tr);
end

