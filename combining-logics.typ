#import "styling.typ"

#show: doc => styling.book(
    title: [Combining Logics],
    author: [Arnaud Spiwack],
    date: datetime.today(),
    doc,
    )

#let standard(body) = styling.no-fancy-font(body)
#let basic(body) = styling.fancy-font-1(body)
#let basic(body) = styling.fancy-font-1(body)
#let derived(body) = styling.fancy-font-2(body)

== Introduction

Similar to logical interpretations (is it the standard terminology?
Like the Dialectica interpretation and such), but possibly a different
point of view.

= Simple logics
<cha:simple-logics>
== Notations
#label("notations")
Inference rules interpreted as Galois connections.

In judgements, only one hypothesis and one conclusion.

Structures:

-  Semirings, I think everything here is a semiring, sometimes in more
   than one way though. Whereas not everything is, say, a lattice.
   - They're all additively idempotent semirings too. So that $a + b = b$ can
     be taken as the definition of $a tack.r b$.
   - I don't know whether ordered semiring are useful here. We have
     one canonical order and we don't need the generality.


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
// <relations:def>

#let base = $basic(cal(F))$

Fix $base$, complete Heyting Algebra, and a “state
space” $S$.

Relations: $S arrow.r S arrow.r #base$

#let pre(p) = $#{basic(p)}_arrow.b$
#let post(q) = $#{basic(q)}^arrow.t$

Hoare triple ${basic(P)}derived(u){basic(Q)}$ can be represented as

$derived(pre(P) u tack.r post(Q))$

With

$s pre(P) s eq.delta s in basic(P)$

$s_i post(Q) s_o eq.delta s_o in basic(Q)$

=== Returning values, bind

#let vars = $cal(X)$
#let base = $basic(cal(K))$
#let defined = $derived(cal(K))$

Fix a set of variable $vars$.

Fix $base$ a #emph[nominal] complete Kleene algebra (#emph[i.e.] a
Kleene algebra which is a complete lattice). That is is nominal means
that it's a Kleene algebra in the topos of nominal sets; alternatively
it's a nominal set, and all the Kleene algebra operations are
equivariant.

Set $defined eq.delta vars^2.base$. That is the set of all the
$angle.l i, o angle.r basic(u)$, with $i,o in vars$, $basic(u) in
base$ of triples up to $alpha$-equivalence.

Idea: $angle.l i, o angle.r basic(u)$ is given a distinguished
variable $o$ to store its result. It, additionally, #emph[receives]
the result of the previous operation in variable $i$.

We can define

- $derived(standard(angle.l i\, o angle.r basic(u)) + standard(angle.l i\, o angle.r basic(v))) eq.delta angle.l i, o angle.r basic(u+v)$ (similarly with the infinite sum: careful, it's only defined if there is a common finite support for all the summed elements)
- $derived(standard(angle.l i\, x angle.r basic(u)) \; standard(angle.l x\, o angle.r basic(v))) eq.delta angle.l i, o angle.r basic(u\;v)$
- $derived(u)^*) eq.delta derived(sum u^n)$ (this is where we need the assumption that #base is complete. There may be a way to define the star of #defined in terms of the star of #base, but I don't know how, and I can't say I have much hope)

Notice what it says about loops: loops take a value as input and return one as output, the output of an iteration is fed as the input of the next iteration.

The intuition behind this is the bind syntax, à la Haskell. We want to be able to write $derived(x arrow.l u\; y arrow.l v\; w)$. This is not, however, of the form $derived(u v w)$: in the former $derived(w)$ sees the return value $derived(x)$ of $derived(u)$, but not in the latter. We need an extra contruction $derived("bind" x.standard(angle.l i\, o angle.r basic(u))) eq.delta (angle.l x\, o angle.r basic(u)\[i\\x\])$ (TODO: define in terms of permutations instead. Or maybe in term of “concretion” (turn variable binding into functions, see Andrew Pitts's book))

Then $derived(x arrow.l u\; y arrow.l v)\; w$ can be represented as
$derived(u \; ("bind" x. v w))$.

=== Functions/Higher-order

#let base = $basic(cal(K))$
#let values = $cal(V)$
#let defined = $derived(cal(K))$

Let #base be a Kleene algebra. We can represent procedures (or
functions with the value-returning variation) as (mathematical)
functions. #emph[E.g.], given a set of values #values, a two-argument
function can be a value of $values times values arrow.r base$.

But this only covers first order. If we want higher-order (that is, functions as values), can domain theory help us build a Kleene algebra where $defined arrow.r defined subset.eq defined$? can it be derived from a previously existing #base? What would the relationship between #base and #defined be?

Maybe if #base is a Kleene algebra #emph[in the category of domains/CPOs], then we can create a #defined such that #base is a sub-Kleene algebra of #defined? Does Scott's construction give us anything near this? Possibly I need complete Kleene algebras to reconstruct the star?

If the above works, the question remains: how do I build a Kleene algebra in the category of domains if I have a regular Kleene algebra (like the construction that adds variable makes a logic nominal). A similar construction could be used to build a Higher-Order logic as well.

Potential construction: build a Kleene algebra with functions using a stack machine (application is push). Is there a generic construction that'd be useful there? If we have an algebra of relation on a state, we can presumably enrich the state with a stack. Is there a general construction with an arbitrary Kleene algebra as the input?

== Action algebras

=== Relations

Hoare triple ${basic(P)}derived(u){basic(Q)}$ can be represented as (see @kleene-algebras:relations)

$derived(u tack.r pre(P) arrow.r post(Q))$

Gives a direct representation of a Hoare specification as $derived(pre(P)
arrow.r post(Q))$.

Are there interesting examples of:

- left residuation by a state-changing relation?
- right residuation?

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

Note: all my categories are small (but not necessarily the fibrations).

== Relations

Relations can be generalised further: take any fibration over a
cartesian category with complete Heyting algebras fibers (the
definition of @kleene-algebras:relations is obtained by taking fibers
to be powersets). Take a fiber of $A x A$.

Can be done the whole fibration in one go with Bart Jacobs's pullback
constructions. [TODO bibliography]

= TEMP experiments with the typesetter

#styling.fancy-font-1[fancy font 1]
#styling.fancy-font-2[fancy font 2]
#styling.fancy-font-3[fancy font 3]
#styling.fancy-font-4[fancy font 4]
#styling.fancy-font-5[fancy font 5]

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
