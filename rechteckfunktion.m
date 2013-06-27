function f = rechteckfunktion(breite, azimut, schrittzahl)
z = 0;
for phi = linspace(0,2*pi,schrittzahl)
    z = z+1;
    if phi < azimut-breite/2
        f(z) = 0;
    elseif phi >= azimut-breite/2 & phi <= azimut+breite/2
        f(z) = 1;
    elseif phi > azimut+breite/2 & phi < pi+azimut-breite/2
        f(z) = 0;
    elseif phi >= pi+azimut-breite/2 & phi <= pi+azimut+breite/2
        f(z) = 1;
    elseif phi > pi+azimut+breite/2 & phi < 2*pi+azimut-breite/2
        f(z) = 0;
    elseif phi >= 2*pi+azimut-breite/2 & phi <= 2*pi
        f(z) = 1;
    end
        
end

end