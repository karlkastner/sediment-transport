syms Qb_ n U S Q W C d_mm W;
syms Q(t) rho_s rho_w
syms Delta rho_w positive
rho_s = rho_w + Delta;
%syms Qs_


H  = normal_flow_depth(Q,W,n,S,1);
C  = manning2chezy(n,H);
U  = normal_flow_velocity(Q,W,n,S,1);


if (0)
	Qb= bed_load_transport_mpm(U,C,d_mm,W); Qb, solve(Qb_-Qb,Q)
end

Qs = total_transport_engelund_hansen(C,d_mm,U,H,W)



syms Q_f positive
H_f  = normal_flow_depth(Q_f,W,n,S,1);
C_f  = manning2chezy(n,H_f);
U_f  = normal_flow_velocity(Q_f,W,n,S,1);
Qs_f = total_transport_engelund_hansen(C_f,d_mm,U_f,H_f,W)

Qs   =  simplify(Qs,'ignoreanalyticconstraints',true);
Qs_f =  simplify(Qs_f,'ignoreanalyticconstraints',true);

%eq = 1-Qs/Qs_f
eq = Qs-Qs_f
eq = simplify(eq)

Q_   = solve(eq,Q_f)

