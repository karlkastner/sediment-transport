% 2018-08-08 12:27:29.517274033 +0200

syms c(z)  dz(z)
syms ws  clear
syms k clear
syms k  clear
syms z  clear
syms h  clear
syms us clear
syms wbar clear
 
% turbulent viscosity
nut = k*us*z*(1-z/h)

% this actually degenerated to an ode
pde = diff(nut*diff(c,z),z) - ws*diff(c,z)
csol = dsolve(pde)

% with vertical velocity
w    = wbar*z/h;
%w = wbar/h;
pde  = diff(nut*diff(c,z),z) + (-w+ws)*diff(c,z)
csol = dsolve(pde)

% zero order (no verical velocity)
ss = expand(taylor(csol,wbar,0,'order',1))

% no trivial solution with non-zero vertical velocity:
%ss = expand(taylor(csol,wbar,0,'order',2))

% simplified ode, determines dz
pde  = diff(nut*dz,z) + (-w+ws)*dz
dsol = dsolve(pde)
%dsol = expand(taylor(dsol,wbar,0,'order',1))
%sol = int(dsol,z) 
