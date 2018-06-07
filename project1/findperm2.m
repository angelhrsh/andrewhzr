function allperm2=findperm2(s,q,qconst,oneperm,allperm2,n)%q for checking the end of the recursion
if(q==0)
    isrepeat=0;
    for i=1:numel(allperm2)
        if(numel(allperm2)>0&&strcmp(allperm2{i},oneperm))
            isrepeat=1;
            break;
        end;    
    end;
    if(isrepeat==0)
        allperm2=[allperm2 oneperm];
    end;
else
    while(numel(allperm2)<n)
        i=randperm(numel(s),1);        
        if(isempty(s{i}))
            continue;
        end;
        temp=s{i};
        s{i}={};
        allperm2=findperm2(s,q-1,qconst,[oneperm temp],allperm2,n);
        if(q~=qconst)
            return;
        end;
        s{i}=temp;
    end;
end;
end