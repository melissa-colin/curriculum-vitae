# Makefile — CV Mélissa Colin
#
# Trois CV, deux moteurs :
#   french.tex                  → xelatex  (classe maison assets/template/cvclass)
#   cv-research-general.tex     → pdflatex (article, candidatures recherche)
#   google-student-researcher.tex → pdflatex (article, ciblé Google)
#
# Le vrai numéro de téléphone vit dans personal.tex, ignoré par git.
# S'il est absent, les CV compilent avec un numéro masqué : c'est voulu.

XELATEX  = xelatex -interaction=nonstopmode
PDFLATEX = pdflatex -interaction=nonstopmode

FRENCH  = french
GENERAL = cv-research-general
GOOGLE  = google-student-researcher

.PHONY: all french general google compile clean cleanaux check-personal help

# Compile les trois CV, puis nettoie les auxiliaires
all: french general google
	$(MAKE) cleanaux

french: check-personal
	$(XELATEX) $(FRENCH).tex
	$(XELATEX) $(FRENCH).tex
	$(MAKE) cleanaux

general: check-personal
	$(PDFLATEX) $(GENERAL).tex
	$(PDFLATEX) $(GENERAL).tex
	$(MAKE) cleanaux

google: check-personal
	$(PDFLATEX) $(GOOGLE).tex
	$(PDFLATEX) $(GOOGLE).tex
	$(MAKE) cleanaux

# Avertit si personal.tex manque, sans bloquer la compilation.
# Un avertissement vaut mieux qu'une erreur : sur une machine neuve tu veux
# quand même pouvoir compiler, tu veux juste savoir ce que tu obtiens.
check-personal:
	@test -f personal.tex \
	  || echo ">>> personal.tex absent : les CV seront compilés avec un numéro masqué."

# Compilation ponctuelle : make compile FILE=mon-cv.tex
compile:
	$(PDFLATEX) $(FILE)
	$(PDFLATEX) $(FILE)
	$(MAKE) cleanaux

# Supprime les auxiliaires, garde les PDF
cleanaux:
	@rm -f *.aux *.bbl *.blg *.dvi *.log *.out *.upa *.toc *.out.ps \
	       *.fls *.fdb_latexmk *.synctex.gz

# Supprime tout ce qui est généré, PDF compris
clean: cleanaux
	@rm -f $(FRENCH).pdf $(GENERAL).pdf $(GOOGLE).pdf

help:
	@echo "make all      — compile les trois CV"
	@echo "make french   — CV français (xelatex)"
	@echo "make general  — CV recherche, version générale (pdflatex)"
	@echo "make google   — CV ciblé Google Student Researcher (pdflatex)"
	@echo "make compile FILE=x.tex — compile un fichier isolé"
	@echo "make cleanaux — supprime les auxiliaires"
	@echo "make clean    — supprime auxiliaires et PDF"
