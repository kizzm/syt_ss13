function rect = frect(x,breit,pos)
 
if and(x > (pos-breit/2),x<(pos+breit/2))
    rect = 1;
%elseif and(x > (pos-pi-breit/2),x<(pos-pi+breit/2))
%    rect = 1;
%elseif and(x > (pos+pi-breit/2),x<(pos+pi+breit/2))
%    rect = 1;    
else
    rect = 0;
end

end