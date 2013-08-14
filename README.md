# Ocaml `where`

Haskell's `where` is pretty great. If you have a bunch of chained `let`s, like this:

```haskell
-- computes (x + 2) * 2
foo x = let y = x+2
          let z = y*2
          in z
```

… and write them much cleaner here:

```haskell
foo x = z
  where y = x+2
        z = y*2
```

Surprisingly, OCaml doesn't support this syntax!

So, I wrote this patch, which changes OCaml so that the `where` clause is allowed.

You're welcome, Haskellites.

# Running the demo

Run with `make run_test`

The output will look something like this:

```
Should desugar where into a let:
Catting test.ml
let x = y
  where y = 10
Desugared version
let x = let y = 10 in y
```

If you look at the makefile, you'll see the patch gets compiled and then linked in at compile time. The upper program is the original source, and the bottom is the desugared source---the `where` simply and cleanly decomposes to a chain of `let`s.