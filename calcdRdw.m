% setting up the Jacobian matrix using small perturbations
function dRdw = calcdRdw(dx,D,H,ind,w,R)

dRdw = sparse(length(w),1);
startindex = ind - 2;
endindex = ind + 2;
thisR = R(ind);
inf_w = sqrt(eps);    

for i = startindex:endindex   
    wcopy = w;    
    if (i >= 1) && (i <= length(w))       
        wcopy(i) = wcopy(i) + inf_w;       
        if startindex < 1            
            thisw = wcopy(1:endindex);       
            thisw = [thisw(5-length(thisw)+1:-1:2,1);thisw];                        
        elseif endindex > length(w)            
            thisw = wcopy(startindex:end);
            thisw = [thisw;zeros((5-length(thisw)),1)];           
        else            
            thisw = wcopy(startindex:endindex);            
        end
        
        if (ind-1) < 1          
            DVec = [D(2);D(1);D(2)];            
        elseif (ind+1) > length(w)                
            DVec = [D(end-1);D(end);D(end)];            
        else            
            DVec = D(ind-1:ind+1);            
        end
        
        Rdiff = calcR_kernel(dx,DVec,H(ind),thisw);                
        dRdw(i,1) = (Rdiff - thisR)./inf_w;            
    end    
end

function R = calcR_kernel(dx,DVec,H,w)
d2wdx2 = (w(3:end) - 2.*w(2:end-1) + w(1:end-2))./dx.^2;
M = - DVec.*d2wdx2;
d2Mdx2 = (M(3:end) - 2.*M(2:end-1) + M(1:end-2))./dx.^2;
R = d2Mdx2 - 4.*w(3) + 8.*H;


