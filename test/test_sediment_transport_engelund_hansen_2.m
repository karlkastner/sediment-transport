% 2016-03-12 16:22:20.996920930 +0100

syms C U H W S d50 Q

qs = engelund_hansen(U,H,W,S,d50)

qs = subs(qs,S,U^2/(C^2*H))
qs = subs(qs,U,Q/(H*W))

