PROJECT 1 CROSSROAD TRAFFIC GAME DESIGN He Zhirui ∫Œ÷«Ó£ 517021910117 UM-SJTU
==============================================================================
FILES
In this project, I write the following functions to achieve the goal.
p1init.m
p1main.m
movement.m
poschange1.m
poschange2.m
poschange3.m
crossroadstate.m
judgecrash.m
roadsketch.m
carsketch.m
findperm2.m
Apart from these,
the file ex02.m and findperm.m are requirements of Ex.2, and the whole Ex.2 consists of ex02.m, findperm.m and findperm2.m
==============================================================================
GOALS COMPLETED
In all these files, I generally complete Goal 1-6 mentioned in the p1.pdf file. However,
note:
1.The automatic speed adjustment cannot prevent crash completely, with limited rate of success
2.Some bugs may not be discovered by me because the circumstances at the crossroad can be very complicated. I cannot guarantee that every input will not lead to an error.
==============================================================================
GUIDE FOR USERS
Users should open p1init.m file(only this file is enough) and once the initial values are set up, the animation will show up and continue until the whole process is finished.
The following values for users to input:
1.total number of cars n(an integer)
2.the width of the road w(caution: a value greater than 50!!!)
3.the probability that a car doesn't stop at red light p(from 0 to 1)
4.the probability for a car to turn left or right t(from 0 to 0.5)
5.the duration of red light and orange light(caution: 1.no need to input the duration of green light! 2.the duration time should be an integer!)
6.range of speed e.g. 0.2 1.8 (serves as an interval) (caution:this interval only serves as the coefficients of the standard speed, and then cars can adjust their speed within the values in this interval multiplied by the standard speed)

An Expected Input
n=40
w=60
p=0.1
t=0.3
[r o]=[10 3]
range=[0.2 1.8]

if there is a car crash, the animation will stop and "game failed" is texted.
after the animation, the plates of cars that haven't stopped at red light will be shown in the figure
==============================================================================
HOW I WORK ON THE PROJECT
My animation is based on a plot with its axis x from -w/2-100 to w/2+100 and its axis y from -w/2-100 to w/2+100
All the sizes of the cars are randomly distributed with their lengths ranging from 15 to 25 and their widths ranging from 7.5 to 12.5. The sizes of cars demand that the width of the crossroad should not be too small.

After setting up the initial data, I obtain the initial positions of all the cars, then I use an algorithm to calculate all the positions after 0.1s in the movement.m function.
The function returns the new positions(next) as well as the cars that haven't stopped at the red light(nostop), then I use the function carsketch.m to renew all the cars in the animation and the traffic light condition.

The return big matrix next consists of three columns. The first two are the x and y coordinates. The thrid one represents the current state of the cars. There are five states in total:
0 stands for crash, 1 stands for before entering the crossroad, 2 stands for at the crossroad, 3 stands for after crossing the crossroad and 4 stands for having finished and moved out of the animation.
 
So, in the movement.m function I separate the input("current", the former output matrix "next") mainly into three parts: state 1, 2 and 3.
For cars in each of the three states, I write a function(poschange1, poschange2, poschange3) to calculate the position change.

Apart from the basic requirements, I write two more functions to reduce the rate of crash. 
1.crossroadstate.m is for the cars at state 1(before entering the crossroad) to judge whether it is safe to enter the crossroad. This function is beyond the requirement of the project.
2.judgecrash.m of course this is the requirement of the project because it returns that whether there is a car crash. I use the function like this: first get all the positions of the cars after 0.3s, if there are car crashes, return the cars that crash, then adjust their speed coefficient(the user input "range") according to their current positions and the directions they're going towards. Then input the value into this function again to get the position(much safer than without any adjustment) after 0.1s.
	In this case, I let the cars adjust the speed automatically. 
==============================================================================
BUGS
1.For complicated situations: the judgecrash.m function may return more than one crash. A single car may be involved in two or even more crashes. When this occurs, I cannot dispatch the coefficient of speed to these cars correctly. So, in this case, the cars will easily crash
2.For the speed adjustment I only choose three values of the user input as the coefficient, so actually it's a clumsy adjustment
3.For judging the car crash, I only considered the crash at the cross road area. So if any car crash occurs on the straight road(although it's not possible because I set the velocity of the cars on the straight road to be uniformed)
,I cannot detect that. This is only valid for the case if the width of crossroad w is set to be lower than 50(that's why I demand the users for a width input of over 50)