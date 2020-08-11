% Tue 31 Mar 16:47:13 +08 2020

S   = 8e-5;
W   = 1e3;
T_C = 25;
d50_mm = 0.25;
d90_mm = 1.5*0.25;
%d90_mm = d50_mm;
sd_2 = [];
d_mm = [];

h = linspace(1,40,100)';

Qs = [];
Q = [];
Cz = [];
u = [];
for idx=1:length(h);

profile = 'log';
%[Q(:,1),Cz(:,1),u(:,1)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,profile,'rijn')
%[Q(:,2),Cz(:,2),u(:,2)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,profile,'wright-parker-2003')
[Q(:,1),Cz(:,1),u(:,2)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,profile,'engelund-hansen-1967');
%[Q(:,4),Cz(:,4),u(:,4)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,profile,'eh-wp')
[Q(:,2),Cz(:,2),u(:,2)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,profile,'karim');
if(0)
[Q(:,5),Cz(:,5),u(:,5)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,'power','rijn')
[Q(:,6),Cz(:,6),u(:,6)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,'power','wright-parker-2003')
[Q(:,7),Cz(:,7),u(:,7)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,'power','fredsoe')
[Q(:,8),Cz(:,8),u(:,8)] = stage_discharge(h,W,S,d50_mm,d90_mm,T_C,'power','engelund-hansen-1967')
end
end
u = Q./(W.*h);
Qs(:,1) = total_transport_engelund_hansen(Cz(:,1),d50_mm,u(:,1),h,W);
Qs(:,2) = total_transport_karim(Cz(:,2),u(:,2),h,W,d50_mm,T_C);
%*365.25*86400/1e9
%Qs(:,2) = suspended_transport_wright_parker(Cz,u,h,W,d50_mm,d90_mm,sd_2,d_mm,T_C);

figure(1);
clf();
subplot(2,2,1);
plot(h,Q);
%legend('rijn','wp','fr','eh');

subplot(2,2,2);
plot(h,Qs);

subplot(2,2,3)
plot(Q,Qs)

subplot(2,2,4)
loglog(Q,Qs)

