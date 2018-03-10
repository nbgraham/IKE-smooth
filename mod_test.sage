import time

bs = [141513513474164,84686835275,824646142472,5285725275724525257,24768653865864,27452754762564154614361]
ps = [465475485724614614361371,575271416461461341431,1471437146415453264257,575272572646414164315]
Rs = [Integers(p) for p in ps]
twos = [R(2) for R in Rs]

loops = 10

start = time.time()
for i in range(loops):
	for b in bs:
		for p in ps:
			power_mod(2,b,p)
print time.time()-start

start = time.time()
for i in range(loops):
	for b in bs:
		for two in twos:
			(two^b).lift()
print time.time() - start

start = time.time()
for i in range(loops):
	for b in bs:
		for p in ps:
			2.powermod(b,p)
print time.time() - start

'''
Results

nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage mod_test.sage
0.0104689598083
0.00123405456543
0.0061628818512
nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage mod_test.sage
0.0106110572815
0.000602006912231
0.000718116760254
nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage mod_test.sage
0.0110380649567
0.000602960586548
0.000695943832397
nick@nick-Inspiron-

power_mod is pretty slow
Using field of integers is slightly faster than 2.powermod
'''

'''
nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage mod_test.sage
0.011048078537
0.000662088394165
0.000630855560303
nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage mod_test.sage
0.0107650756836
0.000651121139526
0.000627994537354

2.powermod is actually slightly better when you account for the lift that is necessary for factoring/modulus
'''