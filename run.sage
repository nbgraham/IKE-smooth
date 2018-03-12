import time
import multiprocessing

p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
p_squared = p**2
pref = 113038384112950627112915298112892539 # 0b101011100010100111000111111100000010010001110000011111111111101001010000000011010101010011001011001011110111001111011

min_max_prime_factor = p
bestResult = (float("inf"),pref,0)

small_primes = primes_first_n(100000)

new_results = []
count_As_factored = 1

start_time = time.time()


start_from_checkpoint = 1
# 113038384112950627112915298112892539006000000000000000000000000000000000000000000 for 10000 primes


def batch_gen(gen, batch_start, batch_size):
	yield batch_start
	for _ in range(batch_size-1):
		batch_i = next(gen)
		if batch_i is not None:
			yield batch_i
		else:
			break


def batchify(gen, batch_size):
	batch_start = next(gen, None)
	while batch_start is not None:
		yield batch_gen(gen, batch_start, batch_size)
		batch_start = next(gen,None)


def smart_search(bit_chop):
    threshold = p >> bit_chop
    bin_prefix = '1'+'0'*bit_chop

    giant_step = 2.powermod(bit_chop,p)

    space_size = 10**10
    a = pref * space_size
    r = 2.powermod(a,p)
    
    for i in range(10,100):
        count = 0
        while count < space_size:
            if r <= threshold:
                yield (a,r)
            elif not str.startswith(r.binary(), bin_prefix):
                a += bit_chop
                r = (r * giant_step) % p
            else:
                a += 1
                r = r*2 if r <= half_p else (r*2) - p
            count += 1
        space_size *= 10
        a *= 10
        r = r.powermod(10,p)
                           

def power_max_prime_fact(input):
	global bestResult, new_results, count_As_factored
	
	(A,n) = input
	p_offset = 0

	if n == 1 or is_pseudoprime(n) and is_prime(n):
		max_p_fact = n
		count_As_factored += 1
	else:
		max_p = 0
		max_p_fact = float("inf")
		
		cur_n = n
		for fac in small_primes:
			while cur_n % fac == 0:
				cur_n = cur_n // fac
				max_p = fac

		if cur_n == 1 or is_pseudoprime(cur_n) and is_prime(cur_n):
			max_p_fact = max(cur_n, max_p)
			
			# If it is promising also try adding p's to RHS since that will be equivalent mod p
			if max_p_fact < bestResult[0]:
				print 'time', int(time.time()-start_time), 'Possible best A found', A
				start = time.time()
				n_eq = n + p
				count_p = 1
				while count_p < 10 and n_eq < p_squared:
					mod_max_p_fact = max_prime_fact(n_eq)
					if mod_max_p_fact < max_p_fact:
						max_p_fact = mod_max_p_fact
						p_offset = count_p
					n_eq = n_eq + p
					count_p += 1
				# print 'Checking mod p took', time.time() - start, 'seconds'

			if count_As_factored % 100 == 0:
				bestResult = min([min(new_results),bestResult])
				new_results = []
			count_As_factored += 1

	# if A % pref == 0:
	# 	print 'time', int(time.time()-start_time), 'bestA', bestResult[1], 'bestOffset', bestResult[2]
	
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
	for (A,n) in smart_search(27):
		(max_p_fact,A,p_offset) = power_max_prime_fact((A,n))
		if max_p_fact < bestResult[0]:
			bestResult = (max_p_fact,A)
	bestA = bestResult[1]
	p_offset = bestResult[2]

	return  bestA, p_offset


def par():
	pool = multiprocessing.Pool(3)
	
	batch_count = 0
	bestResult = (p,0,0)
	for batch_generator in batchify(smart_search(27),1000):
		out = zip(*pool.map(power_max_prime_fact, batch_generator))
		result = min(zip(*out))

		if result[0] < bestResult:
			bestResult = result

		batch_count += 1
		print 'Batch', batch_count, 'bestA', bestResult[1], 'with p offset', bestResult[2]

	max_p_factor = bestResult[0]
	bestA = bestResult[1]
	p_offset = bestResult[2]

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