#import "@preview/touying:0.5.3": *
#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"
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
    date: [11 December 2024],
    institution: [Massachusetts Institute of Technology (#smallcaps("mit"))]
  )
)

#set heading(numbering: "1.1")
#show heading.where(level: 1): set heading(numbering: "1.")
#show figure.caption: emph

#let vec = sym => math.bold(math.upright(sym))
#let unit = sym => math.hat(vec(sym))

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

== Homeomorphisms

#grid(
  columns: (350pt, auto),
  rows: auto,
  grid.cell()[
    #image("assets/local.png", height: 75%)
  ],
  grid.cell()[
  	#image("assets/homeomorphism.png", height: 75%)
  ]
)

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

*Note*: If a $k$ manifold is embedded in $n$ space ($RR^n$), we must have $n>=k$ (this is a trivial consequence of an advanced mathematical technique called "visualization")

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

#image("assets/spacetime.jpg", height: 45%)

== Differential Forms

#quote(attribution: "Emil Artin")[It is my experience that proofs involving matrices can be shortened by 50% if one throws the matrices out.]

#pause

Remember *determinants*?

#pause

Forget everything you've learned about computing the determinant algebraically.\
#pause
#text(size: 12pt)[(These follow trivially from the general definition of the wedge product presented here.)]

#pause

Now, consider the most abstract geometric properties the determinant should have.

== Wedge Products and Bivectors

Determinants tell you how much the area of a unit square scales under some linear transformation $T$ (*bivectors* generalize this to any coordinate system).

#pause

#let empty = v => ""

#grid(
  columns: (200pt, auto),
  rows: auto,
  grid.cell(
    cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(size: (4, 4), x-tick-step: 1, y-tick-step: 1,
      x-format: empty, y-format: empty,
      axis-style: "left",
      x-min: 0, x-max: 4, x-grid: true,
      y-min: 0, y-max: 4, y-grid: "both", {
        plot.annotate({
          rect((0, 0), (2, 2), fill: rgb(25,102,255,128))
          content((1, 1), [#text(size: 12pt)[$vec(e_1) and vec(e_2)$]])
        })
      })
    })
  ),
  grid.cell(
    cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(size: (4, 4), x-tick-step: 1, y-tick-step: 1,
      x-format: empty, y-format: empty,
      axis-style: "left",
      x-min: 0, x-max: 4, x-grid: true,
      y-min: 0, y-max: 4, y-grid: "both", {
        plot.add-fill-between(style: (fill: rgb(153, 235, 255), stroke: black), domain: (0, 3/2), x => 2 * x, x => x / 2)
        plot.add-fill-between(style: (fill: rgb(153, 235, 255), stroke: black), domain: (3/2, 3), x => 3 - 3 / 4 + x / 2, x => 3 / 4 - 3 + 2 * x)
        plot.annotate({
          content((4, 1), [#text(size: 14pt)[$(det T)(vec(e_1) and vec(e_2))$]])
        })
      })
    })
  )
)

== Bivectors

- Bivectors are formed using a very scary operator called the *wedge product*.

#pause

