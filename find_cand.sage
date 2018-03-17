import time
import multiprocessing
from batch import batchify, gen_after_checkpoint
import pickle


p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
p_squared = 0xffffffffffffffff921fb54442d184699556f620b115a80b1f5a43d393a37a0cba694b7b42283f8504feb4a8fa080a06ad9fd90cc3df8dcba988d9153adda61b3f58a9ca013666664e95cc8efd32f3851241e9a23e32083c65e695bef27bf7caa26ef814ca0fae5bfbac779564030f13a8ca2fdde22b0cf114c2a635dc1f2d1dc0ca825439ec8a2904208c18020acb48a8037947a0b9e31285367817f89b9ec170affb82e3dbfca0db7153d12d8d0c21ae3aae145d2e1ee9b067f5b48bafa35a10ccba67fcd2408f536d2998aa6fce0804595dc5e0bcfc56649487feb573488578e682787acb10e62ee7a152e03f4e376daf335c263358fc0000000000000001 
# p**2
half_p = 0x7fffffffffffffffe487ed5110b4611a62633145c06e0e68948127044533e63a0105df531d89cd9128a5043cc71a026ef7ca8cd9e69d218d98158536f92f8a1ba7f09ab6b6a8e122f242dabb312f3f637a262174d31bf6b585ffae5b7a035bf6f71c35fdad44cfd2d74f9208be258ff324943328f67329c0ffffffffffffffff
# p >> 1
pref = 0x15c538fe048e0fff4a01aa9965ee7b
# 113038384112950627112915298112892539 

n_primes = 2222222
small_primes = primes_first_n(n_primes)

bestResult = (p,0)    

def smart_search(bit_chop):
    threshold = p >> bit_chop
    bottom_threshold = threshold >> 1

    space_size = 10**1
    base_a = pref * space_size
    a = base_a
    base_r = 2.powermod(a,p)
    r = base_r

    for i in range(1,272):
        count = 0
        while count < space_size:
            if r <= threshold:
                yield (a,r)

                while r <= bottom_threshold:
                    a += 1
                    count += 1
                    r = r << 1
                    yield (a,r)

                a += bit_chop
                count += bit_chop
                r = r << bit_chop
            else:
                a += 1
                count += 1
                if r < half_p:
                    r = r << 1
                else:
                    r = (r << 1) - p
        space_size *= 10
        base_a *= 10
        a = base_a
        base_r = r.powermod(10,p)
        r = base_r
                   

def power_max_prime_fact(input):
    global bestResult
    
    (A,n) = input
    
    max_p_fact_cand = float("inf")

    if n == 1 or is_pseudoprime(n):
        max_p_fact_cand = n
    else:
        max_p = 0
        
        cur_n = n
        for fac in small_primes:
            while cur_n % fac == 0:
                cur_n = cur_n // fac
                max_p = fac
        
        if cur_n == 1:
            max_p_fact_cand = max_p
        elif is_pseudoprime(cur_n):
            max_p_fact_cand = cur_n

    result = (max_p_fact_cand, A)
    return result


def par(checkpoint, batch_size, cutoff_batches, n_remainders, bit_chop):
    global bestResult

    start = time.time()
    pool = multiprocessing.Pool(4)
    
    search_generator = smart_search(bit_chop)
    checkpointed_search_generator = gen_after_checkpoint(search_generator, checkpoint, key=lambda x: x[0])

    best_results = []
    batch_count = 0
    for batch in batchify(checkpointed_search_generator, batch_size):
        out = pool.map(power_max_prime_fact, batch)
        best_results.extend(out)

        batchBestResult = min(out)
        
        print time.time() - start, 'seconds'
        batch_count += 1
        lastA = out[-1][1]
        print 'Batch', batch_count, 'lastA', lastA, 'bestA', batchBestResult[1]

        if batch_count % cutoff_batches == 0:
            best_results = sorted(best_results)[:n_remainders]
            with open('best_results.pkl','wb') as file:
                pickle.dump(best_results, file)
            print 'Overall: bestAs'
            for (a, r) in best_results:
                print '    ', a, '--', r

    bestResult = best_results
    max_p_factor = bestResult[0]
    bestA = bestResult[1]

    return bestA, p_offset


def main():
    if len(sys.argv) == 2:
        checkpoint = int(sys.argv[1])
    else:
        checkpoint = 0

    batch_size = 8 
    bit_chop = 10
    cutoff_batches = 360
    n_remainders = 100

    print 'Starting, batch size =', batch_size, 'bit chop =', bit_chop, 'with # primes: ', n_primes

    bestA, p_offset = par(checkpoint, batch_size, cutoff_batches, n_remainders, bit_chop)

    print
    print '-'*15
    print '-'*15
    print "A=", bestA
    print "offset by p*", p_offset
    print "2^A=", factor(2.powermod(bestA,p) + p*p_offset)


if __name__ == '__main__':
    main()
