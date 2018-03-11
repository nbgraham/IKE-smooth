# IKE-smooth

## Running
`sage run.sage`  
This will completley use three of your cores

## Best Results
*3/10/18 17:59*  
**A** = 113038384112950627112915298112892539000000441  
**2^A % p (factored)** = 7 * 13 * 3793 * 18583 * 28463 *  292006479276865711089788155898853433780119428543066312747633921942223738801870640267052457873114539624674511938035884324336778860882560542877427643915063060962691710928374500716243866998011941192034751893552257674842871588660033735354050818361974356656098585631307719446214638419417254439420619
**Smoothness bit length** = 974  
**Number of small primes checked** = 4000

*3/10/18 17:46*  
**A** = 1130383841129506271129152981128925390000000000000000000000000000000000000000000000534  
**2^A % p (factored)** = 3^2 * 61 * 131 * 7297 * 33413 *  8097235151684820623258327766099296585954347374590556409068949417161513802327760214497342673226393631557366317262174641993855119232549328354846371531760189210830257855993165238827687360650532621980444326938263845903104888276115772934478071979352306581912380566619044671765468004049685108180874933
**Smoothness bit length** = 979  
**Number of small primes checked** = 4000

*3/10/18 11:06*  
**A** = 113038384112950627112915298112892539000000000000000000000000000000000000000598  
**2^A % p (factored)** = 3^2 * 11^3 * 11^2 * 19 * 59 * 83 *  31531939988151515755935541249241644818084787898538367816678696786751025468480324598852372532379040840447580498783421652985508124297928139734407803975803988092252383302555274407403626659042784803254949975847520758125599398820777381960008855196398780519473555506845930304973729994667738196432225706707  
**Smoothness bit length** = 991  
**Number of small primes checked** = 100

*3/10/18 10:52*  
**A** = 113038384112950627112915298112892539000000000000000000000000000000969  
**2^A % p (factored)** = 5 * 7^2 * 11^2 * 19^2 * 2379117159909031401540870451838032697396855129463643089515820515017511580109183576387710623923403227598648392892317540024487720082852640892316623120356860600895468877573715215679219472127117725159751937158913440365073570763644826517241368572564417151126878283371884905771287792672434610658031728279091  
**Smoothness bit length** = 997  
**Number of small primes checked** = 100

*3/9/18*  
**A** = 1130383841129506271129152981128925391183541632353807291668772443379849041280779692799705559472469556430505118793728  
**2^A % p (factored)** = 245519451376879165963598010244683022459994001324769426694717599182964964319835401014058829466711616047363667473151835616248467610575457883521983039982260114265735532736963337970070314099686242235701811259145661456572092332594581369567978169701265114113588119306284823067261566757301896037474998508451755739  
**Smoothness bit length** = 1014  

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

### Power mod functions
```
nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage mod_test.sage
0.0104689598083
0.00123405456543
0.0061628818512
nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage mod_test.sage
0.0106110572815
0.000602006912231
0.000718116760254
nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage mod_test.sage
0.0110380649567
0.000602960586548
0.000695943832397
nick@nick-Inspiron-
```

power_mod is pretty slow  
Using field of integers is slightly faster than 2.powermod


### Checking primes before removing factors

```
nick@nick-Inspiron-7559:~/Developer/IKE-smooth$ sage prime_test.sage
1.84293699265
1.29911899567
```

Checking primes before is faster. (Also note that we must check if it is 1 because 1 is not prime)
