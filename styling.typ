#let page-margin = 1.75in
#let margin-margin = 1em

#let book(
    title: none,
    author: none,
    date: none,
    doc,
    ) = {

  // Styling the page (margin, indentation, vertical space)
  set page(margin: page-margin)
  set par(leading: 0.55em, first-line-indent: 1.8em, justify: true)
  show par: set block(spacing: 0.55em)
  show heading: set block(above: 1.4em, below: 1em)

  // Number headings
  set heading(numbering: "1.1  ")

  // Make level-one heading chapters
  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #block[Chapter #counter(heading).display() #it.body]
  ]
  set ref(supplement: it => {
    if it.func() == heading and it.level == 1 {
      "Chapter"
    }
    else {
      it.supplement
    }
  })

  // Front matter
  align(center, text(21pt)[*#title*])
  align(center, text(16pt)[#author])
  if date != none { align(center)[Version compiled on #date.display()] }

  // Display content
  doc
}

// Colours from the Latex xcolor package
// Values take from https://en.wikibooks.org/wiki/LaTeX/Colors
//
// These are the colours recommended by
// https://arxiv.org/pdf/2001.11334.pdf
// Up to potential errors in transcription
#let red-orange = rgb("#F26035")
#let royal-blue = rgb("#0071BC") // Or? rgb(25.5%, 41%, 88.4%)
#let emerald = rgb("#00A99D")
#let yellow-orange = rgb("#FAA21A")
#let carnation-pink = rgb("#F282B4") // Or? rgb("100%, 65%, 78%")

// TODO: add non-colour visual differences.
#let fancy-font-1(body) = [#set text(fill: red-orange); #body]
#let fancy-font-2(body) = [#set text(fill: royal-blue); #body]
#let fancy-font-3(body) = [#set text(fill: emerald); #body]
#let fancy-font-4(body) = [#set text(fill: yellow-orange); #body]
#let fancy-font-5(body) = [#set text(fill: carnation-pink); #body]
#let no-fancy-font(body) =[#set text(fill: black); #body]

// Adapted fromxb

// https://github.com/jwhear/tufte-handout/blob/d36a5b8bdd4f7515c849fe9621591e494ee0fe5b/tufte-handout.typ#L6-L21
// Still imperfect: I would like it to take 0 space at the call
// site. It appears to create a paragraph. I don't know why.
#let in-margin(dy: -1em, content) = {
    place(
        right,
        dx: page-margin,
        dy: dy,
        block(width: page-margin, inset: margin-margin, {
            set text(size: 0.75em)
            set align(left)
            content
        })
    )
}

#let rect-in-margin(color: black, content) = {
    let decorated = rect(stroke: color, fill: color.lighten(80%),
                         radius: 6pt, (content))
    in-margin(decorated)
}

#let margin-note(color: black, content) = {
   rect-in-margin(color: color, content)
}
