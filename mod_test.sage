import time

bs = [141513513474164,84686835275,824646142472,5285725275724525257,24768653865864,27452754762564154614361]
ps = [465475485724614614361371,575271416461461341431,1471437146415453264257,575272572646414164315]
Rs = [Integers(p) for p in ps]
twos = [R(2) for R in Rs]

start = time.time()
for b in bs:
	for p in ps:
		power_mod(2,b,p)
print time.time()-start

start = time.time()
for b in bs:
	for two in twos:
		two^b
print time.time() - start

start = time.time()
for b in bs:
	for p in ps:
		2.powermod(b,p)
print time.time() - start
