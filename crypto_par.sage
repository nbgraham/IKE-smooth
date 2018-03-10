import time
import multiprocessing

p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
pref = 113038384112950627112915298112892539 # 0b101011100010100111000111111100000010010001110000011111111111101001010000000011010101010011001011001011110111001111011

min_max_prime_factor = p
bestResult = (float("inf"),pref)

small_primes = primes_first_n(100)

new_results = []
old_results = []
count_As_factored = 1


def search_space():
	base = pref*100
	step = pref
	for power in range(3,342):
		base = base * 10
		for i in range(1000):
			yield (base + i)
		step = step * 10 
                           

def max_prime_fact(A):
	cur_n = 2.modpower(A,p)

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
			if count_As_factored % 100 == 0:
				bestResult = min([min(new_results),bestResult])
				old_results += new_results
				new_results = []
			count_As_factored += 1

	if A % pref == 0:
		print 'time', int(time.time()), 'A', A, 'bestA', bestA
		
	result = (max_p_fact,A)
	new_results.append(result)
	return result


def main():
	start = time.time()

	pool = multiprocessing.Pool(3)
	out = zip(*pool.map(max_prime_fact, search_space()))
	result = min(zip(*out))

	mess = result[0]
	bestA = result[1]

	print
	print '-'*15
	print '-'*15
	print "A=", bestA
	print "2^A=", factor(2.modpower(bestA,p))

	runtime = time.time() - start
	print runtime, "seconds"


if __name__ == '__main__':
	main()