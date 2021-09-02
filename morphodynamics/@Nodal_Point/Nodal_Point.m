% Wed  7 Mar 18:38:57 CET 2018
%% Nodal point relation for bifurcations, according to Wang
% TODO make bed level a variable, not depth
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
classdef Nodal_Point < handle
	properties
		% discharge in
		Q0
		% sediment infliw
		Qs0
		% channel width
		w
		% channel length
		L
		% chezy coefficient
		C
		% power of nodal point relation
		k
		% power and scale variables of the hydraulic geometry relationship
		hg = struct('pw',[],'ph',[],'aw',[],'ah',[]);
		wfixed      = true;
		widechannel = true;
		kfixed      = true;
		transport = struct('relation','power' ...
				   ... % scalar in sediment transport power law
				   ,'m',1 ...
				   ... % power in sediment transport power law
				   ,'n',5);
		packing_density = 0.65;
	end
	methods
		function obj = Nodal_Point()
		end

		function symvars(obj)
			syms L_1 L_2 C_1 C_2 k m w_1 w_2 Q_0 Qs_0 m n positive
			obj.C   = [C_1;C_2];
			obj.L   = [L_1;L_2];
			obj.Q0  = Q_0;
			obj.Qs0 = Qs_0;
			obj.k   = k;
			obj.m   = m;
			obj.n   = n;
			obj.w   = [w_1;w_2];
		end % symvars

	end % methods	
end % class Nodal_Point

