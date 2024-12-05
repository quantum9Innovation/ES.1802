#import "@preview/touying:0.5.3": *
#import themes.stargazer: *

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  header-right: rect(
    none, fill: gradient.linear(color.rgb(0, 91, 172), black),
    width: (100% + 50pt), height: 100pt
  ),
  config-info(
    title: [Stokes Theorem as Generalized Abstract Vapid Nonsense],
    subtitle: [
      "We'll only use as much category theory as is necessary.\ [_famous last words_]"
      --Roman Abramovich
      #footnote[Attribution:
        #link("https://christiansaemann.de/talksfolder/5.12.2017%20Dublin%20Institute%20for%20Advanced%20Studies.pdf")["Higher Gauge Theory: The Fundamentals"] (quote is almost certainly misattributed to a Russian oligarch instead of the algebraic geometrist who is likely responsible for it)
      ]
    ],
    author: [Ananth Venkatesh],
    date: datetime.today(),
    institution: [Massachusetts Institute of Technology (#smallcaps("mit"))]
  )
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set heading(numbering: "1.")
#show figure.caption: emph

#title-slide()

= Stokes Theorem

== Manifolds

#set quote(block: true)
#quote(attribution: "Henri Poincaré")[Geometry is the art of correct reasoning from incorrectly drawn figures.]

#pause

*Manifolds are (very special) sets (of points)*

#pause

- Manifolds are just a continuous set of points

#pause

- Moreover, at any given point, they look like a *Euclidean space*

== Euclidean Spaces

- You know them as $RR^n$ i.e. *vector spaces* (roughly speaking)

#pause

- Euclidean space is the space we inhabit (not the full story; more on this later)

#pause

#v(12pt)

*What actually is a manifold then?*

#pause

- When we say that a manifold "looks like" a Euclidean space, we're actually talking about *homeomorphism*

== General Topology

#v(12pt)

#image("assets/top.jpg", width: 45%)

#v(12pt)

- Topologists do not understand shapes, so they must deform objects into meaningless blobs to count holes

- Two numbers are equal, but two topological spaces are *homeomorphic* to each other

=== Definitions

#tblock(title: "Homeomorphism")[
  A pair of continuous bijective (all $x in X$ in the domain of $f$ and all $y in Y$ in the range of $f$) mappings $f: X --> Y$ and $f^(-1): Y --> X$
]

#tblock(title: "Homeomorphic equivalence")[
  Two topological objects $X$ and $Y$ are homeomorphic to each other iff there exists a *homeomorphism* between them.
]

== Formalizing the Manifold

=== Definitions

Read: more abstract nonsense

#tblock(title: "Manifold")[
  A $k$ (represents intrinsic dimension) manifold is a continuous set of points $X$ *homeomorphic* to $RR^k$
]

#tblock(title: "Embedding")[
  The embedding of a manifold $X$ is $n$ iff $x in RR^n space forall x in X$
]

*Note*: If a $k$ manifold is embedded in $n$ space ($RR^n$), we must have $n>k$ (this is a trivial consequence of an advanced mathematical technique called "visualization")

== Manifolds in the Wild

#figure(
    grid(
        columns: (auto, auto),
        rows:    (auto, auto),
        gutter: 1em,
        [ #image("assets/torus.jpg", height: 125pt) ],
        [ #image("assets/lorenz.png", height: 125pt) ],
        [ #image("assets/area.png", height: 125pt) ],
        [ #image("assets/hypercube.svg", height: 125pt) ],
    ),
    caption: [_From left to right, top to bottom_: A 2 manifold in 3 space, a 1 manifold in 3 space, \ a 2 manifold in 2 space, and a 2 manifold in 4 space (projected onto 3 space--the drawing is of a hypercube)]
) <manifolds>

=== The Prototypical Example of a Manifold

#figure(
  caption: [Don't ask me what this is because I am just as clueless as you]
)[
  #image("assets/abramovic.png", height: 75%)
] <manifolds>

== The Universe

#v(12pt)

We live in a *3 manifold* (possibly embedded in a _higher dimensional_ space--and we have no way of knowing)!

Completely irrelevant to understanding Generalized Stokes Theorem, but very cool nevertheless.

#image("assets/spacetime.jpg", height: 60%)

== Differential Forms

== Orientability

== Boundaries

== Exterior Derivative

== Generalized Stokes Theorem

= Some Examples

= Applications?
