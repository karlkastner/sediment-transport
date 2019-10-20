% Fri  9 Mar 12:10:24 CET 2018

W = 500;
H = 15;
C = 60;
Q = 7000
U = Q/(W*H)
d50_mm = 0.2
lw = adaptation_length_flow(C,H)
ls = adaptation_length_bed(C,W,H,U,d50_mm)
'kapuas'
ls/lw
pause

g = 9.81;
F = U/sqrt(g*H);

% scale
s = 1e-2;
W = s*W;
H = s*H;

% Froude-scaling
U
U = F*sqrt(g*H)
% U = s^(1.5)*U;
% assume an increase in slope by sqrt(s)
%U = s*U;
rho_s = 2650;
% rho_s = 1200;
rho_w = 1e3;



lw = adaptation_length_flow(C,H)
ls = adaptation_length_bed(C,W,H,U,d50_mm,rho_s,rho_w)

ls/lw

syms W H C Q U d50 rho_s rho_w g H 
Delta = (rho_s-rho_w)/rho_w
lw = adaptation_length_flow(C,H)
ls = adaptation_length_bed(C,W,H,U,1e3*d50,rho_s,rho_w)
ls/lw
r1 = simplify((ls/lw),'ignoreanalyticconstraints',true)
r2 = 2* U* g* W^2 / (C^3 * H^2 * (Delta*d50)^0.5)
theta = shields_number(C,U,1e3*d50,rho_s,rho_w)

simplify(r1/r2*1/sqrt(theta),'ignoreanalyticconstraints',true)