- Wedge products between any two vectors $vec(a)$ and $vec(b)$ exist in a vector space (we are free to define the basis vectors, but they look like some wedge product, e.g. $vec(e_1) and vec(e_2)$

== Multivolumes

- Because the multivolume of a parallelotope (as a function of its side vectors) is multilinear\*, we can (mathematicians would say _trivially_ even though this is very quixotic) derive the following algebraic properties:

#pause

#text(size: 12pt)[Not technically true, as we'll see later--we're actually dealing with signed multivolumes]

#pause

$c (vec(a) and vec(b)) = c vec(a) and vec(b) = vec(a) and c vec(b)$

#pause

$vec(a) and (vec(b) + vec(c)) = vec(a) and vec(b) + vec(a) and vec(c)$

#pause

*Multilinearity!*

== Properties of the Wedge Product

There are some others, too:

#pause

$vec(a) and vec(a) = 0$

_Parallelogram where opposite sides are the same is degenerate; area is zero_

#pause

$vec(a) and vec(b) = -vec(b) and vec(a)$

_This follows from the previous properties; this is why the determinant is *antisymmetric*!_

== Interesting Derivation of Antisymmetry Property

By the fact that $vec(u) and vec(u) = 0$, we have:

$(vec(a) + vec(b)) and (vec(a) + vec(b)) = 0$ #h(10pt) ($vec(u) = vec(a) + vec(b)$)

Distribute!

$vec(a) and vec(a) + vec(a) and vec(b) + vec(b) and vec(a) + vec(b) and vec(b) = 0$

Use $vec(u) and vec(u) = 0$ again! (but for different $vec(u)$)

$vec(a) and vec(b) + vec(b) and vec(a) = 0$\
$vec(a) and vec(b) = -vec(b) and vec(a)$

Only the *signed multivolume* of a parallelotope as a function of its side vectors is multilinear.

== Integration over 1 Manifolds

For a 1 manifold, we integrate over a 1-form that looks like $d x$.\

#pause

- In 1 dimension, this is a standard integral $integral f(x) space d x$

#pause

- In $n$ dimensions (where $n > 1$), you learned about this as a *line integral*:\ $integral_C space vec(f)(t) dot (d vec(r)(t))/(d t) space d t$

#pause

#v(12pt)

Notice the dimension of $f$ changes with $n$--there are $n$ differentials in $n$ dimensions, and we can integrate only over 1 manifolds using a 1 form.

#pause

#v(12pt)

Line integrals are really just:

$integral space (f_1(t) space d vec(e_1) + f_2(t) space d vec(e_2) + dots.h.c + f_n space d vec(e_n)) $

== Integration over 2 Manifolds

For a 2 manifold, we integrate over a 2-form that looks like $d x space d y$ ($d x and d y$ in disguise).\

#pause

- In 2 dimensions, an example is a surface integral (for calculating flux) $integral.double vec(f)(x, y) dot vec(n) space d S$

#pause

- A general integral over a 2 manifold in 2 dimensions looks like:\ $integral vec(f)(u, v) space d u and d v$

#pause

#v(12pt)

We can integrate over any surface of an $n$ dimensional space, where our differential is a *bivector* formed by two of $d vec(e_1)$, ..., $d vec(e_n)$.
There are therefore $mat(n; 2)$ differentials that make up the 2-form in $n$ space, and the function $vec(f)$ we integrate over must have this dimension.

#pause

#v(12pt)

$integral space (f_1(u, v) space d vec(e_1) and vec(e_2) + dots.h.c + f_2(u, v) space d vec(e_1) and vec(e_n) + dots.h.c + f_(n)(u, v) space d vec(e_(n-1)) and vec(e_n)) $

== Flux

What are we _actually_ doing when we calculate *flux*?

#pause

- Note that we always calculate the flux of a vector field $vec(F)$ (dim 3) over a surface (dim 2) embedded in $x y z$ space (dim 3).

- Note also that $mat(3; 2) = 3$, the dimension of $vec(F)$, as we would expect.

#pause

There are three differentials that make up the 2-form in $x y z$ space: $d x and d y$, $d x and d z$, and $d y and d z$.

#pause

Let $vec(F) = angle.l A(x,y,z), B(x,y,z), C(x,y,z) angle.r$. We will calculate the flux outward through each surface in the 2-form.
We will talk more about orientation later, but for the purpose of flux, we define the normal vector as being the cross product of two surface vectors (with right hand rule).

== Surface Integrals

#grid(
  columns: (350pt, auto),
  rows: auto,
  grid.cell(
    cetz.canvas({
      import cetz.draw: *

      line((0,0,0),(6,0,0), mark: (end: "stealth"))
      line((0,0,0),(0,6,0), mark: (end: "stealth"))
      line((0,0,0),(0,0,6), mark: (end: "stealth"))

      line((0,0,0),(3,0,0),(3,0,3),(0,0,3),(0,0,0), fill: blue)
      line((0,0,0),(3,0,0),(3,3,0),(0,3,0),(0,0,0), fill: green)
      line((0,0,0),(0,3,0),(0,3,3),(0,0,3),(0,0,0), fill: red)

      content((3/2,0,3/2))[#text($bold(d x and d y)$, fill: white)]
      content((3/2,3/2,0))[#text($bold(d y and d z)$, fill: white)]
      content((-5/2,3/2,3/2))[#text($bold(d x and d z)$, fill: black)]

      line((3/2,0,1),(3/2,2,1), stroke: blue.darken(50%) + 5pt, mark: (end: "stealth"))
      line((1,5/2,0),(1,5/2,2), stroke: green.darken(50%) + 5pt, mark: (end: "stealth"))
      line((0,2,3/2),(-2,2,3/2), stroke: red.darken(50%) + 5pt, mark: (end: "stealth"))

      content((5,1,0))[$y$]
      content((1,0,5))[$x$]
      content((1,5,0))[$z$]
    })
  ),
  grid.cell(
    cetz.canvas({
      import cetz.draw: *

      line((0,0,0),(6,0,0), mark: (end: "stealth"))
      line((0,0,0),(0,6,0), mark: (end: "stealth"))
      line((0,0,0),(0,0,6), mark: (end: "stealth"))

      line((0,0,0),(3,0,0),(3,0,3),(0,0,3),(0,0,0), fill: blue)
      line((0,0,0),(3,0,0),(3,3,0),(0,3,0),(0,0,0), fill: green)
      line((0,0,0),(0,3,0),(0,3,3),(0,0,3),(0,0,0), fill: red)

      content((3/2,0,3/2))[#text($bold(d x and d y)$, fill: white)]
      content((3/2,3/2,0))[#text($bold(d y and d z)$, fill: white)]
      content((-5/2,3/2,3/2))[#text($bold(d z and d x)$, fill: black)]

      line((3/2,0,1),(3/2,2,1), stroke: blue.darken(50%) + 5pt, mark: (end: "stealth"))
      line((1,5/2,0),(1,5/2,2), stroke: green.darken(50%) + 5pt, mark: (end: "stealth"))
      line((0,2,2),(2,2,2), stroke: red.darken(50%) + 5pt, mark: (end: "stealth"))

      content((5,1,0))[$y$]
      content((1,0,5))[$x$]
      content((1,5,0))[$z$]
    })
  )
)

#v(6pt)

We want flux to be positive when anything "enters" this cube and negative when stuff "leaves"--but the mathematics of differential forms allow us to integrate any way we like

== The Flux Integral

$integral (A(x,y,z) space d y and d z + B(x,y,z) space d z and d x + C(x,y,z) space d x and d y)$

#pause

$integral angle.l A(x,y,z), B(x,y,z), C(x,y,z) angle.r dot angle.l d y and d z, d z and d x, d x and d y angle.r$

#pause

$integral vec(F) dot angle.l d y and d z, d z and d x, d x and d y angle.r$

#pause

#v(12pt)

How do we calculate such a monstrosity?\
What is the meaning of this abstract nonsense?

== The Pullback

#grid(
  columns: (350pt, auto),
  rows: auto,
  grid.cell([
    #image("assets/wedge.jpg", height: 80%)
  ]),
  grid.cell([
    - There is no going back after this (your mind may be warped by upcoming abstractions)

    #pause

    - We note that we can represent $bold(F)$, a 2 manifold, using a 2 dimensional parameterization in terms of $u, v$

    #pause

    - We now need to "convert" $d y and d z$, $d z and d x$, $d x and d y$ to $d u and d v$
  ])
)

== Mathematical Maneuvering

#v(18pt)

- Remember that a manifold is *homeomorphic* to a Euclidean space (in this case, $RR^2$). This means there exists a mapping\* $x,y,z arrow.r u,v$, so we can write $u(x,y,z), v(x,y,z)$.

#text(size: 14pt)[\*where $x,y,z$ are in some subset of $RR^3$ (occupied by the manifold)]

- This mapping is called a "*chart*," which is part of an "*atlas*" for the manifold
  - Mathematicians take this map analogy very seriously because they cannot distinguish between homeomorphic objects in real life

#quote(attribution: "René Thom (itinerant theoretician)")[
  Topology is precisely the mathematical discipline that allows the passage from local to global…
]

Don't let your mind be warped by these abstractions!

=== Computation

- Given $u(x,y,z),v(x,y,z)$ and $bold(F)(u,v)$, consider the inverse map $u,v arrow.r x,y,z$ that must also exist by the conditions of *homeomorphism* to find $x(u,v),y(u,v),z(u,v)$.

- Now, take differentials using the chain rule:

$d x = (partial x)/(partial u) space d u + (partial x)/(partial v) space d v$,
$d y = (partial y)/(partial u) space d u + (partial y)/(partial v) space d v$,
$d z = (partial z)/(partial u) space d u + (partial z)/(partial v) space d v$

- We can now use the properties of the *wedge product* to evaluate any product of $d x$, $d y$, and $d z$ in terms of either $d u and d v$ or $d v and d u$ (but remember $d v and d u = -d u and d v$).

- This gives an integral of the form:

$integral bold(G)(u, v) space d u and d v =$
$integral.double bold(G)(u, v) space d u space d v$

== Integration with Differential Forms

- What we just did was construct a specific integral for a 2 manifold in 3 space, but this procedure can in general be done for a $k$ manifold in $n$ space, where the function we are integrating has dimension $mat(n; k)$.

#pause

- We can also take wedge products of more than 2 vectors to get multivectors, but these have only two canonical orientations
  - More on this later, but for now just know that we can always flip terms to get them in a certain order by multiplying either by $1$, positive orientation, or $-1$, negative orientation

== Notational Hacks

- We call the entire expression after the integral sign, when expressed with multivectors, a *differential form*, commonly denoted $omega$
  - Note that multivectors won't always have a wedge product symbol (for one or zero (we'll encounter those later) manifolds we only need a differential or scalar, respectively)
  - Common notation is to use $omega$ for a differential form and $Omega$ for a manifold, just to be extra confusing

#pause

- We use a completely made-up, contrived operation called the *pullback* to turn this abstract mess of symbols into a readable integral we can evaluate
  - Basically, use an intrinsic coordinate system that represents the manifold itself and not the space it's embedded in

== Mandatory Content Warning

#v(24pt)

#image("assets/category-theorist.png", height: 90%)

== Orientability

Before we continue,

#pause

#quote(attribution: "George Polya")[
  A mathematician who can only generalise is like a monkey who can only climb up a tree, and a mathematician who can only specialise is like a monkey who can only climb down a tree. In fact neither the up monkey nor the down monkey is a viable creature. A real monkey must find food and escape his enemies and so must be able to incessantly climb up and down. A real mathematician must be able to generalise and specialise.
]

== Differential Forms and Orientability

- The *antisymmetry* property of differential forms give us a convenient way to determine the orientation of a parameterization of some manifold.

#pause

- The sign of the wedge product coefficient after converting to a "*positively-oriented form*" gives the orientation of a given representation

#pause

#v(12pt)

- In 1 space, we say the canonical positively oriented form is $d x$
- In 2 space, it is $d x and d y$, by convention
- In 3 space, $d x and d y and d z$

#pause

#v(12pt)

More on 0 space later ...

== Boundaries

#grid(
  columns: (350pt, auto),
  rows: auto,
  grid.cell([
    #image("assets/boundary.png", height: 60%)
  ]),
  grid.cell([
    - To define the boundary, we consider *homeomorphic equivalence classes*

    #pause

    - Specifically, a point within a $k$ manifold $M$ will have a local neighborhood of points homeomorphic to a $k$ ball

    #pause

    - At the boundary, points have a local neighborhood homeomorphic to a half $k$ ball
  ])
)

