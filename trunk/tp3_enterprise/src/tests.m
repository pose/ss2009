#seeds for lecuyer
seed1=1;
seed2=1;
nums = lecuyer(seed1,seed2,10000);

chi = test_chi(nums,10)
ks = test_ks(nums, 10)
