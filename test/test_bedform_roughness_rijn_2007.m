% Fri 20 Mar 19:25:33 +08 2020

d50 = 0.25;
d90 = 0.35;
T_C = 25;

load mat/pyay-discharge-1.mat

psi = mobility_parameter_rijn(tas.u,d50);
rgh_2007 = bedform_roughness_rijn_2007(d50,psi,tas.h);

T = transport_stage_rijn(d50,d90,tas.h,tas.u,T_C);
[h_dune, l_dune] = bedform_dimension_rijn(tas.h,d50,T);
[rgh] = bedform_roughness_rijn(h_dune,l_dune,tas.h);


clf
plot(rgh.ks)
hold on
set(gca,'colororderindex',1)
plot(rgh_2007.ks,'--')

