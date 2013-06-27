function G = gausarray(schrittzahl,sig)
 
x=linspace(floor(-3*sig),ceil(3*sig),schrittzahl); 
G=exp(-0.5*x.^2/sig^2); 
%G=G/sum(G);

end