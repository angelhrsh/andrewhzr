function nextpos1=poschange1(current1,v,info1,remt,w)%remt is 0 if it is just before the whethergo judgment, so if the car reaches the waiting line, it should stay in the waiting line
numbers1=numel(current1)/3;
nextpos1=current1;
%here we just need to move the first car first, and then move the rest of
%the cars according to the distance travelled by the first car
if(floor((info1(1,1)+1)/2)==1)% if remt==0 it means that it is the first time applying this function(there will be twice if some time is still remaining after the car gets to the waiting line just before the traffic light)
    nextpos1(1,1)=nextpos1(1,1)-sign(nextpos1(1,1))*0.1*v*(remt==0)-sign(nextpos1(1,1))*remt*v*(remt~=0);
    if(abs(nextpos1(1,1))-info1(1,3)/2<w/2&&remt==0)
        nextpos1(1,1)=sign(current1(1,1))*(w/2+info1(1,3)/2);
    end;
    distance=nextpos1(1,1)-current1(1,1);
else
    nextpos1(1,2)=nextpos1(1,2)-sign(nextpos1(1,2))*0.1*v*(remt==0)-sign(nextpos1(1,2))*remt*v*(remt~=0);
    if(abs(nextpos1(1,2))-info1(1,3)/2<w/2&&remt==0)
        nextpos1(1,2)=sign(current1(1,2))*(w/2+info1(1,3)/2);
    end;   
    distance=nextpos1(1,2)-current1(1,2);
end;

if(numbers1>1)
    for i=2:numbers1
        if(floor((info1(i,1)+1)/2)==1)
            nextpos1(i,1)=nextpos1(i,1)+distance;
        else
            nextpos1(i,2)=nextpos1(i,2)+distance;
        end;
    end;
end;
%abandoned code
% for i=1:numbers1
%     if(floor((info1(i,1)+1)/2)==1)
%         nextpos1(i,1)=nextpos1(i,1)-sign(nextpos1(i,1))*0.1*v*(remt==0)-sign(nextpos1(i,1))*remt*v*(remt~=0);
%         if(abs(nextpos1(i,1))+info1(i,3)<w/2&&remt==0)
%             nextpos1(i,1)=sign(current1(i,1))*w/2;
%         end;
%     else
%         nextpos1(i,2)=nextpos1(i,2)-sign(nextpos1(i,2))*0.1*v*(remt==0)-sign(nextpos1(i,2))*remt*v*(remt~=0);
%         if(abs(nextpos1(i,2))<w/2&&remt==0)
%             nextpos1(i,2)=sign(current(i,2))*w/2;
%         end;
%     end;
% end;
%abandoned code

end