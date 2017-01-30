function WtstarFin = snapWtstar2Grid(dxstar,Wtstar)

WtstarFin = round(Wtstar./dxstar) .* dxstar;

end