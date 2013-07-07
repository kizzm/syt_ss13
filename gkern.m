function glatt = gkern(x,c)
 
if abs(x) < 1
    glatt = c*exp(-1/(1-x^2));
else
    glatt = 0;
end

end