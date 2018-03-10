small_primes = primes_first_n(100)

def test(n):
    if n < 1: return None

    max_p = 0
    max_p_fact = float("inf")
    
    for fac in small_primes:
        while n % fac == 0:
            n = n // fac
            max_p = fac

    if n ==1 or is_pseudoprime(n) and is_prime(n):
        max_p_fact = max(n, max_p)
        
    return max_p_fact


def test2(n):
    if n < 1: return None

    max_p = 0
    max_p_fact = float("inf")
    
    if n ==1 or is_pseudoprime(n) and is_prime(n):
        return n

    for fac in small_primes:
        while n % fac == 0:
            n = n // fac
            max_p = fac

    if n ==1 or is_pseudoprime(n) and is_prime(n):
        max_p_fact = max(n, max_p)

    return max_p_fact

import time

start = time.time()
for i in range(10):
    for i in range(1,10000):
        test(i)
print time.time() - start

start = time.time()
for i in range(10):
    for i in range(1,10000):
        test2(i)
print time.time() - start