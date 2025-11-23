# Makefile for building main.tex -> main.pdf
# Usage:
#   make            # build main.pdf (default)
#   make LATEX=xelatex    # build with xelatex
#   make view       # open PDF with default viewer
#   make watch      # use latexmk -pvc if available
#   make clean/distclean

# Configurable variables
MAIN     := main
LATEX    ?= pdflatex
FLAGS    ?= -interaction=nonstopmode -halt-on-error -file-line-error
VIEWER   ?= xdg-open

# Convenience: detect any .bib files in the directory
BIBS := $(wildcard *.bib)

.PHONY: all clean distclean view watch

all: $(MAIN).pdf

# Build rule: run latex, optionally bibtex, then rerun latex enough times
$(MAIN).pdf: $(MAIN).tex
	@echo "Building $@ with $(LATEX)..."
	$(LATEX) $(FLAGS) $<
	@if [ -n "$(BIBS)" ]; then \
	  echo "Detected .bib files -> running bibtex $(MAIN)"; \
	  bibtex $(MAIN); \
	else \
	  echo "No .bib files detected"; \
	fi
	$(LATEX) $(FLAGS) $<
	$(LATEX) $(FLAGS) $<
	@echo "Built $@"

# Open the PDF in the system viewer
view: $(MAIN).pdf
	@echo "Opening $(MAIN).pdf..."
	-$(VIEWER) $(MAIN).pdf >/dev/null 2>&1 &

# If you have latexmk installed, this will watch and rebuild automatically.
# Otherwise it prints a hint.
watch:
	@if command -v latexmk >/dev/null 2>&1; then \
	  echo "Starting latexmk -pvc (watch mode) using $(LATEX)"; \
	  latexmk -pvc -pdf -pdflatex="$(LATEX) $(FLAGS)" $(MAIN).tex; \
	else \
	  echo "latexmk not found. Install latexmk or run 'make' repeatedly."; \
	fi

# Remove most generated files but keep the PDF
clean:
	-rm -f *.aux *.log *.out *.toc *.lot *.lof *.fls *.fdb_latexmk \
	       *.bbl *.blg *.synctex.gz *.nav *.snm *.vrb

# Remove everything including PDF
distclean: clean
	-rm -f $(MAIN).pdf

# Useful debugging: show which variables are in use
print-vars:
	@echo "MAIN=$(MAIN)"
	@echo "LATEX=$(LATEX)"
	@echo "FLAGS=$(FLAGS)"
	@echo "VIEWER=$(VIEWER)"
	@echo "BIBS=$(BIBS)"
