% Mo 4. Jan 11:45:52 CET 2016
% Karl Kastner, Berlin
function obj = assign_channel(obj)
	n0 = min(obj.index);
	n = max(obj.index);
	C = {  1,   n, 1, 'Besar',
             134, 155, 2, 'Kecil',
             191, 258, 2, 'Kecil',
	     156, 185, 3, 'Kubu',
	     400, 411, 3, 'Kubu',
	     481, 492, 4, 'Mendawat',
	     232, 237, 5, 'Landak',
             477, 480, 6, 'Duplictes',
             n0,    0, 6, 'Duplicates'};
	obj.channel.id = zeros(length(obj.index),1);
	obj.channel.name = {};
	for idx=1:size(C,1)
		fdx = obj.index >= C{idx,1} & obj.index <= C{idx,2};
		obj.channel.id(fdx)   = C{idx,3};
		obj.channel.name(fdx) = C(idx,4);
	end

	% split besar in sections
%	C = { 122,   n, 4, 'Besar 4',
%	        1,  76, 1, 'Besar 1',
%               77, 121, 2, 'Besar 2',
%	      122, 133, 3, 'Besar 3',
%	      412, 431, 3, 'Besar 3',
%	      453, 476, 3, 'Besar 3',
%              134, 155, 5, 'K. Kecil',
%              191, 258, 5, 'K. Kecil',
%	      156, 185, 6, 'Kubu',
%	      400, 411, 6, 'Kubu',
%	      481, 492, 7, 'Mendawat',
%              232, 237, 8, 'Landak',
%              477, 480, 9, 'Duplictes',
%	      n0,  0,   9, 'Duplicates'};
%	obj.channel.id2 = zeros(length(obj.index),1);
%	obj.channel.name2 = {};
%	for idx=1:size(C,1)
%		fdx = obj.index >= C{idx,1} & obj.index <= C{idx,2};
%		obj.channel.id2(fdx)   = C{idx,3};
%		obj.channel.name2(fdx) = C(idx,4);
%	end
end

