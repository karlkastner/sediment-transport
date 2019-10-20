% Wed  7 Mar 19:51:39 CET 2018
%% phase diagram
function [hc, wc, obj]    = phase_diagram(obj,T,Amax,n,borderonly,scale)
	l = linspace(1,n,n)/n;
	Ai(:,1) = l*Amax(1);
	Ai(:,2) = l*Amax(2);
	hc = [];
	wc = [];
	for idx=1:length(Ai)
	 for jdx=1:length(Ai)
		if (~borderonly ...
		|| (idx == 1 || jdx == 1 ...
		|| idx == length(Ai) || jdx == length(Ai)) )
			[h,w]   = obj.geometry([Ai(idx,1),Ai(jdx,2)]);
			[t,h,w] = obj.solve(T,h,w);
			%[h,w] = obj.geometry(A);
			plot(scale*h(:,1),scale*h(:,2),'k');
			hold on
			plot(scale*h(end,1),scale*h(end,2),'or','markerfacecolor','r');
			hc(end+1,:) = h(end,:);
			wc(end+1,:) = w(end,:);
		end
	 end
	end
	hc_ = round(hc,3);
	[hc_,id] = unique(hc_,'rows');
	hc = hc(id,:);
	wc = wc(id,:);
end

