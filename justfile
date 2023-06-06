mainfile := "combining-logics.typ"
pagefiles := "combining-logics.pdf"

build root=mainfile:
    typst compile {{root}}

watch root=mainfile:
    typst watch {{root}}

pages: build
    mkdir -p pages/
    cp {{pagefiles}} pages/