== Properties of Boundaries

*The boundary of a $k$ manifold is a set of closed $k-1$ manifolds*

#pause

#quote(attribution: "Henry Whitehead")[
  "It is the snobbishness of the young to suppose that a theorem is trivial because the proof is trivial."
]

== Proof of Properties of a Boundary

If you're interested:

#text(size: 14pt)[
our definition $=> exists space phi: U -> HH^k$ where $U$ is the neighborhood of points around some $P in partial M$ and $HH^k$ is a half $k$ ball, formally defined as $HH^k = {x in RR^k | x_k >= 0}$ for some intrinsic coordinate system where $x_k = 0$ for points along the boundary in $U$ (otherwise a local neighborhood around these points would be homeomorphic to $RR^k$, not $HH^k$).\*
Thus, $partial M$ (around $P$) is homeomorphic to ${x in HH^k | x_k = 0}$, which is homeomorphic to $RR^(k-1)$ (simply reparameterize by eliminating $x_k$ and keeping all other parameters the same--for the inverse map add $x_k = 0$).
We'll later see how to prove this boundary is closed using Generalized Stokes Theorem!\

#v(6pt)

#text(size: 10pt)[\*These are quite shaky foundations indeed, but a full proof would result in too much brain damage to present in its entirety.]
]

== Induced Orientations

