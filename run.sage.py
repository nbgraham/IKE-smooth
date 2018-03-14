
# This file was *autogenerated* from the file run.sage
from sage.all_cmdline import *   # import sage library

_sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_1000000 = Integer(1000000); _sage_const_0x15c538fe048e0fff4a01aa9965ee7b = Integer(0x15c538fe048e0fff4a01aa9965ee7b); _sage_const_100 = Integer(100); _sage_const_4 = Integer(4); _sage_const_0x7fffffffffffffffe487ed5110b4611a62633145c06e0e68948127044533e63a0105df531d89cd9128a5043cc71a026ef7ca8cd9e69d218d98158536f92f8a1ba7f09ab6b6a8e122f242dabb312f3f637a262174d31bf6b585ffae5b7a035bf6f71c35fdad44cfd2d74f9208be258ff324943328f67329c0ffffffffffffffff = Integer(0x7fffffffffffffffe487ed5110b4611a62633145c06e0e68948127044533e63a0105df531d89cd9128a5043cc71a026ef7ca8cd9e69d218d98158536f92f8a1ba7f09ab6b6a8e122f242dabb312f3f637a262174d31bf6b585ffae5b7a035bf6f71c35fdad44cfd2d74f9208be258ff324943328f67329c0ffffffffffffffff); _sage_const_0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF = Integer(0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF); _sage_const_0xffffffffffffffff921fb54442d184699556f620b115a80b1f5a43d393a37a0cba694b7b42283f8504feb4a8fa080a06ad9fd90cc3df8dcba988d9153adda61b3f58a9ca013666664e95cc8efd32f3851241e9a23e32083c65e695bef27bf7caa26ef814ca0fae5bfbac779564030f13a8ca2fdde22b0cf114c2a635dc1f2d1dc0ca825439ec8a2904208c18020acb48a8037947a0b9e31285367817f89b9ec170affb82e3dbfca0db7153d12d8d0c21ae3aae145d2e1ee9b067f5b48bafa35a10ccba67fcd2408f536d2998aa6fce0804595dc5e0bcfc56649487feb573488578e682787acb10e62ee7a152e03f4e376daf335c263358fc0000000000000001 = Integer(0xffffffffffffffff921fb54442d184699556f620b115a80b1f5a43d393a37a0cba694b7b42283f8504feb4a8fa080a06ad9fd90cc3df8dcba988d9153adda61b3f58a9ca013666664e95cc8efd32f3851241e9a23e32083c65e695bef27bf7caa26ef814ca0fae5bfbac779564030f13a8ca2fdde22b0cf114c2a635dc1f2d1dc0ca825439ec8a2904208c18020acb48a8037947a0b9e31285367817f89b9ec170affb82e3dbfca0db7153d12d8d0c21ae3aae145d2e1ee9b067f5b48bafa35a10ccba67fcd2408f536d2998aa6fce0804595dc5e0bcfc56649487feb573488578e682787acb10e62ee7a152e03f4e376daf335c263358fc0000000000000001); _sage_const_10 = Integer(10); _sage_const_1000 = Integer(1000); _sage_const_15 = Integer(15)
import time
import multiprocessing
from batch import batchify, gen_after_checkpoint


p = _sage_const_0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF 
p_squared = _sage_const_0xffffffffffffffff921fb54442d184699556f620b115a80b1f5a43d393a37a0cba694b7b42283f8504feb4a8fa080a06ad9fd90cc3df8dcba988d9153adda61b3f58a9ca013666664e95cc8efd32f3851241e9a23e32083c65e695bef27bf7caa26ef814ca0fae5bfbac779564030f13a8ca2fdde22b0cf114c2a635dc1f2d1dc0ca825439ec8a2904208c18020acb48a8037947a0b9e31285367817f89b9ec170affb82e3dbfca0db7153d12d8d0c21ae3aae145d2e1ee9b067f5b48bafa35a10ccba67fcd2408f536d2998aa6fce0804595dc5e0bcfc56649487feb573488578e682787acb10e62ee7a152e03f4e376daf335c263358fc0000000000000001  
# p**2
half_p = _sage_const_0x7fffffffffffffffe487ed5110b4611a62633145c06e0e68948127044533e63a0105df531d89cd9128a5043cc71a026ef7ca8cd9e69d218d98158536f92f8a1ba7f09ab6b6a8e122f242dabb312f3f637a262174d31bf6b585ffae5b7a035bf6f71c35fdad44cfd2d74f9208be258ff324943328f67329c0ffffffffffffffff 
# p >> 1
pref = _sage_const_0x15c538fe048e0fff4a01aa9965ee7b 
# 113038384112950627112915298112892539 

small_primes = primes_first_n(_sage_const_1000000 )

bestResult = (p,_sage_const_0 ,_sage_const_0 )	

