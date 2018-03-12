import time
import multiprocessing
from batch import batchify, gen_after_checkpoint


p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
p_squared = p**2
half_p = p >> 1
pref = 113038384112950627112915298112892539 # 0b101011100010100111000111111100000010010001110000011111111111101001010000000011010101010011001011001011110111001111011

small_primes = primes_first_n(1000000)

min_max_prime_factor = p
bestResult = (p,0,0)	


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

			if not str.startswith(r.binary(), bin_prefix):
				a += bit_chop
				r = (r * giant_step) % p
			else:
				a += 1
				if r <= half_p:
					r = r << 1 # Times 2
				else:
					r = (r << 1) - p
			count += 1
		space_size *= 10
		a *= 10
		r = r.powermod(10,p)
						   

def power_max_prime_fact(input):
	global bestResult
	
	(A,n) = input
	p_offset = 0

	if n == 1 or is_pseudoprime(n) and is_prime(n):
		max_p_fact = n
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
				n_eq = n + p
				count_p = 1
				while count_p < 10 and n_eq < p_squared:
					mod_max_p_fact = max_prime_fact(n_eq)
					if mod_max_p_fact < max_p_fact:
						max_p_fact = mod_max_p_fact
						p_offset = count_p
					n_eq = n_eq + p
					count_p += 1

	result = (max_p_fact,A,p_offset)
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


def seq(checkpoint, batch_size, bit_chop):
	global bestResult

	start = time.time()

	search_generator = smart_search(bit_chop)
	checkpointed_search_generator = gen_after_checkpoint(search_generator, checkpoint, key=lambda x: x[0])

	batch_count = 0
	for batch in batchify(checkpointed_search_generator, batch_size):
		for (A,n) in batch:
			result = power_max_prime_fact((A,n))

			if result[0] < bestResult[0]:
				bestResult = result
		batch_count += 1
		
		print time.time() - start, 'seconds'
		print 'Batch', batch_count, 'lastA', result[1], 'bestA', bestResult[1], 'with p offset', bestResult[2]
		
	
	max_p_factor = bestResult[0]
	bestA = bestResult[1]
	p_offset = bestResult[2]

	return bestA, p_offset


def par(checkpoint, batch_size, bit_chop):
	global bestResult

	start = time.time()
	pool = multiprocessing.Pool(4)
	
	search_generator = smart_search(bit_chop)
	checkpointed_search_generator = gen_after_checkpoint(search_generator, checkpoint, key=lambda x: x[0])

	batch_count = 0
	for batch in batchify(checkpointed_search_generator, batch_size):
		out = pool.map(power_max_prime_fact, batch)
		batchBestResult = min(out)
		lastA = out[-1][1]
		batch_count += 1

		print time.time() - start, 'seconds'
		print 'Batch', batch_count, 'lastA', lastA, 'bestA', batchBestResult[1], 'with p offset', batchBestResult[2]

		if batchBestResult[0] < bestResult[0]:
			bestResult = batchBestResult

		print 'Overall: bestA', bestResult[1], 'with p offset', bestResult[2]

	max_p_factor = bestResult[0]
	bestA = bestResult[1]
	p_offset = bestResult[2]

	return bestA, p_offset

def main():
	if len(sys.argv) == 2:
		checkpoint = int(sys.argv[1])
	else:
		checkpoint = 0

	bestA, p_offset = par(checkpoint, 1000, 10)

	print
	print '-'*15
	print '-'*15
	print "A=", bestA
	print "offset by p*", p_offset
	print "2^A=", factor(2.powermod(bestA,p) + p*p_offset)


if __name__ == '__main__':
	main()