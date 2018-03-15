import time

pref = 113038384112950627112915298112892539 # 0b101011100010100111000111111100000010010001110000011111111111101001010000000011010101010011001011001011110111001111011

p = 0xFFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF
half_p = p >> 1
quarter_p = p >> 2

# def search_space_(base=pref*100):
# 	step = 1
# 	for power in range(3,342):
# 		base = base * 10
# 		val = base
# 		r = 2.powermod(val,p)
# 		step_r = 2.powermod(step,p)
# 		for i in range(1000):
# 			yield (val, r)
# 			val = val + step
# 			r = (r*step_r)%p
# 		step = step * 10 


# def smart_search(bit_chop):
# 	threshold = p >> bit_chop
# 	bin_prefix = '1'+'0'*bit_chop

# 	giant_step = 2.powermod(bit_chop,p)

# 	space_size = 10**1
# 	a = pref * space_size
# 	r = 2.powermod(a,p)
	
# 	for i in range(1,272):
# 		count = 0
# 		while count < space_size:
# 			if r <= threshold:
# 				yield (a,r)

# 			if not str.startswith(r.binary(), bin_prefix):
# 				a += bit_chop
# 				r = (r * giant_step) % p
# 			else:
# 				a += 1
# 				if r <= half_p:
# 					r = r << 1 # Times 2
# 				else:
# 					r = (r << 1) - p
# 			count += 1
# 		space_size *= 10
# 		a *= 10
# 		r = r.powermod(10,p)


# def smart_search_(bit_chop):
# 	threshold = p >> bit_chop

# 	space_size = 10**1
# 	a = pref * space_size
# 	r = 2.powermod(a,p)
	
# 	for i in range(1,272):
# 		count = 0
# 		while count < space_size:
# 			if r <= threshold:
# 				yield (a,r)

# 			a += 1
# 			if r <= half_p:
# 				r = r << 1 # Times 2
# 			else:
# 				r = (r << 1) - p

# 			count += 1
# 		space_size *= 10
# 		a *= 10
# 		r = r.powermod(10,p)


# def smart_search__(bit_chop):
# 	threshold = p >> bit_chop
# 	bottom_threshold = p >> (bit_chop + 1)

# 	giant_step = 2.powermod(bit_chop,p)

# 	space_size = 10**1
# 	a = pref * space_size
# 	r = 2.powermod(a,p)
	
# 	for i in range(1,272):
# 		count = 0
# 		while count < space_size:
# 			if r <= threshold:
# 				yield (a,r)
# 				if r > bottom_threshold:
# 					a += bit_chop
# 					r = r*giant_step
# 					break

# 			a += 1
# 			if r <= half_p:
# 				r = r << 1 # Times 2
# 			else:
# 				r = (r << 1) - p

# 			count += 1
# 		space_size *= 10
# 		a *= 10
# 		r = r.powermod(10,p)

# def smart_search(bit_chop):
# 	threshold = p >> bit_chop
# 	bottom_threshold = p >> (bit_chop + 1)

# 	space_size = 10**1
# 	a = pref * space_size
# 	r = 2.powermod(a,p)
	
# 	for i in range(1,272):
# 		count = 0
# 		while count < space_size:
# 			if r <= threshold:
# 				yield (a,r)
# 				if r > bottom_threshold:
# 					a += bit_chop
# 					r = r << bit_chop
# 					continue

# 			a += 1
# 			if r < half_p:
# 				r = r << 1
# 			else:
# 				r = (r << 1) - p

# 			count += 1
# 		space_size *= 10
# 		a *= 10
# 		r = r.powermod(10,p)


def smart_search(bit_chop):
	threshold = p >> bit_chop
	bottom_threshold = p >> (bit_chop + 1)

	space_size = 10**1
	a = pref * space_size
	r = 2.powermod(a,p)
	
	for i in range(1,272):
		count = 0
		while count < space_size:
			if r <= threshold:
				yield (a,r)
				if r > bottom_threshold:
					a += bit_chop
					count += bit_chop
					r = r << bit_chop
				else:
					a += 1
					count += 1
					r = r << 1
			else:
				a += 1
				count += 1
				if r < half_p:
					r = r << 1
				else:
					r = (r << 1) - p
		space_size *= 10
		a *= 10
		r = r.powermod(10,p)


# def smart_search_(bit_chop):
# 	threshold = p >> bit_chop

# 	space_size = 10**1
# 	a = pref * space_size
# 	r = 2.powermod(a,p)
	
# 	for i in range(1,272):
# 		count = 0
# 		while count < space_size:
# 			if r <= threshold:
# 				yield (a,r)
# 			a += 1
# 			if r <= half_p:
# 				r = r << 1 # Times 2
# 			else:
# 				r = (r << 1) - p
# 			count += 1
# 		space_size *= 10
# 		a *= 10
# 		r = r.powermod(10,p)

# def smart_search_(bit_chop):
# 	threshold = p >> bit_chop
# 	bottom_threshold = p >> (bit_chop + 1)

# 	space_size = 10**1
# 	a = pref * space_size
# 	r = 2.powermod(a,p)
	
# 	for i in range(1,272):
# 		count = 0
# 		while count < space_size:
# 			if r <= threshold:
# 				yield (a,r)
# 				if r > bottom_threshold:
# 					a += bit_chop
# 					r = r << bit_chop
# 					continue

# 			if r <= quarter_p:
# 				a += 2
# 				r = r << 2
# 			elif r <= half_p:
# 				a += 2
# 				r = (r << 2) - p
# 			else:
# 				a += 1
# 				r = (r << 1) - p

# 			count += 1
# 		space_size *= 10
# 		a *= 10
# 		r = r.powermod(10,p)


# Garbage
# def search_space():
# 	b = pref * 100
# 	for i in range(100):
# 		gen = search_space_(b+i)
# 		for (a,r) in gen:
# 			if r <= threshold:
# 				yield (a,r)
# 	print("Checked all possible values")
		

def test(gen, n=1000):
	sizes = []
	for _ in range(n):
		(a,r) = next(gen)
		sizes.append(len(r.binary()))
	return sum(sizes)/len(sizes)


def main():
	b = int(sys.argv[1])

	for _ in range(5):
		start = time.time()
		avg_size = test(smart_search(b))
		print (avg_size)
		print(time.time() - start)

		start = time.time()
		avg_size = test(smart_search_(b))
		print (avg_size)
		print(time.time() - start)

		print('-'*15)


if __name__ == '__main__':
	main()
