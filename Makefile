.PHONY: bench cmp color regen regen-bench regen-cmp smoke

BENCH_TIME ?= 5s

bench: regen-bench
	go test -bench=. -benchmem -benchtime=$(BENCH_TIME) ./bench

cmp: regen-cmp
	go test -bench=. -benchmem -benchtime=$(BENCH_TIME) ./cmp

color:
	go test ./color

regen: regen-bench regen-cmp

regen-bench:
	go tool validgen ./bench

regen-cmp:
	go tool validgen ./cmp

smoke:
	go test -count=1 ./bench ./color ./cmp
	go test -bench='Benchmark(ManualCoding|ValidGen|Validator)$$' -benchtime=1x -count=1 ./bench
	go test -bench='Benchmark(ValidGen|Validator)RequiredString$$' -benchtime=1x -count=1 ./cmp
