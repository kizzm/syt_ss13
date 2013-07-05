function glatt = gkern(x)
 
if abs(x) < 1
    glatt = exp(-1/(1-x^2));
else
    glatt = 0;
end
  
end