% 2017-05-09 15:25:33.925910782 +0200
% 2015-09-25 18:35:43.016668676 +0200

if (0)

	d = 10;
	b = 100;
	D_50 = 1e-3;
	D_90 = 1e-3;

	U = linspace(0,3,100)';
	
	[Q_b q_b] = bed_load_transport(d,b,D_50,D_90,U);
	plot(U,q_b)
	plot(U,[q_b./q_b(end) (U./U(end)).^4])
end
	

C = 57;
W = 500;
Qw = linspace(1e3,1e4,10);
d = 1; % mm
S = 5e-5;
% uniform flow
H = (Qw.^2/(W^2*C^2*S)).^(1/3);
U = C*sqrt(H*S);

[Qs qs] = sediment_transport_bagnold(C,d,Qw,H,W)

figure(1)
clf
subplot(2,2,1)
plot(Qw,H)
subplot(2,2,2)
plot(Qw,U);
subplot(2,2,3)
plot(Qw,Qs)
subplot(2,2,4)
C = Qs./Qw;
plot(Qw,C)


g = 9.81;

sediment_transport_benchmark()

for idx=1:length(ex)
figure(idx+1)
clf
H = ex(idx).H;
Qw = ex(idx).Qw;
us = ex(idx).us;
W = 1;
U = Qw/(H*W);
C = sqrt(g)*U/us
S = (U/(C*sqrt(H)))^2;
d = ex(idx).d;

Cs_b = ex(idx).C_b;
[Qs qs] = sediment_transport_bagnold(C,d,Qw,H,W);
Cs_b(:,2) = Qs./Qw % kg/m^3

Cs_eh   = ex(idx).C_eh;
[Qs qs] = sediment_transport_engelund_hansen(C,d,Qw,H,W);
Cs_eh(:,2) = Qs./Qw % kg/m^3

%[Q_b q_b] = bed_load_transport(d,b,D_50,D_90,U);

% TODO to ppm
loglog(d,[Cs_b Cs_eh])

% example ti

end

