% Wed 10 May 09:00:09 CEST 2017


mod = {'soulsby', 'brownlie-bonneville', 'brownlie', 'julien', 'rijn'}

tau_c = [];
d = logspace(-1,1);
for idx=1:length(mod)
	theta(:,idx) = critical_shear_stress_ratio(d,mod{idx});
	tau_c(:,idx) = critical_shear_stress(d,mod{idx});
end
figure(1)
clf()
subplot(2,2,1)
semilogx(d,tau_c)

subplot(2,2,2)
plot(d,tau_c)

subplot(2,2,3)
semilogx(d,theta)

subplot(2,2,4)
plot(d,theta)