def smart_search(bit_chop):
	threshold = p >> bit_chop
	bin_prefix = '1'+'0'*bit_chop

	giant_step = _sage_const_2 .powermod(bit_chop,p)

	space_size = _sage_const_10 **_sage_const_10 
	a = pref * space_size
	r = _sage_const_2 .powermod(a,p)
	
	for i in range(_sage_const_10 ,_sage_const_100 ):
		count = _sage_const_0 
		while count < space_size:
			if r <= threshold:
				yield (a,r)

			if not str.startswith(r.binary(), bin_prefix):
				a += bit_chop
				r = (r * giant_step) % p
			else:
				a += _sage_const_1 
				if r <= half_p:
					r = r << _sage_const_1  # Times 2
				else:
					r = (r << _sage_const_1 ) - p
			count += _sage_const_1 
		space_size *= _sage_const_10 
		a *= _sage_const_10 
		r = r.powermod(_sage_const_10 ,p)
						   

def power_max_prime_fact(input):
	global bestResult
	
	(A,n) = input
	p_offset = _sage_const_0 

	if n == _sage_const_1  or is_pseudoprime(n) and is_prime(n):
		max_p_fact = n
	else:
		max_p = _sage_const_0 
		max_p_fact = float("inf")
		
		cur_n = n
		for fac in small_primes:
			while cur_n % fac == _sage_const_0 :
				cur_n = cur_n // fac
				max_p = fac

		if cur_n == _sage_const_1  or is_pseudoprime(cur_n) and is_prime(cur_n):
			max_p_fact = max(cur_n, max_p)
			
			# If it is promising also try adding p's to RHS since that will be equivalent mod p
			if max_p_fact < bestResult[_sage_const_0 ]:
				n_eq = n + p
				count_p = _sage_const_1 
				while count_p < _sage_const_10  and n_eq < p_squared:
					mod_max_p_fact = max_prime_fact(n_eq)
					if mod_max_p_fact < max_p_fact:
						max_p_fact = mod_max_p_fact
						p_offset = count_p
					n_eq = n_eq + p
					count_p += _sage_const_1 

	result = (max_p_fact,A,p_offset)
	return result


def max_prime_fact(cur_n):
	if cur_n == _sage_const_1  or is_pseudoprime(cur_n) and is_prime(cur_n):
		max_p_fact = cur_n
	else:
		max_p = _sage_const_0 
		max_p_fact = float("inf")
		
		for fac in small_primes:
			while cur_n % fac == _sage_const_0 :
				cur_n = cur_n // fac
				max_p = fac

		if cur_n == _sage_const_1  or is_pseudoprime(cur_n) and is_prime(cur_n):
			max_p_fact = max(cur_n, max_p)

	return max_p_fact


def seq(checkpoint, batch_size, bit_chop):
	global bestResult

	start = time.time()

	search_generator = smart_search(bit_chop)
	checkpointed_search_generator = gen_after_checkpoint(search_generator, checkpoint, key=lambda x: x[_sage_const_0 ])

	batch_count = _sage_const_0 
	for batch in batchify(checkpointed_search_generator, batch_size):
		for (A,n) in batch:
			result = power_max_prime_fact((A,n))

			if result[_sage_const_0 ] < bestResult[_sage_const_0 ]:
				bestResult = result
		batch_count += _sage_const_1 
		
		print time.time() - start, 'seconds'
		print 'Batch', batch_count, 'lastA', result[_sage_const_1 ], 'bestA', bestResult[_sage_const_1 ], 'with p offset', bestResult[_sage_const_2 ]
		
	
	max_p_factor = bestResult[_sage_const_0 ]
	bestA = bestResult[_sage_const_1 ]
	p_offset = bestResult[_sage_const_2 ]

	return bestA, p_offset


def par(checkpoint, batch_size, bit_chop):
	global bestResult

	start = time.time()
	pool = multiprocessing.Pool(_sage_const_4 )
	
	search_generator = smart_search(bit_chop)
	checkpointed_search_generator = gen_after_checkpoint(search_generator, checkpoint, key=lambda x: x[_sage_const_0 ])

	batch_count = _sage_const_0 
	for batch in batchify(checkpointed_search_generator, batch_size):
		out = pool.map(power_max_prime_fact, batch)
		batchBestResult = min(out)
		lastA = out[-_sage_const_1 ][_sage_const_1 ]
		batch_count += _sage_const_1 

		print time.time() - start, 'seconds'
		print 'Batch', batch_count, 'lastA', lastA, 'bestA', batchBestResult[_sage_const_1 ], 'with p offset', batchBestResult[_sage_const_2 ]

		if batchBestResult[_sage_const_0 ] < bestResult[_sage_const_0 ]:
			bestResult = batchBestResult

		print 'Overall: bestA', bestResult[_sage_const_1 ], 'with p offset', bestResult[_sage_const_2 ]

	max_p_factor = bestResult[_sage_const_0 ]
	bestA = bestResult[_sage_const_1 ]
	p_offset = bestResult[_sage_const_2 ]

	return bestA, p_offset

def main():
	if len(sys.argv) == _sage_const_2 :
		checkpoint = int(sys.argv[_sage_const_1 ])
	else:
		checkpoint = _sage_const_0 

	bestA, p_offset = par(checkpoint, _sage_const_1000 , _sage_const_10 )

	print
	print '-'*_sage_const_15 
	print '-'*_sage_const_15 
	print "A=", bestA
	print "offset by p*", p_offset
	print "2^A=", factor(_sage_const_2 .powermod(bestA,p) + p*p_offset)


if __name__ == '__main__':
	main()

