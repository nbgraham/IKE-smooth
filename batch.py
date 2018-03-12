def batch_gen(gen, batch_start, batch_size):
	yield batch_start
	for _ in range(batch_size-1):
		batch_i = next(gen, None)
		if batch_i is not None:
			yield batch_i
		else:
			break


def batchify(gen, batch_size):
	batch_start = next(gen, None)
	while batch_start is not None:
		yield batch_gen(gen, batch_start, batch_size)
		batch_start = next(gen,None)


def gen_after_checkpoint(gen, checkpoint, key=lambda x: x):
	v = next(gen)
	while key(v) < checkpoint:
		v = next(gen)

	print("Caught up to checkpoint")

	for v in gen:
		yield v