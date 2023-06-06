#let book(
    title: none,
    author: none,
    date: none,
    doc,
    ) = {

  // Styling the page (margin, indentation, vertical space)
  set page(margin: 1.75in)
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
