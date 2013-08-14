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

This syntax module patches OCaml syntax to allow this.

Run with `make run_test`