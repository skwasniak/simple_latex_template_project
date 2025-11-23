# A Simple `LaTeX` Project

This project contains a simple `LaTeX` document (`main.tex`) and a simple
`Makefile` to build it.

It is based on [this gist by brenes](https://gist.github.com/brenes/4329292).

## Requirements

* A TeX distribution (`TeX Live`, `MiKTeX`, `MacTeX`).
* `pdflatex` (default), or optionally `xelatex` / `lualatex`.
* `bibtex` (only if using a bibliography).
* **Optional:** `latexmk` for automatic rebuilding.

## Building the Document

* To compile the PDF:

```bash
make
```

* To use a different engine:

```bash
make LATEX=xelatex
# or
make LATEX=lualatex
```

## Other Useful Commands

Open the generated PDF:

```bash
make view
```

* Automatically rebuild on changes (requires latexmk):

```make
make watch
```

* Clean temporary files:

```bash
make clean
```

* Remove everything including the PDF:

```
make distclean
```
