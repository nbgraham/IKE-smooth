p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF

def small(t, n_primes_used):
    factors = []
    for sp in primes_first_n(n_primes_used):
        while t % sp == 0:
            t = t // sp
            factors.append(sp)
    return factors, t


def test(A, n_primes_used):
    r = 2.powermod(A,p)
    small_factors, big_factor = small(r, n_primes_used)

    last = small_factors[0]
    count = 1
    for factor in small_factors[1:]:
        if factor == last:
            count += 1
        else:
            if count == 1:
                print last, ' *',
            else:
                print last, '^', count, ' *',
            last = factor
            count = 1
    if count == 1:
        print last, ' *',
    else:
        print last, '^', count, ' *',

    print(big_factor)
    print(len(big_factor.binary()))


# Example usage
# sage test.sage 113038384112950627112915298112892539000000000000000000000000000000000000000598 100
if __name__ == '__main__':
    A = int(sys.argv[1])
    n_primes_used = int(sys.argv[2])
    test(A, n_primes_used)



