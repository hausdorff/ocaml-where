# Ocaml `where`

Haskell's `where` is pretty great. Say you have a bunch of chained `let`s, like this:

```haskell
-- NOTE: Haskell code; computes (x + 2) * 2
foo x = let y = x+2
          let z = y*2
          in z
```

Gross! The `where` keyword lets you rewrite them in the following lovely, clean way:

```haskell
-- NOTE: Haskell code
foo x = z
  where y = x+2
        z = y*2
```

Surprisingly, OCaml doesn't support this syntax! So, I wrote this patch, which changes OCaml so that something like the `where` clause is allowed. For technical reasons (an important rule is right-associative), the syntax is somewhat different:

```ocaml
(* OCaml version *)
let foo x = z
  where y = x+2 and
        z = y*2
```

Note the use of `and` to separate bindings here. This is necessary between every binding:

```ocaml
(* Moar OCaml stuff *)
let foo x = x'''
  where x'   = x+2 and
        x''  = x'*2 and
        x''' = y''+2
```

You're welcome, hardcore `where` fans! :)


# Running the demo

Run with `make run_test`

The output will inform you that this code:

```
let x = z
  where y = 10 and
        z = 20
```

will desugar to this code:

```
let x =
  let y = 10 in
  let z = 20 in
  z
```

This is exactly what we desire---the `where` simply desugars into a list of `let`s.

So, how does this work? If you look at the makefile, you'll see the syntax extension (*i.e.*, `where.ml`) gets compiled and then linked in to compiling the test file (*i.e.*, `test.ml`) at compile time.


# What do all these files do?

`where.ml` is where the magic happens---this implements our syntax extension, and can be compiled down to a `.cmo` file. This can then be linked into any project you want to use the `where` keyword in, and it should just work.

`test.ml` is the test file that our demo uses to demonstrate how our extension cleanly desugars down into a chain of `let`s.

`META` and `_tags` make compilation easy---they automatically include stuff we want and need, and tell the OCaml build utilities what's up about all the stuff we're using.



# LICENSE

Because I like you and we're friends, I've chosen to distribute this under MIT. Basically, this means that you can this code for pretty much anything, you just have to keep a note on the code that I wrote, which says I wrote the code. You don't have to acknowledge me in the product or anything. Just the code. It's a pretty friendly license.


## MIT License

Copyright (C) 2013 Alex Clemmer <clemmer.alexander@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.