# Makefile for CV project

# Variables
LATEX = xelatex
PDFLATEX = pdflatex
TEX_FRENCH = french.tex
TEX_ENGLISH = academic.tex
PDF_FRENCH = french.pdf
PDF_ENGLISH = academic.pdf


# Default target: compile les deux PDF puis nettoie les fichiers auxiliaires
all: french academic
	$(MAKE) cleanaux

french:
	$(LATEX) $(TEX_FRENCH)
	$(LATEX) $(TEX_FRENCH)
	$(MAKE) cleanaux


# Compile English CV (2 passes)
academic:
	$(PDFLATEX) $(TEX_ENGLISH)
	$(PDFLATEX) $(TEX_ENGLISH)
	$(MAKE) cleanaux


# Clean auxiliary files and PDFs
clean:
	rm -f *.aux *.bbl *.blg *.dvi *.log *.out *.upa *.toc *.pdf *.out.ps

# Clean only auxiliary files (garde les PDF)
cleanaux:
	rm -f *.aux *.bbl *.blg *.dvi *.log *.out *.upa *.toc *.out.ps
