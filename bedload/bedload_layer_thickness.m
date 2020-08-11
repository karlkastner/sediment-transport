% 2017-05-20 21:57:44.260082682 +0800
% bed load layer thickness
function [delta_B] = bed_layer_thickness(D84,Ts)
	% Wiberg and Rubin [1989
	% delta_B (eq 16 in  Mclean)

	% mm to cm
	D = 10*D84;
	A1 = 0.68;
	A2 = 0.0204*log(D).^2 + 0.022*log(D) + 0.0709
	delta_B = D.*(A1.*Ts)./(1 + A2.*Ts);
end

