% 2017-05-17 16:19:02.948838323 +0200

n = 3;
n = 4;
m = 1e3;

% error in z
h = 10;

dz = h/(n+1)
%ez = 2*2.^(-2:0);

ez = 2*[0.25 0.5 1];
es = 0.*[0.25 0.5 1];
c = [1 1]';
%c = [1 0.5]';
rp = Rouse_Profile();
rp.nlflag = false;

z = h-dz*(1:n)';
Ro =[];
for idx=1:length(ez)


ssc = rp.predict(z,h,c);

% perturb z
Z = z*ones(1,m) + ez(idx)*rand(n,m);
H = h*ones(1,m);
ssc=ssc*ones(1,m);

[p q] = logn_mode2param(ssc,es(idx)*ssc);
%for jdx=1:prod(size(ssc))
%ssc(jdx) = lognpdf(p(jdx),q(jdx));
%end
ssc = lognrnd(p,q);

mask = true(size(ssc));
%mask(end,:) = false;
cc   = rp.fit(ssc,Z,H,mask);

Ro(:,idx) = cc(2,:);
end
figure(1);
Ro = real(Ro);
x = linspace(0,2,round(sqrt(m/4)));
hist(Ro,x)
'bias'
mean(Ro)-c(2)
'rms'
rms(Ro-c(2))

