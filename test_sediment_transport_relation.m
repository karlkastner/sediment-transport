
d_mm = 0.53;
S    = 1e-4;
W    = 1e3;
n    = 0.025;
Q    = linspace(2.3e3,3.3e4,10)';

U    = normal_flow_velocity(Q,W,n,S,true)
H    = normal_flow_depth(Q,W,n,S,true)
C    = manning2chezy(n,H)
pause

Qs   = total_transport_engelund_hansen(C,d_mm,U,H,W);

[rc,p] = sediment_transport_relation_fit(Qs,Q,W,n,S,d_mm);
p(1)
p(2)

Qs(:,2) = sediment_transport_relation_predict(Q,W,n,S,rc,d_mm)

