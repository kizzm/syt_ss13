function rect = frect(x,breit,pos)

while abs(x)/(pi/2) > 1
    x = x - sign(x)*pi;
end
 
if and(x > (pos-breit/2),x<(pos+breit/2))
    rect = 1;   
else
    rect = 0;
end

end