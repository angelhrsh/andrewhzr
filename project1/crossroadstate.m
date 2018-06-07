function whethergo=crossroadstate(i,next,second,r,g,o,w)
whethergo=1;%horizontal: red->green->orange vertical:green->orange->red
if((floor((i+1)/2)==1&&(rem(second,r+g+o)>r+g||rem(second,r+g+o)<r))||(floor((i+1)/2)==2&&rem(second,r+g+o)>g))%if now its red light, should not go
    whethergo=0;
else%if there are cars on the specific area in front of the waiting line, shouldn't go
    findstate2=find(next(1:end,3)==2)';
    numbers2=numel(findstate2);%get all the cars in this specific area
    for j=1:numbers2%judge if each car is in the area
        
        %abandoned code
%         switch floor((i+1)/2)
%             case 1
%                 if(abs(next(findstate2(j),1))>=w/4&&abs(next(findstate2(j),1))<=w/2&&abs(next(findstate2(j),2))>=0&&abs(next(findstate2(j),2))<=w/2)
%                     whethergo=0;
%                 end;
%             case 2
%                 if(abs(next(findstate2(j),1))>=0&&abs(next(findstate2(j),1))<=w/2&&abs(next(findstate2(j),2))>=w/4&&abs(next(findstate2(j),2))<=w/2)
%                     whethergo=0;
%                 end;
%         end;
        %abandoned code
        
        switch i
            case 1
                if(next(findstate2(j),1)<=-w/4&&next(findstate2(j),1)>=-w/2&&next(findstate2(j),2)<=w/8&&next(findstate2(j),2)>=-w/2)
                    whethergo=0;
                end;
            case 2
                if(next(findstate2(j),1)>=w/4&&next(findstate2(j),1)<=w/2&&next(findstate2(j),2)>=-w/8&&next(findstate2(j),2)<=w/2)
                    whethergo=0;
                end;
            case 3
                if(next(findstate2(j),2)<=-w/4&&next(findstate2(j),2)>=-w/2&&next(findstate2(j),1)>=-w/8&&next(findstate2(j),2)<=w/2)
                    whethergo=0;
                end;
            case 4
                if(next(findstate2(j),2)>=w/4&&next(findstate2(j),2)<=w/2&&next(findstate2(j),1)<=w/8&&next(findstate2(j),1)>=-w/2)
                    whethergo=0;
                end;
        end;
    end;
end;
end