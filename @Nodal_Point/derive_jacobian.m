% Wed  7 Mar 20:04:59 CET 2018
%% derive Jacobian of the nodal point relation
function [J, g] = derive_jacobian(obj)
	syms L1 L2 C1 C2 w1 w2 Q0 h1 h2 n m Qs0 k C0 L h w J A1 A2 A aw pw ah ph
	if (~obj.wfixed)
		hg.pw = pw;
		hg.ph = ph;
		hg.aw = aw;
		hg.ah = ah;
		obj.hg = hg;
	end
	C1 = C0;C2 = C0;
	L1 = L;L2 = L;


	obj.C  = [C1,C2];
	obj.L  = [L1,L2];
	obj.n  = n;
	obj.k  = k;
	obj.m  = m;
	obj.Qs0 = Qs0;
	obj.Q0 = Q0;
	h      = [h1,h2];
	w      = [w1,w2];
	obj.w  = w;
	A    = [A1, A2];

	g = obj.Adot([],A);
	for idx=1:length(g)
		for jdx=1:length(g)
			J(idx,jdx) = diff(g(idx),A(jdx));
			%J(idx,jdx) = diff(Adot(idx),h1); %A(jdx));
		end
	end
	g = simplify(g,'ignoreanalyticconstraints',true);
	J = simplify(J,'ignoreanalyticconstraints',true);
end

