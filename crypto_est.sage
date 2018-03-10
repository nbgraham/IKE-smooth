import time

start = time.clock()

p = next_prime(0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF)
R = Integers(p)
min_max_prime_factor = p
bestA = 1

myp = primes(10000)
for power in range(320,342):        
	for i in range(0, 10**power, 10**(power-3)):                            
		A = 113038384*10**power+i
		
		max_p = 0
		cur_R = (R(2)^A).lift()
		for fac in myp:
			if cur_R % fac == 0:
				cur_R = cur_R // fac
				max_p = fac

		if cur_R.is_pseudoprime():
			if cur_R.is_prime():
				max_prime_factor = max(cur_R,max_p)

				if max_prime_factor < min_max_prime_factor:
					min_max_prime_factor = max_prime_factor
					bestA = A

print("A=", bestA)
print("2^A=", factor((R(2)^bestA).lift()))
print(time.clock()-start)
