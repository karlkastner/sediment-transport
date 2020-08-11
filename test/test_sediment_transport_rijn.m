u = 2  % m/2
h = 10 % m
%d50_mm = 1;
%d90_mm = 10;
d50_mm = 0.4;
d90_mm = 0.6;
w = 1;

theta_cr = critical_shear_stress_ratio(d50_mm);

d50_m = 1e-3*d50_mm;
d90_m = 1e-3*d90_mm;
rhow  = 1000;
rhos  = 2650;
g     = 9.81;
a1    = 1; 
ec    = 0.5; %0.01*h; % TODO !!! 
dh = 2*ec;
kappa = 0.41;
nu = 1e-6;
sd = 1;
sd = [];
w  = [];

Delta = (rhos-rhow)/rhow;
% THIS is misleading q is velocity in delft3d documentation !
q    = u;

Ds   = d50_m*(Delta*g/nu^2)^(1/3);
fcb  = 0.24/(log10(12*h/ec))^2;
us   = q*sqrt(fcb/8);
tbc  = 1/8*rhow*fcb*q^2;
tbcr = rhow*Delta*g*d50_m*theta_cr;
Cg90 = 18*log10(12*h/(3*d90_m)); 
muc  = (18*log10(12*h/ec)/Cg90)^2
T = (muc*tbc - tbcr)/(tbcr)
T_ = transport_stage_rijn(d50_mm,d90_mm,h,u)


ws  = settling_velocity(d50_mm);
beta = min(1.5,1+2*(ws/us)^2);
us = q*sqrt(fcb/8);
Ca = 0.015*a1*d50_m/ec*T^1.5/Ds^0.3;

Ca_ = [Ca, reference_concentration_rijn(d50_mm,ec,T_)]
pause

phi = 2.5*(ws/us)^0.8*(Ca/0.065)^0.4;
zc = min(20,ws/(beta*kappa*us)+phi)
% todo 1.2
fcs = ((ec/h)^zc - (ec/h)^1.2)/((1-ec/h)^zc*(1.2-zc))
pause

if (T<3)
	Sb = 0.053*sqrt(Delta*g*d50_m^3)*Ds^-0.3*T^2.1
else
	Sb = 0.1*sqrt(Delta*g*d50_m^3)*Ds^-0.3*T^1.5

end
[fcs q h Ca*1e4]
Ss  = fcs*q*h*Ca

C = sqrt(8*g/fcb)
Sb(2) = 1/rhos*double(bed_load_transport_rijn(C,d50_mm,d90_mm,u,h,w))
Ss(2) = 1/rhos*double(suspended_transport_rijn(C,d50_mm,d90_mm,1,u,h,w,dh)) %,dune_height)

