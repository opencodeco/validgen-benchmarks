# validgen-benchmarks

Benchmarks and compatibility checks that compare [ValidGen](https://github.com/opencodeco/validgen) with [go-playground/validator](https://github.com/go-playground/validator).

These tests live in this module so `github.com/opencodeco/validgen` does not require `github.com/go-playground/validator/v10`.

## Requirements

- Git
- Go >= 1.24
- Make

## Small comparison

`bench` times one struct three ways: ValidGen, go-playground/validator, and handwritten checks.

```bash
make bench
```

`make bench` runs the ValidGen CLI on `./bench`, then:

```bash
go test -bench=. -benchmem -benchtime=5s ./bench
```

## Generated comparison

`cmp` times ValidGen and go-playground/validator for the validations and types TestGen emits.

```bash
make cmp
```

The default bench time is 5 seconds per benchmark. This suite has hundreds of benchmarks. Set a shorter time for a local check:

```bash
make cmp BENCH_TIME=100ms
```

## Color helpers

`color` checks that ValidGen's hex, rgb, rgba, hsl, and hsla helpers accept the same strings as go-playground/validator v10.28.0.

```bash
make color
```

## Regenerate

From a ValidGen checkout, point TestGen at this repository and generate the comparative cases:

```bash
export VALIDGEN_BENCHMARKS_DIR=/absolute/path/to/validgen-benchmarks
make testgen
```

That rewrites `cmp/generated_cmp_perf_no_pointer_test.go` and `cmp/generated_cmp_perf_pointer_test.go` from the templates in `cmp/`.

Then regenerate the ValidGen functions in this repository:

```bash
make regen
```

`make regen` runs `go tool validgen` on `bench` and `cmp`. Commit the generated Go files with the template output.

## License

MIT. See [LICENSE](LICENSE).
