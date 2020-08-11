% Fri 27 Mar 15:24:39 +08 2020

clear Qs
figure(1)
clf();
for idx=1:2
% river
if (1==idx)
C = 60;
d_mm = 0.25;
%U = linspace(1,2,2);
H = 10;
W = 1;
T_C = 20;

S = linspace(0,1e-4);
U = C*sqrt(H*S);
x = U;
else
U = 1;
d_mm = logspace(log10(0.065),2);
x=d_mm;

if (0)
% flume
C = 13;
H = 0.2;
S = linspace(0,1e-3);
U = C.*sqrt(H.*S);
end
end
Qs = [];
d90 = 1.5*d_mm;
Qs(:,1) = total_transport_engelund_hansen(C,d_mm,U,H,W);
Qs(:,2) = total_transport_yang(C,d_mm,U,H,W,T_C);
%function Qs = total_transport_aw(C,U,H,W,T_C)
Qs(:,3) = total_transport_aw(C,d_mm,U,H,W,T_C);
%Qs(:,3) = total_transport_yang(C,d_mm,U,H,W,T_C,true);
%C=60; U=1; d_mm= 0.25; W =1; T_C = 25;
if (0)
Qs(:,4) = total_transport_wu(C,d_mm,U,H,W,T_C);
%Qs(:,3) = suspended_transport_wu(C,d_mm,U,W,T_C);
%Qs(:,4) = bed_load_transport_wu(C,d_mm,U,H,W,T_C);
Csf = [];
Qs(:,5) = bed_load_transport_mpm(U,Csf,d_mm,W,[],H);
end

subplot(2,2,1+2*(idx-1))
loglog(x,Qs);

%subplot(2,2,2)
subplot(2,2,2+2*(idx-1))
rat_ = Qs(:,2)./Qs(:,1);
plot(x,rat_);

end
