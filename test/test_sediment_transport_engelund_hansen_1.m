% Sun 29 Jan 18:08:42 CET 2017
%
% Note that several authors do not state the mass or volumetric flux,
% but the weight flux
%
% engelund hansen: volume flux
% vanoni:  weight flux
% wu-2007: weight flux
% Wu, Computational River Dynamics
% also deltares notes
% Julien, p. 274

format compact

g=9.81;
rhow = 1000;
%s=rhos/rhow;

tset = 3;
switch tset
case {1}
	C = 1; % ok
	W = 1; %
	H = 1; % ok
	d = 1; % ok
	S = 1; % ok %2^(2/5);
	s = 2
case {2}
	H = 1.219 
	S = 2.17e-4
	s = 2.68
case {3}
	% 4-13 from transmission of sediment
	W = 1
	H = 0.3048
	f = 0.0124
	C = sqrt(2*g/f)
	d_mm = 0.32
	s = 2.68
	S = 0.002
case {4}
	H = 3.05
	U = 0.97
	us = 0.078
	S = us^2/(g*H)
	C = U/sqrt(H*S)
	d_mm = 0.333
	s = 2.68
	W = 1
	%Rh = 2.9
case {5}
	H = 10*1.22
	U = 0.61
	us = 0.05
	S = us^2/(g*H)
	C = U/sqrt(H*S)
	d_mm = 0.333
	s = 2.65
	W = 1
case {6}
Q = 5
S = 0.001
d_mm = 8
H = 0.9
W = 7.1


end
U = C*sqrt(H*S)

rhos = s*rhow;
d_m = d_mm/1e3;

%f = (2*g*S*H)/U^2	% 3.6.5 in eh
%theta = H*S/((s-1)*d)   % p.6 
	%Qs_eh = sediment_transport_engelund_hansen(C,d_mm,U,W,rhos,rhow)
%function [Qs qs_w] = sediment_transport_engelund_hansen(C,d_mm,Qw,H,W,rhos,rhow)
Q=U*W*H;
Qs_eh = sediment_transport_engelund_hansen(C,d_mm,Q,H,W,rhos,rhow)

if (1)
% julien has a problem with H and d and S
% disp('Julien');
% eq. 11.9 in julien
cw = 0.05*(s/(s-1))*U*S/sqrt((s-1)*g*d_m)*H*S/((s-1)*d_m);
%cv = cw*(-(s-1)*cw+s)
c_ppm = 10^6*cw
c_m = s*c_ppm*(s+1e-6*(1-s)*c_ppm) * 1e-3
%ms = rhow*cw/(1-cw)
%ms = rhow*cw/(1-cw)*(1+rhow/rhos*cw/(1-cw))^-1
%ms = rhos*cv
Qs_julien = W*H*U*c_m
end

%disp('Ponce');
% ponce (web)
gammas = rhos*g;
gammaw = rhow*g;
s = gammas/gammaw;
theta = H*S/((s-1)*d_m)
f = (2*g*S*H)/U^2;
phie = 0.1*1/f*theta^(5/2);
% rhos not gammaw, according to 'transmission by sediment'
%qs = phie*gammaw*sqrt((s-1)*g*d^3);
qs_v = phie*sqrt((s-1)*g*d_m^3);
%qs_m = rhos*qs_v;
qs_m = gammas*qs_v;
Qs_ponce = W*qs_m

if (1)
% vanoni seems to make the same mistake as ponce - taking gamma instead of rho
taub = rhow*g*H*S
pause
fe   = 2*g*H*S/U^2;              %2.234b
taus = taub/((gammas-gammaw)*d_m); % 2.234b
phie = 0.1/fe*taus^(5/2);        %2.234a
qs = phie*gammas*sqrt((gammas/gammaw-1)*g*d_m^3);
Qs_vanoni = W*qs
%0.05*gammas*U^2*sqrt(d/(g*(gammas/gammaw-1)))*(taub/((gammas-gammaw)*d))^(3/2)
end

% Computational River Dynamics, weiming wu
if (1)
%disp('Wu')
%us = sqrt(g)/C*U
%tau = rhow*us^2
gammas = rhos*g;
gammaw = rhow*g;
taub = gammaw*H*S;
theta = taub/((gammas-gammaw)*d_m);
f = 2*g*H*S/U^2;
phi = 0.1/f*theta^(5/2);
Qs_wu = W*phi*(gammas*sqrt( (gammas/gammaw-1)*g*d_m^3 ) )
end

% why does the manual say q is a velocity?
%Qs_dfm = 0.05*(U)^(5/2)/(sqrt(g)*C^3*(s-1)^2*d_m)
% eq 17.89
q_v = 0.05*U^5/(sqrt(g)*C^3*(s-1)^2*d_m)
q_m = rhos*q_v
Qs_dfm = W*q_m
pause

'eh/julien'
Qs_eh/Qs_julien
'eh/vanoni'
Qs_eh/Qs_vanoni
'eh_ponce'
Qs_eh/Qs_ponce
'eh/wu'
Qs_eh/Qs_wu
%'dfm'
%Qs_eh/Qs_dfm


