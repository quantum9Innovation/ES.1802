# ES.1802

Grant Sanderson, before this repository was created:

> Ah yes, a "full story of Stokes", from telescoping sums all the way to differential forms, is one item I have on the list

This repository contains a (mostly nonsensical) presentation of Generalized Stokes Theorem and other forms of abstract nonsense.
I make no guarantees of its comprehensibility, but I did present it as part of my [ES.1802](https://student.mit.edu/catalog/archive/fall/search.cgi?search=ES.1802&style=verbatim) final project at some point.
If you note any mathematical errors or have suggestions for expository or ludicrous additions, feel free to contribute to this repository or [open an issue](https://github.com/quantum9Innovation/ES.1802/issues/new).
I will likely not be maintaining this as it is a static document, but I do appreciate contributions from others!

[ES.1802 Final Project Presentation on Generalized Stokes Theorem](https://github.com/quantum9Innovation/ES.1802) © 2024 by [Ananth Venkatesh](https://web.mit.edu/ananthv/www/) is licensed under [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1)

## Licensing

You are free (and encouraged) to **redistribute** any product of this work in any form, but you must provide appropriate **attribution** by linking to the original (use <https://github.com/quantum9innovation/ES.1802>).
You may not relicense this work, regardless of how you distribute it.

Essentially, this work is and must remain **open access** and the original should be cited wherever used (so viewers may determine originality).

## Building

This project uses the [Nix build system](https://nixos.org/) with [Typix](https://loqusion.github.io/typix/) for declarative and reproducible [Typst](https://typst.app/) document builds.
[Touying](https://touying-typ.github.io/) is used for creating and organizing the slides in this presentation.
Run the following commands to build and preview the final presentation:

```sh
cd src
nix run .#build
```

Open [src/main.pdf](./src/main.pdf) to see the result.
If you use `nix run .#watch`, changes will be automatically applied as you save [src/main.typ](./src/main.typ).
