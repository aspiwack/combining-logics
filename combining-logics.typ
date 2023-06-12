#import "styling.typ"

#show: doc => styling.book(
    title: [Combining Logics],
    author: [Arnaud Spiwack],
    date: datetime.today(),
    doc,
    )

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
  - Note to self: finite products distribute with arbitrary sum iff
    (complete) Heyting algebra. Arbitrary products distribute over
    arbitrary sums: can introduce #emph[completely distributive] terminology.

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

== Kleene algebras

=== Relations
<kleene-algebras:relations>

#let base = $cal(F)$

Fix $base$ [TODO Colour], complete Heyting Algebra, and a “state
space” $S$.

Relations: $S arrow.r S arrow.r F$

#let pre(p) = $#{p}_arrow.b$
#let post(q) = $#{q}^arrow.t$

Hoare triple ${P}u{Q}$ can be represented as

$pre(P) u tack.r post(Q)$

With

$s pre(P) s eq.delta s in P$

$s_i post(Q) s_o eq.delta s_o in Q$

== Action algebras

=== Relations

Hoare triple ${P}u{Q}$ can be represented as (see @kleene-algebras:relations)

$u tack.r pre(P) arrow.r post(Q)$

Gives a direct representation of a Hoare specification as $pre(P) arrow.r post(Q)$.

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

= TEMP experiments with the typesetter

test
#styling.in-margin([This is a marginal note #lorem(20)])
#lorem(40)

test
#styling.margin-note(color: red, [This will be a todo note #lorem(15)])
#lorem(40)

#let rule(premises, conclusion) = {
  style(styles => {
    let premise = if (type(premises) == "content") {premises} else {premises.join(h(2em))}
    let len = calc.max(measure(premise, styles).width, measure(conclusion, styles).width)
    box[
     #set align(center)
     #premise
     #line(length: len, stroke:0.5pt)
     #conclusion
    ]
  })
}


#rule((rule(([a more premise],[two more premises]), [a premise]), [yet another premise]), [a conclusion])
