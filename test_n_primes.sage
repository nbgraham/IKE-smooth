import time

'''
sage: prime_pi(436273290)
23163298

#(primes less than p) >>>>> 23163298
approx number of primes = p/log(p) ~= 2^1014

Safe to assume #(primes less than p) >= 2^1000
'''


p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
pref = 113038384112950627112915298112892539


# Choose a step so that 2^step mod p is smooth? 
# Otherwise multipying A by step multiples 2^A mod p by 2^step mod p which means min smoothness is smoothness of 2^step mod p
# Assumes that (2^A mod p) * (2^step mod p) < p. Unlikely since 2 is a generator and half of the elements of Fp are > 2^1022 so 25% of the time 
# (2^A mod p) * (2^step mod p) > 2^2044 >> p
def search_space():
	base = pref*100
	step = pref
	for power in range(3,342):
		base = base * 10
		for i in range(1000):
			yield (base + i)
		step = step * 10 
                           

def max_prime_fact(A, small_primes):
	cur_n = 2.powermod(A,p)

	max_p_fact = float("inf")

	if cur_n == 1 or is_pseudoprime(cur_n) and is_prime(cur_n):
		max_p_fact = cur_n
	else:
		max_p = 0
		
		for fac in small_primes:
			while cur_n % fac == 0:
				cur_n = cur_n // fac
				max_p = fac

		if cur_n == 1 or is_pseudoprime(cur_n) and is_prime(cur_n):
			max_p_fact = max(cur_n, max_p)

	return max_p_fact < float("inf")


def test_n(n_primes, n_factored):
    start = time.time()
    small_primes = primes_first_n(n_primes)
    gen = search_space()

    count = 0
    while count < n_factored:
        factored = max_prime_fact(next(gen), small_primes)
        if factored:
            count += 1

    return time.time() - start


def main():
    ns_primes = [2000,2500,3000,3500,4000]
    n_factored = 40

    results = {}
    for n in ns_primes:
        results[n] = []

    for epoch in range(3):
        for i, n in enumerate(ns_primes):
            print (str(epoch) + ':' + str(i) + ' = ' + str(n) + ' -- '),
            time = test_n(n, n_factored)
            print (time)
            results[n].append(time)

    average_results = [(sum(results[n_primes]),n_primes) for n_primes in results]
    print(sorted(average_results))


if __name__ == '__main__':
    main()


'''
Results
[(252.78114485740662, 900), (256.85365414619446, 400), (256.8697292804718, 300), (257.8345503807068, 200), (259.51637387275696, 800), (261.0605580806732, 100), (266.06234407424927, 500), (267.1421630382538, 600), (268.0893249511719, 700)]
Maybe unlocking my computer killed 500,600, and 700?
[(482.46528720855713, 2000), (503.5628271102905, 1000), (503.7016351222992, 1500), (512.841099023819, 900), (526.4915776252747, 400), (531.6825881004333, 300)]
[(520.139705657959, 2000), (522.4681298732758, 4000), (526.2712621688843, 10000), (530.9318239688873, 8000)]
[(485.54128909111023, 4000), (489.82389783859253, 2500), (490.3478307723999, 3000), (492.9500300884247, 2000), (495.15750789642334, 3500)]
'''