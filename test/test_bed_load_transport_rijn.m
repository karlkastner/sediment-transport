tau = 5; % N/m^2
% bed form factor 
mu = 0.5
d50_m = 1e-6*[600 700 800 900 1000]
d50_mm = 1e3*d50_m

dimensionless_grain_size(d50_mm)/1e3

% dummy
%us = 1;
%C  = 

%Ct = grain_chezy_rijn(R,d90)
%C = Ct*sqrt(t)



%H = 

d90_mm = d50_mm;
U=1;
H=1;
W=1e3;
bed_load_transport_rijn(C,d50_mm,d90_mm,U,H,W)