#grid(
  columns: (250pt, auto),
  rows: auto,
  grid.cell([
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(size: (6, 6), x-tick-step: 1/2, y-tick-step: 1/2,
      x-format: empty, y-format: empty,
      axis-style: "school-book",
      x-min: -3/2, x-max: 3/2, x-grid: true,
      y-min: -3/2, y-max: 3/2, y-grid: "both", {
        plot.annotate({
          circle((0, 0), radius: 1, fill: rgb(25,102,255,128), stroke: 3pt + rgb(25,50,150))
          content((-1/4, -1/2), [#text(size: 20pt)[$bold(M)$]])
          content((5/4, 3/4), [#text(size: 20pt)[$bold(partial M)$]])
          line((0, 1), (-1, 1), stroke: 3pt + purple, mark: (end: "stealth"))
          line((0, 1), (0, 7/4), stroke: 3pt + orange, mark: (end: "stealth"))
          line((0, 1), (0, 1/4), stroke: 3pt + orange, mark: (end: "stealth"))
          rect((0, 1), (-3/4, 3/2), stroke: 5pt + gradient.linear(purple, orange, angle: 45deg))
          content((1/4, 5/4))[$vec(n)$]
          content((-1/2, 5/8))[$vec(T_1)$]
          content((-2, 5/4))[$bold(vec(n) and vec(T_1))$]
          line((-11/8, 5/4), (-1/4, 5/4), mark: (end: "stealth"))
        })
      })
    })
  ]),
  grid.cell([
    - When we have an $n$ manifold $M$ with a known positive orientation in $n$ space, we can determine the orientation of its boundary $partial M$ (its "*induced orientation*")

    #pause

    - For each parameter defining $partial M$ (in this case there is only one, $t$), draw the tangent vector $T$ (which for this $M$ we can write as $(d vec(r))/(d t) d t$ where $vec(r)$ is the mapping from 1-dimensional $t$ space to the $partial M$ manifold embedded in 2 space

    #pause

    - Compute the normal vector $vec(n)$ orthogonal to all tangent vectors and not pointing into $M$
  ])
)

== Induced Orientations and Wedge Products

- Now, write $vec(n) and vec(T_1)$ as some expression of the form $A space d x and d y$, where $d x and d y$ is the known positive orientation of $M$.

#pause

- The orientation of $partial M$ is given by $op("sign")(A)$
  - Note that this is either _positive_ or _negative_ (there are only ever 2 canonical orientations of a manifold, regardless of dimension)

== Induced Orientation in Arbitrary Dimensions

Summarizing what we did, for an $n$ manifold in $n$ space:\
#pause
#text(size: 12pt)[(and casually making rigorous use of infinitesimals)]

#pause

- Since $partial M$ is a $n - 1$ manifold, there exists some parameterization $phi(x_1, ..., x_(n-1)): RR^(n-1) -> RR^n$

#pause

- Consider all tangent vectors of the form $vec(T_(x_i))$, given by $(partial vec(phi))/(partial x_i) x_i$

#pause

- Compute the normal vector $vec(n)$ satisfying $vec(n) dot vec(T_(x_i)) = 0 space forall space vec(T_(x_i))$ and $vec(n) dot d vec(rho) < 0$ where $vec(rho)$ is a basis vector of $T_P M$ not along $partial M$ and $T_P M$ is the tangent space of $M$

#pause

- Express $vec(n) and T_(x_1) and ... and T_(x_(n-1))$ in the form $A space T_(x_1) and ... and T_(x_n)$ where $d T_(x_1) and ... and d T_(x_n)$ is the canonical positive orientation of $M$

#pause

- The orientation of point $P$ is given by $op("sign")(A)$

== The Prototypical Non-Orientable Surface

#figure(
  image("assets/mobius.jpg", height: 90%),
  caption: [Not possible to define a unique $vec(n)$ for every point (any point) on the surface]
)

== Exterior Derivative

Consider a nasty differential form like:

$omega = M(x,y,z) space d y and d z + N(x,y,z) space d z and d x + P(x,y,z) space d x and d y$

where $vec(F) = angle.l M(x,y,z), N(x,y,z), P(x,y,z) angle.r$ (remember flux??)

#pause

Can we _differentiate_ $omega$?

== Digression to Introduce the Scale of the Problem

#quote(attribution: "G. Moore and N. Seiberg, 1989")[
  We will need to use some very simple notions of category theory, an *esoteric subject* noted for its *difficulty* and *irrelevance*.
]

