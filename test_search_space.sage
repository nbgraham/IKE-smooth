import time

pref = 113038384112950627112915298112892539 # 0b101011100010100111000111111100000010010001110000011111111111101001010000000011010101010011001011001011110111001111011

p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
half_p = p //2

def search_space_(base=pref*100):
    step = 1
    for power in range(3,342):
        base = base * 10
        val = base
        r = 2.powermod(val,p)
        step_r = 2.powermod(step,p)
        for i in range(1000):
            yield (val, r)
            val = val + step
            r = (r*step_r)%p
        step = step * 10 


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
            elif not str.startswith(r.binary(), bin_prefix):
                a += bit_chop
                r = (r * giant_step) % p
            else:
                a += 1
                r = r*2 if r <= half_p else (r*2) - p
            count += 1
        space_size *= 10
        a *= 10
        r = r.powermod(10,p)


# Garbage
def search_space():
    b = pref * 100
    for i in range(100):
        gen = search_space_(b+i)
        for (a,r) in gen:
            if r <= threshold:
                yield (a,r)
    print("Checked all possible values")
        

def test(gen):
    i = 0
    sizes = []
    for (a,r) in gen:
        sizes.append(len(r.binary()))
        i += 1
        if i > 100:
            break
    return sum(sizes)/len(sizes)


def main():
    start = time.time()
    avg_size = test(smart_search(25))
    print (avg_size)
    print(time.time() - start)


if __name__ == '__main__':
    main()
