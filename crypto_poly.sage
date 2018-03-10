p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF

def poly(coef, F):
    res = F(0)
    degree = F(1)
    for i in range(len(coef),0,-1):
        res += degree * int(coef[i-1])
        degree *= F(x)
    return res
                
P = poly(p.binary(),F)
Q = QuotientRing(F, P)

myp = primes(1 << 20)
[poly(pi.binary(),Q) for pi in myp]

def search_space():
    pref10 = 113038384112950627112915298112892539
    pref = poly(pref10.binary(), Q)

    ten = poly(10.binary(), Q)

    base = pref * ten**2
    
    for power in range(3,342):
        base = base * ten
        step = ten**(power-3)
        steps = 1000
        for i in range(steps):
            yield base
            base += step