#pause

What we want to do is turn an $n$ form into an $n+1$ form.

#pause

=== Why?

Because we still want to integrate the resulting form (we want a differential, not a derivative)!
Think of how, in 1 dimension, we take $f(x) -> f'(x) space d x$ to produce a differential we can integrate over.

#pause

You should be thinking of the Fundamental Theorem of Calculus right now\
#text(size: 14pt)[(we'll get back to this).]

== Definition of the Exterior Derivative

#tblock(title: "Exterior Derivative")[
  Given an $n$ form $omega = f space d x_1 and ... and d x_n$, we define the exterior derivative $d omega =  d f and d x_1 and ... and d x_n$, an $n+1$ form (trivial to see given we have added another wedge product and $d f$ is a 1 form)
]

#pause

Back to our example (let $cal(D) = angle.l d x, d y, d z angle.r$),

#pause

$d omega = (nabla f dot cal(D)) and d y and d z + (nabla g dot cal(D)) and d z and d x + (nabla h dot cal(D)) and d x and d y$

#pause

Terms of the form $d a and ... and d a ... and d b = 0$, so we exclude them:

#pause

$d omega = f_x space d x and d y and d z + g_y space d y and d z and d x + h_z space d z and d x and d y$\
$d omega = (f_x + g_y + h_z) space d x and d y and d z$

== Powers of the Exterior Derivative

*That looks familiar!*

#pause

It's $op("div") vec(F) space d V$ (using the fact that $d V = d x and d y and d z$)

#pause

- Flux becomes divergence?
- Where have you seen this before??

== Stokes Theorem

#grid(
  columns: (200pt, auto),
  rows: auto,
  grid.cell()[
    #image("assets/homotopy.jpg", height: 90%)
  ],
  grid.cell()[
    - How Generalized Stokes Theorem is actually defined using homotopy type theory

    - Involves topos theory and other abstract nonsense

    - We will stick to the algebraic topology definition, which is only slightly less deranged than the category theoretic one
  ]
)

