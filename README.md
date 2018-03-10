# IKE-smooth


## Comparisons
### primes vs primes_first_n
```
sage: time b = list(primes(10**7))
CPU times: user 2.6 s, sys: 7.79 ms, total: 2.6 s
Wall time: 2.66 s
sage: time a = primes_first_n(len(b))
CPU times: user 39.6 ms, sys: 4.14 ms, total: 43.8 ms
Wall time: 54.8 ms
sage: a[-3:]
[9999971, 9999973, 9999991]
sage: b[-3:]
[9999971, 9999973, 9999991]
sage: a == b
True
```
I thought primes_first_n was CLEAR winner, but it was the list operation that was slowing it down.

```
sage: time b = primes(10**7)
CPU times: user 27.5 ms, sys: 283 µs, total: 27.7 ms
Wall time: 49.4 ms
sage: b
<generator object primes at 0x7eff4098d730>
```

A generator is probably better for memory.

BUT iterating through that generator is much slower

```
sage: time for i in primes_first_n(len(a)): 84729057465249 % i == 0
CPU times: user 380 ms, sys: 12 ms, total: 392 ms
Wall time: 422 ms
sage: time for i in primes(10**7): 84729057465249 % i == 0
CPU times: user 2.96 s, sys: 0 ns, total: 2.96 s
Wall time: 3.04 s
sage: a[-10:]

[9999889,
 9999901,
 9999907,
 9999929,
 9999931,
 9999937,
 9999943,
 9999971,
 9999973,
 9999991]
sage: b
<generator object primes at 0x7eff4098d730>
sage: time for i in a: 84729057465249 % i == 0
CPU times: user 317 ms, sys: 0 ns, total: 317 ms
Wall time: 352 ms
sage: time for i in b: 84729057465249 % i == 0
CPU times: user 2.96 s, sys: 3.3 ms, total: 2.97 s
Wall time: 3.04 s
```

We iterate through the list about 2^1023 times, but only create it once.  
**primes_first_n is winner**