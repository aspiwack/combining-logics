#let title = [Combining Logics]
#let author = [Arnaud Spiwack]

// Styling the page
#set page(margin: 1.75in)
#set par(leading: 0.55em, first-line-indent: 1.8em, justify: true)
#show par: set block(spacing: 0.55em)
#show heading: set block(above: 1.4em, below: 1em)
#set heading(numbering: "1.1  ")
#show heading.where(level: 1): it => [
  #pagebreak(weak: true)
  #block[Chapter #counter(heading).display() #it.body]
]
#set ref(supplement: it => {
  if it.func() == heading and it.level == 1 {
    "Chapter"
  }
  else {
    it.supplement
  }
})

// Front matter
#align(center, text(21pt)[*#title*])
#align(center, text(16pt)[#author])
#align(center)[Version compiled on #datetime.today().display()]

= Simple logics
<cha:simple-logics>
== Notations
#label("notations")
Inference rules interpreted as Galois connections.

In judgements, only one hypothesis and one conclusion.

== Propositional logic
#label("propositional-logic")
Structures:

-  Lattices

-  Complete Lattices

-  Heyting algebras

-  Complete Heyting algebras

-  (Ordered) residuated commutative monoid (#emph[i.e.] multiplicative
  intuitionistic linear logic) (which can also be any lattice structures
  in a different way!)

Constructions:

-  $cal(P) A$

-  $A arrow.r cal(H)$ for any (complete?) lattice

-  Sum, products (I have no applications for these; note that
  (cartesian) product is $cal(P) 2$)

-  The separation logic partial commutative monoid thing

-  Chu construction

-  Step indexing (I’m not very knowledgeable about this one;
  fundamentally, it’s about doing constructions in the topos of trees,
  but I don’t know how to work with them in "normal maths")

== First order logics and nominal Set
#label("first-order-logics-and-nominal-set")
Note: untyped values.

Fix a set $cal(X)$ of variables.

Structures:

-  Same as above but in the category of nominal sets

-  Doesn’t have a name, but support for $forall$, $exists$ (easily
  defined as adjoints to weakening)

-  Something about substitution, I imagine.

Constructions:

-  Fix a set $cal(V)$ of values that variables range over, $cal(F)$ a
  propositional logic. Then (finitely supported)
  $lr((cal(X) arrow.r cal(V))) arrow.r cal(F)$ will be the corresponding
  nominal structure (with appropriate substitutions).

= Programs, Kleene algebras and such
#label("programs-kleene-algebras-and-such")
Structures:

-  Kleene algebras

-  Kleene algebras with tests

-  Action algebras

Constructions:

-  (generalised) relations: $A arrow.r A arrow.r cal(F)$ ($A$ arbitrary
  set, $cal(F)$ #emph[complete] lattice) (complete action algebra).

-  (generalised) predicate transformers $cal(F) arrow.r cal(F)$ (doesn’t
  have all the residuations).

-  Nominal Kleene algebra $arrow.r$ Kleene algebra "that returns values"
  (in the style of monads). I think I know how to do this.

= Types, proof theory
#label("cha:types-proof-theory")
Principle: all categories are small.

Idea for types: replace nominal sets by being fibred over a CT-structure
(do I remember the terminology correctly?): a cartesian category of
contexts and substitution, together with an identified subset of types.
Fibred: every substitution induces a context-change functor in the other
direction (plus some stuff, probably).

Idea for proof theory: replace preorders with categories (lattice $⤳$
all finite limits and colimits; complete $⤳$ all small limits and
colimits (I think it’s sometimes called bicomplete)). We can reinterpret
deduction rules as adjoints (this is a little trickier because of the
naturality conditions: in the rule for exponentials, for instance, we
need to be natural in everything except the bit that changes side; can
this be clarified notationally?)

The constructions from @cha:simple-logics carry over.