== Generalized Stokes Theorem

#tblock(title: "Topological Definition of Generalized Stokes Theorem")[
  $ integral_(partial M) omega = integral_M d omega $
]

#pause

Absolute perfection.\
Nothing more remains to be said.\

#pause

#v(12pt)

This presentation could end here and you would leave\
knowing a fundamental truth of the universe.

= Some Examples

== Deriving Stokes Theorem from Generalized Stokes Theorem

Let's consider what Stokes Theorem tells us about a 2 manifold in 3 space:

#pause

$ integral_(partial M^1 subset RR^3) omega = integral_(M^2 subset RR^3) d omega $

#sym.arrow.t Abuse of notation to demonstrate what we mean

#pause

We know $omega$ must be a 1 form, but this isn't helpful until we can assign a value to $omega$.
To keep things simple, let's make the left-hand integral and line integral, so:

$omega = f(x,y,z) space d x + g(x,y,z) space d y + h(x,y,z) space d z$

$integral_(partial M) omega = integral_C vec(F) dot d vec(r)$ where $vec(F) = angle.l f(x,y,z), g(x,y,z), h(x,y,z) angle.r$

== Stokes Theorem, Revisited

We then have:

$d omega = (f_y space d y + f_z space d z) and d x + (g_x space d x + g_z space d z) and d y + (h_x space d x + h_y space d y) and d z$\
$d omega = (g_x - f_y) space d x and d y + (f_z - h_x) space d z and d x + (h_y - g_z) space d y and d z $

#pause

Hey that looks familiar!

#pause

$d omega = op("curl")(vec(F)) dot unit(n) space d S$

It's the *flux* of the *curl* of $vec(F)$!!

#pause

By Generalized Stokes,

$ integral_(partial M) omega = integral_M d omega => integral_C vec(F) dot d vec(r) = integral_S op("curl")(vec(F)) dot unit(n) space d S $

== An Interesting Example Involving Stokes Theorem

#let C1 = text(fill: rgb("#388c46"))[$bold(C_1)$]
#let C2 = text(fill: rgb("#fa7e19"))[$bold(C_2)$]

#grid(
  columns: (300pt, auto),
  rows: auto,
  grid.cell()[
    #image("assets/cylinder.png", width: 90%)
  ],
  grid.cell()[
    - Using a clever choice of $vec(F)$, we will show that the orientation of the boundaries at opposite ends of a cylinder are opposite each other.

    - Note that $partial M$ consists of two manifolds #C1, #C2

    - $integral_(partial M) omega = epsilon_1 integral_(#C1) omega + epsilon_2 integral_(#C2) omega$ where $epsilon_1$, $epsilon_2$ are the orientations of #C1 and #C2, respectively
  ]
)

== Orientation Theory

We want to show $epsilon_1 = -epsilon_2$ or $epsilon_1 + epsilon_2 = 0$.

#pause

