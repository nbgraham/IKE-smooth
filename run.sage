import time
import multiprocessing

p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
p_squared = p**2
pref = 113038384112950627112915298112892539 # 0b101011100010100111000111111100000010010001110000011111111111101001010000000011010101010011001011001011110111001111011

min_max_prime_factor = p
bestResult = (float("inf"),pref,0)

small_primes = primes_first_n(4000)

new_results = []
count_As_factored = 1

start_time = time.time()

def search_space():
	base = pref*100
	step = pref
	for power in range(3,342):
		base = base * 10
		for i in range(1000):
			yield (base + i)
		step = step * 10 
                           

def power_max_prime_fact(A):
	global bestResult, new_results, count_As_factored
	
	cur_n = 2.powermod(A,p)
	p_offset = 0

	if cur_n == 1 or is_pseudoprime(cur_n) and is_prime(cur_n):
		max_p_fact = cur_n
		count_As_factored += 1
	else:
		max_p = 0
		max_p_fact = float("inf")
		
		for fac in small_primes:
			while cur_n % fac == 0:
				cur_n = cur_n // fac
				max_p = fac

		if cur_n == 1 or is_pseudoprime(cur_n) and is_prime(cur_n):
			max_p_fact = max(cur_n, max_p)
			
			# If it is promising also try adding p's to RHS since that will be equivalent mod p
			if max_p_fact < bestResult[0]:
				cur_n = cur_n + p
				count_p = 1
				while count_p < 100 and cur_n < p_squared:
					mod_max_p_fact = max_prime_fact(cur_n)
					if mod_max_p_fact < max_p_fact:
						max_p_fact = mod_max_p_fact
						p_offset = count_p
					cur_n = cur_n + p
					count_p += 1

			if count_As_factored % 100 == 0:
				bestResult = min([min(new_results),bestResult])
				new_results = []
			count_As_factored += 1

	if A % pref == 0:
		print 'time', int(time.time()-start_time), 'A', A, 'bestA', bestResult[1], 'bestOffset', bestResult[2]
	
	result = (max_p_fact,A,p_offset)
	new_results.append(result)
	return result


def max_prime_fact(cur_n):
	if cur_n == 1 or is_pseudoprime(cur_n) and is_prime(cur_n):
		max_p_fact = cur_n
	else:
		max_p = 0
		max_p_fact = float("inf")
		
		for fac in small_primes:
			while cur_n % fac == 0:
				cur_n = cur_n // fac
				max_p = fac

		if cur_n == 1 or is_pseudoprime(cur_n) and is_prime(cur_n):
			max_p_fact = max(cur_n, max_p)

	return max_p_fact


def seq():
	global bestResult
	for A in search_space():
		(max_p_fact,A) = power_max_prime_fact(A)
		if max_p_fact < bestResult[0]:
			bestResult = (max_p_fact,A)
	bestA = bestResult[1]
	p_offset = bestResult[2]

	return  bestA, p_offset


def par():
	pool = multiprocessing.Pool(2)
	out = zip(*pool.map(power_max_prime_fact, search_space()))
	result = min(zip(*out))

	mess = result[0]
	bestA = result[1]
	p_offset = result[2]

	return bestA, p_offset

def main():	
	start = time.time()

	bestA, p_offset = par()	

	print
	print '-'*15
	print '-'*15
	print "A=", bestA
	print "offset by p*", p_offset
	print "2^A=", factor(2.powermod(bestA,p) + p*p_offset)

	runtime = time.time() - start
	print runtime, "seconds"


if __name__ == '__main__':
	main()