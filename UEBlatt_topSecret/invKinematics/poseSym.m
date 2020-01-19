function H = poseSym(dhP,ref,coord)

H = sym(eye(4,4));

for i=ref:coord
    
    A = singleTransf(dhP(i,:));
    
    H = H*A;
    
end