
# This file was *autogenerated* from the file mod_test.sage
from sage.all_cmdline import *   # import sage library

_sage_const_2 = Integer(2); _sage_const_5285725275724525257 = Integer(5285725275724525257); _sage_const_575272572646414164315 = Integer(575272572646414164315); _sage_const_824646142472 = Integer(824646142472); _sage_const_141513513474164 = Integer(141513513474164); _sage_const_24768653865864 = Integer(24768653865864); _sage_const_575271416461461341431 = Integer(575271416461461341431); _sage_const_10 = Integer(10); _sage_const_1471437146415453264257 = Integer(1471437146415453264257); _sage_const_84686835275 = Integer(84686835275); _sage_const_27452754762564154614361 = Integer(27452754762564154614361); _sage_const_465475485724614614361371 = Integer(465475485724614614361371)
import time

bs = [_sage_const_141513513474164 ,_sage_const_84686835275 ,_sage_const_824646142472 ,_sage_const_5285725275724525257 ,_sage_const_24768653865864 ,_sage_const_27452754762564154614361 ]
ps = [_sage_const_465475485724614614361371 ,_sage_const_575271416461461341431 ,_sage_const_1471437146415453264257 ,_sage_const_575272572646414164315 ]
Rs = [Integers(p) for p in ps]
twos = [R(_sage_const_2 ) for R in Rs]

loops = _sage_const_10 

start = time.time()
for i in range(loops):
	for b in bs:
		for p in ps:
			power_mod(_sage_const_2 ,b,p)
print time.time()-start

start = time.time()
for i in range(loops):
	for b in bs:
		for two in twos:
			(two**b).lift()
print time.time() - start

start = time.time()
for i in range(loops):
	for b in bs:
		for p in ps:
			_sage_const_2 .powermod(b,p)
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

