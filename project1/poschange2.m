function nextpos2=poschange2(current2,findstate2,info2,v,trytime,w,adjust,range)
numbers2=numel(findstate2);
nextpos2=current2;
for i=1:numbers2
    if(~isempty(adjust))
        for j=1:numel(adjust)
            if(i==adjust(j))
                if(rem(j,2)==1)
                    vnew=range(3)*v;
                else
                    vnew=range(1)*v;
                end;
            else
                vnew=range(2)*v;
            end;
        end;
    else
        vnew=range(2)*v;
    end;
    if(info2(i,2)==0)%if the car goes straight, no need for any judgment
        nextpos2(i,floor((info2(i,1)+1)/2))=current2(i,floor((info2(i,1)+1)/2))+(-1)^(info2(i,1)+1)*trytime*vnew;
    elseif(info2(i,2)==1)%if the car turns left
        trem=trytime;
        switch info2(i,1)
            case 1
                if(current2(i,1)~=w/4)
                    nextpos2(i,1)=current2(i,1)+trytime*vnew;
                    if(nextpos2(i,1)>=w/4)
                        trem=(nextpos2(i,1)-w/4)/vnew;
                        nextpos2(i,1)=w/4;
                    end;
                end;
                if(current2(i,1)==w/4)
                    nextpos2(i,2)=current2(i,2)+trem*vnew;
                end;
            case 2
                if(current2(i,1)~=-w/4)
                    nextpos2(i,1)=current2(i,1)-trytime*vnew;
                    if(nextpos2(i,1)<=-w/4)
                        trem=-(nextpos2(i,1)+w/4)/vnew;
                        nextpos2(i,1)=-w/4;
                    end;
                end;
                if(current2(i,1)==-w/4)
                    nextpos2(i,2)=current2(i,2)-trem*vnew;
                end;
            case 3
                if(current2(i,2)~=w/4)
                    nextpos2(i,2)=current2(i,2)+trytime*vnew;
                    if(nextpos2(i,2)>=w/4)
                        trem=(nextpos2(i,2)-w/4)/vnew;
                        nextpos2(i,2)=w/4;
                    end;
                end;
                if(current2(i,2)==w/4)
                    nextpos2(i,1)=current2(i,1)-trem*vnew;
                end;
            case 4                
                if(current2(i,2)~=-w/4)
                    nextpos2(i,2)=current2(i,2)-trytime*vnew;
                    if(nextpos2(i,2)<=-w/4)
                        trem=-(nextpos2(i,2)+w/4)/vnew;
                        nextpos2(i,2)=-w/4;
                    end;
                end;
                if(current2(i,2)==-w/4)
                    nextpos2(i,1)=current2(i,1)+trem*vnew;
                end;
        end;
    elseif(info2(i,2)==-1)
        trem=trytime;
        switch(info2(i,1))            
            case 1
                if(current2(i,1)~=-w/4)
                    nextpos2(i,1)=current2(i,1)+trytime*vnew;
                    if(nextpos2(i,1)>=-w/4)
                        trem=(nextpos2(i,1)+w/4)/vnew;
                        nextpos2(i,1)=-w/4;
                    end;
                end;
                if(current2(i,1)==-w/4)
                    nextpos2(i,2)=current2(i,2)-trem*vnew;
                end;
            case 2
                if(current2(i,1)~=w/4)
                    nextpos2(i,1)=current2(i,1)-trytime*vnew;
                    if(nextpos2(i,1)<=w/4)
                        trem=-(nextpos2(i,1)-w/4)/vnew;
                        nextpos2(i,1)=w/4;
                    end;
                end;
                if(current2(i,1)==w/4)
                    nextpos2(i,2)=current2(i,2)+trem*vnew;
                end;
            case 3
                if(current2(i,2)~=-w/4)
                    nextpos2(i,2)=current2(i,2)+trytime*vnew;
                    if(nextpos2(i,2)>=-w/4)
                        trem=(nextpos2(i,2)+w/4)/vnew;
                        nextpos2(i,2)=-w/4;
                    end;
                end;
                if(current2(i,2)==-w/4)
                    nextpos2(i,1)=current2(i,1)+trem*vnew;
                end;
            case 4                
                if(current2(i,2)~=w/4)
                    nextpos2(i,2)=current2(i,2)-trytime*vnew;
                    if(nextpos2(i,2)<=w/4)
                        trem=-(nextpos2(i,2)-w/4)/vnew;
                        nextpos2(i,2)=w/4;
                    end;
                end;
                if(current2(i,2)==w/4)
                    nextpos2(i,1)=current2(i,1)-trem*vnew;
                end;
        end;
    end;
end;
end