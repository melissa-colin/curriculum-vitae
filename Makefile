# Makefile — CV Mélissa Colin
#
# Deux CV généralistes à la racine, deux moteurs :
#   french.tex               → xelatex  (classe maison assets/template/cvclass)
#   cv-research-general.tex  → pdflatex (article, candidatures recherche)
#
# Les CV ciblés vivent dans targeted/<entreprise>/*.tex et sont découverts
# automatiquement : tu crées un dossier, il entre dans le build sans que tu
# aies à modifier ce fichier. Une liste écrite à la main finit toujours par
# diverger de la réalité du disque.
#
# TOUT se compile depuis la racine du dépôt, jamais depuis un sous-dossier.
# C'est ce qui fait que \IfFileExists{personal.tex} trouve le fichier : LaTeX
# résout les chemins relatifs depuis le répertoire courant, pas depuis le .tex.
#
# Le vrai numéro de téléphone vit dans personal.tex, ignoré par git.
# S'il est absent, les CV compilent avec un numéro masqué : c'est voulu.

XELATEX  = xelatex -interaction=nonstopmode
PDFLATEX = pdflatex -interaction=nonstopmode

FRENCH  = french
GENERAL = cv-research-general

TARGETED_SRC = $(wildcard targeted/*/*.tex)
TARGETED_PDF = $(TARGETED_SRC:.tex=.pdf)

.PHONY: all french general targeted compile clean cleanaux check-personal help

# Compile tout, puis nettoie les auxiliaires
all: french general targeted
	$(MAKE) cleanaux

french: check-personal
	$(XELATEX) $(FRENCH).tex
	$(XELATEX) $(FRENCH).tex
	$(MAKE) cleanaux

general: check-personal
	$(PDFLATEX) $(GENERAL).tex
	$(PDFLATEX) $(GENERAL).tex
	$(MAKE) cleanaux

targeted: check-personal $(TARGETED_PDF)
	$(MAKE) cleanaux

# Règle motif : un .pdf à côté de son .tex, mais compilé DEPUIS la racine.
# -output-directory range le PDF et ses auxiliaires dans le dossier de
# l'entreprise, sans changer le répertoire courant — donc personal.tex reste
# visible. Deux passes parce que hyperref a besoin d'un .aux déjà écrit.
targeted/%.pdf: targeted/%.tex
	$(PDFLATEX) -output-directory=$(dir $@) $<
	$(PDFLATEX) -output-directory=$(dir $@) $<
	@if [ -f personal.tex ]; then \
	  num=$$(sed -n 's/.*myphone}{\([^}]*\)}.*/\1/p' personal.tex); \
	  if [ -z "$$num" ] || ! pdftotext $@ - 2>/dev/null | grep -qF "$$num"; then \
	    echo ">>> $@ : vrai numero ABSENT du PDF (le montage gdrive a rate une"; \
	    echo ">>> lecture pendant le build). Relancer make targeted."; \
	    exit 1; fi; fi

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
	@rm -f targeted/*/*.aux targeted/*/*.log targeted/*/*.out \
	       targeted/*/*.fls targeted/*/*.fdb_latexmk targeted/*/*.synctex.gz

# Supprime tout ce qui est généré, PDF compris
clean: cleanaux
	@rm -f $(FRENCH).pdf $(GENERAL).pdf $(TARGETED_PDF)

help:
	@echo "make all      — compile tous les CV"
	@echo "make french   — CV français (xelatex)"
	@echo "make general  — CV recherche, version générale (pdflatex)"
	@echo "make targeted — tous les CV ciblés de targeted/*/"
	@echo "make compile FILE=x.tex — compile un fichier isolé"
	@echo "make cleanaux — supprime les auxiliaires"
	@echo "make clean    — supprime auxiliaires et PDF"
	@echo ""
	@echo "CV ciblés détectés :"
	@for f in $(TARGETED_SRC); do echo "  $$f"; done