If we could write $epsilon_1 integral_(#C1) omega + epsilon_2 integral_(#C2) omega$ as $(epsilon_1 + epsilon_2) integral_C omega$ for some $C$, then we derive a constraint for $epsilon_1 + epsilon_2$ using Stokes Theorem.
For this to happen, we need $integral_(#C1) omega = integral_(#C2) omega = integral_C omega$ (i.e. the line integral of $vec(F)$ over either #C1 or #C2 gives the same result.

#pause

#v(12pt)

This tells us $vec(F)$ is independent of $z$.
Since #C1 and #C2 occupy the same region of $x y$ space, if $vec(F)$ depends only on these two parameters, the line integrals over #C1 and #C2 are equivalent and we can factor our $epsilon_1 + epsilon_2$ from the boundary integral.

== Stokes Theorem and Orientation

For some $vec(F)(x,y)$ on $M$, Stokes Theorem tells us

$integral_(partial M) omega = epsilon_1 integral_(#C1) omega + epsilon_2 integral_(#C2) omega = (epsilon_1 + epsilon_2) integral_(#C1) omega = integral_M d omega = integral_S op("curl")(vec(F)) dot unit(n) space d S$

#pause

If $epsilon_1 + epsilon_2 = 0$ as we supposed,

$(epsilon_1 + epsilon_2) integral_(#C1) omega = 0 = integral_S op("curl")(vec(F)) dot unit(n) space d S$

#pause

Hence, in order to prove $epsilon_1 + epsilon_2 = 0$, we must choose $vec(F)(x,y) | integral_S op("curl")(vec(F)) dot unit(n) space d S = 0$.\
The beauty of this is that we can choose _any_ differential form $omega$ and Generalized Stokes Theorem must still hold (in the case of the 3-dimensional Stokes Theorem, it means we can choose any $vec(F)$ since the abstraction of differential forms has been thrown out).

== Completing the Proof (Example)

#let F_S = text(fill: rgb("#6042a6"))[$op("curl")(vec(F))$]
#let n_S = text(fill: rgb("#c6433f"))[$unit(n)$]

#grid(
  columns: (300pt, auto),
  rows: auto,
  grid.cell()[
  	#image("assets/field.png")
  ],
  grid.cell()[
  	- Consider #F_S pointing vertically upward (or downward)

	#pause

  	- We see that $#F_S dot #n_S = 0$, so we must have $integral_S #F_S dot #n_S space d S = 0$

	#pause

  	- When is this true? Whenever $vec(F)$ lies in the $x y$ plane (i.e. $h = 0 | h_x, h_y, h_z = 0$ and, by the fact that $vec(F)$ is a function of $x$ and $y$ only, $f_z, g_z = 0$).
  ]
)

== Recap of Stokes Theorem Example

- We found that some $vec(F)$ exists such that $integral_M d omega = 0$, so we conclude that $integral_(partial M) omega = 0$, by Stokes Theorem

#pause

- We can divide $partial M$ into two boundaries and, since the integral of $omega$ over both is the same, we can factor out the sum of the boundary orientations $epsilon_1 + epsilon_2$

#pause

- The fact that $integral_(partial M) = 0$ implies $epsilon_1 + epsilon_2 = 0 => epsilon_1 = -epsilon_2$

#pause

- *Therefore, the boundaries at opposite ends of a cylinder have opposite orientations*!

== The Power of Stokes

#figure(
  caption: [Literally the sole use of Stokes Theorem\ (not _Generalized Stokes Theorem_, which is much more powerful, as we'll see)]
)[
  #image("assets/stonks.png", height: 80%)
]

= Applications?

== Reality Check

#quote(attribution: "Eric Temple Bell")[
  Guided only by their feeling for symmetry, simplicity, and generality, and an indefinable sense of the fitness of things, creative mathematicians now, as in the past, are inspired by the art of mathematics rather than by any prospect of ultimate usefulness.
]

#pause

*Questions we must answer*:

- Is Stokes Theorem truly useless?

- Have we as mathematicians failed in our quest to understand the universe?

- What is the nature of spacetime?

== The Nature of Manifolds and their Boundaries

To appreciate the true power of Stokes Theorem, consider this trivial application:

$ integral_(partial (partial M)) omega = integral_(partial M) d omega = integral_M d (d omega) = integral_M 0 = 0$

#pause

Therefore, we have concluded

$ integral_(partial (partial M)) omega = 0 space forall omega$

#pause

In other words, the integral of _anything_ over the boundary of the boundary of _any_ manifold $M$ is zero.
This is only possible if the manifold we are integrating over is the empty set $emptyset$.

== Closed Manifold Boundaries

Thus, the boundary of a manifold's boundary doesn't exist.

#pause

Phrased differently,

#tblock(title: "Proposition of Closed Manifold Boundaries")[
  The boundary of any manifold $M$, $partial M$, is *closed*.
]

where we say that a manifold is "closed" if it has no boundary.

#pause

Remember when we stated this?? (and didn't prove it)

== The Superiority of Generalized Stokes

#grid(
  columns: (500pt, auto),
  rows: auto,
  grid.cell()[
  	#image("assets/geometric-algebra.png", height: 67.5%)
  ],
  grid.cell()[
  	#image("assets/topos.jpg", height: 67.5%)
  ]
)

=== Higher Topological Powers

#figure(caption: "You have been lied to through all of calculus")[
  #image("assets/astronaut.png", height: 75%)
]

== Speedrunning Calculus with Generalized Stokes Theorem

"Novel" theorems (for higher-dimensional manifolds):

- Divergence Theorem
  - $M$ is a 3 manifold in 3 space
- Stokes Theorem (already derived)
  - $M$ is a 2 manifold in 3 space
- Green's Theorem
  - $M$ is a 2 manifold in 2 space

#pause

"Degenerate" theorems (for one or zero dimensional manifolds):

- Fundamental Theorem of Calculus
  - $M$ is a 1 manifold in 1 space

== Divergence Theorem

#v(16pt)

*$M$ is a 3 manifold in 3 space*

#pause

Let $omega = vec(F) dot angle.l d y and d z, d z and d x, d x and d y angle.r$ (2 form in 3 space), integrated over $partial M$

#pause

Compute $d omega$ to find $d omega = op("div")(vec(F)) space d x and d y and d z$

#pause

$M$ is a volume $V$, $partial M$ is its surface $S$, $omega$ is the flux of $vec(F)$ through $S$: $vec(F) dot unit(n) space d S$, $d omega = op("div")(vec(F)) space d V$

#pause

$ integral_(partial M) omega = integral_M d omega $

#pause

$ integral.double_S vec(F) dot unit(n) space d S = integral.triple_V op("div")(vec(F)) space d V $
#h(1fr)
$qed$

== Green's Theorem

#v(16pt)

*$M$ is a 2 manifold in 2 space*

#pause

Let $omega = vec(F) dot angle.l d x, d y angle.r$ (1 form in 2 space), integrated over $partial M$

#pause

Compute $d omega$ to find $d omega = op("curl")(vec(F)) space d x and d y$
#h(12pt)
#text(size: 12pt)[(here we only consider the $z$ component of curl, $N_x - M_y$)]

#pause

$M$ is an area $A$, $partial M$ is a curve $C$, $omega$ is the line integral of $vec(F)$ over $C$: $vec(F) dot d vec(r)$, $d omega = op("curl")(vec(F)) space d A$

#pause

$ integral_(partial M) omega = integral_M d omega $

$ integral_C vec(F) dot d vec(r) = integral.double_A op("curl")(vec(F)) space d A $
#h(1fr)
$qed$

== The Fundamental Theorem of Calculus

*$M$ is a 1 manifold in 1 space*

#pause

Let $omega = f(x)$ (0 form in 0 space), integrated over $partial M$

#pause

Compute $d omega$ to find $d omega = f'(x) space d x$

#pause

$M$ is an interval $[a, b]$, $partial M$ is a set of points ${a, b}$ with orientations ${epsilon_a, epsilon_b}$, $omega$ is the integral of $f(x)$ over that set of oriented points, $d omega = f'(x) space d x$

== Integration over the Zero Manifold

An integral over a continuous manifold is an infinite (Riemann) sum, where at each point we multiply the integrand by $d x$.
Essentially, we evaluate our differential form $omega$ at each point, but make sure to choose a positive orientation for all points in the manifold.
If a point is negatively oriented, we obtain the negative of the integral over the positively oriented point, so we multiply that integral by $-1$ to obtain the "positively oriented" integral value.

#pause

== Orientation of the Zero Manifold

=== What is the orientation of $bold({a, b})$ when $bold(d x)$ points from $bold(a)$ to $bold(b)$?

#pause

#v(24pt)

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  line((-4, 0), (14, 0), mark: (start: "stealth", end: "stealth"))
  line((1, 0.25), (1, -0.25))
  line((9, 0.25), (9, -0.25))

  line((1, 0), (4, 0), mark: (end: "stealth"), stroke: 4pt + blue)
  content((1+3/2, 1))[$d x$]

  line((1, 0), (-2, 0), mark: (end: "stealth"), stroke: 4pt + orange)
  content((1-3/2, 1))[$unit(n_a)$]

  line((9, 0), (12, 0), mark: (end: "stealth"), stroke: 4pt + orange)
  content((9+3/2, 1))[$unit(n_b)$]

  content((1, -1))[$a$]
  content((9, -1))[$b$]
})

