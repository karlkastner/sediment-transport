 syms Q h; h=Q.^(2/3); u=h.^(1/2); Qs = u.^5, syms h; h = solve(Q-h^(3/2+1/6),h); h=h(1); u = h.^(1/2+1/6);Qs=u.^5

