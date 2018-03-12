p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
p_squared = p**2

def test(n,c):
    checkpoint = c / 100
    max_p_fact = float("inf")
    n_eq = n
    count_p = 0
    while count_p < c and n_eq < p_squared:
        if count_p % checkpoint == 0:
            print(count_p)
        mod_max_p_fact = max_prime_fact(n_eq)
        if mod_max_p_fact < max_p_fact:
            max_p_fact = mod_max_p_fact
            p_offset = count_p
            print(p_offset, max_p_fact)
        n_eq = n_eq + p
        count_p += 1

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

if __name__ == '__main__':
    A = sys.argv[1]
    c = sys.argv[2]

    test(2.powermod(A,p),c)