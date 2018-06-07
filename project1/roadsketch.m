function roadsketch(w)
axis equal;hold on;
axis([-100-w/2 100+w/2 -100-w/2 100+w/2]);
plot([-100-w/2 100+w/2],[0 0],'k--',[0 0],[-100-w/2 100+w/2],'k--');%plot the dashed line in the middle
range1=[-100-w/2 -w/2];
range2=[w/2 100+w/2];
plot(range1,[w/2 w/2],'k',range1,[-w/2 -w/2],'k',range2,[w/2 w/2],'k',range2,[-w/2 -w/2],'k');
plot([w/2 w/2],range1,'k',[-w/2 -w/2],range1,'k',[w/2 w/2],range2,'k',[-w/2 -w/2],range2,'k');%draw the sides of the roads
end
