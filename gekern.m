function glatt = gekern(x,e,c)
xe = x/e;

if abs(xe) < 1
    glatt = c*exp(-1/(1-xe^2));
else
    glatt = 0;
end

glatt = 1/e * glatt;

end