#v(12pt)

#pause

Expressing $unit(n_a)$ in terms of $d x$ leads to a negative coefficient, so the orientation of $a$ is negative.
$unit(n_b)$ points in the same direction as $d x$, so it will have a positive coefficient when expressed as a multiple of $d x$, meaning it has positive orientation.

#pause

Notice how $a^+$ and $b^-$ have opposite orientations--*just like the cylinder!*

== Deriving the Fundamental Theorem of Calculus

$integral_(partial M) omega = integral_M d omega$\
$integral_{a, b} f(x) = integral_[a, b] f'(x) space d x$

#pause

#v(12pt)

We let $epsilon_a = -1$ and $epsilon_b = 1$ and evaluate the left integral:

$integral_{a, b} f(x) = epsilon_a f(a) + epsilon_b f(b) = -f(a) + f(b) = f(b) - f(a)$

#pause

#v(12pt)

Thus,

$ f(b) - f(a) = integral_a^b f'(x) space d x $
#h(1fr)
$qed$

== Final Words

#quote(attribution: "John Baez")[
  Category theory is the subject where you can leave the
  definitions as exercises.
]

#pause

#figure()[
  #image("assets/dirac.png", height: 60%)
]

== Thank you!

#figure(
  caption: "I'll try my best to avoid it"
)[
  #image("assets/postdoc.jpg", height: 90%)
]

#bibliography("refs.bib", title: "References", full: true, style: "chicago-author-date")

== Other References

- Separate discussions with Evan Chen PhD \u{0027}25 and Angelo Farfan \u{0027}28

- MIT OpenCourseWare 18.02 Lecture on Stokes Theorem

- Mathematical Folklore
