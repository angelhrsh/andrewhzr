function allperm=findperm(s,q,oneperm,allperm)
if(q==0)
    allperm=[allperm oneperm];
else
    for i=1:numel(s)
        if(isempty(s{i}))
            continue;
        end;
        temp=s{i};
        s{i}={};
        allperm=findperm(s,q-1,[oneperm temp],allperm);
        s{i}=temp;
    end;
end;
end