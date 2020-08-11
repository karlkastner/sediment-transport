a = 1
delta = 1.65;

u = 2;
d50_mm = 1;
d90_mm = 10;
C = 60;
H = 12;

w = 1;
g = 9.81

d50_m = 1e-3*d50_mm;

% !
mu = 1;
theta_cr = 0.047;
e = 1;

theta = (u/C)^2*1/(delta*d50_m);

Sb = 8*a*d50_m*sqrt(delta*g*d50_m)*(mu*theta - e*theta_cr)^(3/2)

Sb(2) = 1/2650*bed_load_transport_mpm(u,C,d50_mm,w)
Sb(3) = 1/2650*bed_load_transport_mpm(u,C,d50_mm,w,d50_mm,H)
Sb(4) = 1/2650*bed_load_transport_mpm(u,C,d50_mm,w,d90_mm,H)
