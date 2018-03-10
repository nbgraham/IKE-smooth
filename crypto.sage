import time

start = time.clock()

p = next_prime(1000000)
R = Integers(p)
min_max_prime_factor = p

for power in range(1,5):        
	for i in range(10**power):                            
		A = 55*10**power+i

		max_prime_factor = (R(2)^A).lift().factor()[-1][0]
		if max_prime_factor < min_max_prime_factor:
			min_max_prime_factor = max_prime_factor
			bestA = A

print("A=", bestA)
print("2^A=", factor((R(2)^bestA).lift()))
print(time.clock()-start)
