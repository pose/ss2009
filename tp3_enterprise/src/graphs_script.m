
#seeds for lecuyer
seed1=1;
seed2=1;
nums = lecuyer(seed1,seed2,1000);

#graphic of xn versus xn+1
xs=nums(1:(columns(nums)-1));
ys=nums(2:columns(nums));

figure(1);
plot(xs,ys,'*');

#3d plotting
xs=nums(1:(columns(nums)-2));
ys=nums(2:columns(nums)-1);
zs=nums(3:columns(nums));

figure(2);
plot3(xs,ys,zs,'*');



