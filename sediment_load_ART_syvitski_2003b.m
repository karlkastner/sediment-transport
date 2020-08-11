% R : highest elevation in catchment
% A : catchment area
% T : temperature
function [Qs_kg_s,Yield_kg_m2_s,Q_m3_s] = sediment_load_syvitsky_2003b(A_m2,R_m,T_C,sector)

tabQ = {
'Sector'        'rivers'                     'a1'    'a2'   'R2'
'Polar'        	34                           0.093, 0.82, 0.89
'Temperate N'   128                          0.039, 0.85, 0.75
'Tropics N' 	53                           0.53,   0.70, 0.76
'Tropics S' 	36                           0.11,   0.74, 0.66
'Temperate S'	NaN			     NaN,    NaN,  NaN;
};
	tabQ = array2table(cell2mat(tabQ(2:end,2:end)),'VariableNames',tabQ(1,2:end),'RowNames',tabQ(2:end,1));

	% note the conversion to km^2
	A_km2 = A_m2 / 1e6;	

	a1 = tabQ.a1(sector);
	a2 = tabQ.a2(sector);
	Q_m3_s  = a1.*A_km2.^a2;

tabQs = { ...
       'Sector'		  'rivers'	'a3'	'a4'   'a5'  'k',  'R2';
       'Polar'	            48          2*10^-5, 0.50, 1.50, +0.10, 0.76;
       'Temperate N'       162         6.1*10-5, 0.55, 1.12, +0.07, 0.63;
       'Tropics N'          62             0.31, 0.40, 0.66, -0.10, 0.58;
       'Tropics S'          42             0.57, 0.50, 0.37, -0.10, 0.67;
       'Temperate S'        26         1.3*10-3, 0.43, 0.96,  0.00, 0.54;
};

	tabQs = array2table(cell2mat(tabQs(2:end,2:end)),'VariableNames',tabQs(1,2:end),'RowNames',tabQs(2:end,1));
	
	a3 = tabQs.a3(sector);
	a4 = tabQs.a4(sector);
	a5 = tabQs.a5(sector);
	k  = tabQs.k(sector);

	% T = T0 + L*H;
	Qs_kg_s = a3.*A_km2.^a4.*R_m.^a5.*exp(k*T_C);

	% per m^2
	Yield_kg_m2_s = Qs_kg_s./A_m2;

end

