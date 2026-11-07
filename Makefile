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
RESUME  = research-resume

TARGETED_SRC = $(wildcard targeted/*/*.tex)
TARGETED_PDF = $(TARGETED_SRC:.tex=.pdf)

# Campagne PFE 2027 → thèse : un dossier par cible dans PFE-PHD/cv/.
# Le wildcard ne prend que les */cv.tex, donc PFE-PHD/cv/preamble.tex (qui
# n'est pas dans un sous-dossier et n'est pas compilable seul) reste dehors.
PFE_SRC = $(wildcard PFE-PHD/cv/*/cv.tex)
PFE_PDF = $(PFE_SRC:.tex=.pdf)

.PHONY: all french general resume targeted pfe compile clean cleanaux check-personal help

# Compile tout, puis nettoie les auxiliaires
all: french general resume targeted pfe
	$(MAKE) cleanaux

french: check-personal
	$(XELATEX) $(FRENCH).tex
	$(XELATEX) $(FRENCH).tex
	$(MAKE) cleanaux

general: check-personal
	$(PDFLATEX) $(GENERAL).tex
	$(PDFLATEX) $(GENERAL).tex
	$(MAKE) cleanaux

# Même contenu que general, condensé sur une page.
resume: check-personal
	$(PDFLATEX) $(RESUME).tex
	$(PDFLATEX) $(RESUME).tex
	$(MAKE) cleanaux

# cv-public.tex n'est qu'une enveloppe autour de cv.tex : sans cette ligne,
# make ne voit pas le lien et laisse un PDF public périmé — or c'est celui
# qui est versionné et partagé par lien.
targeted/google-deepmind-openendedness/cv-public.pdf: targeted/google-deepmind-openendedness/cv.tex

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

pfe: check-personal $(PFE_PDF)
	$(MAKE) cleanaux

# Même logique que targeted/ : compilation depuis la racine via
# -output-directory, pour que \input{PFE-PHD/cv/preamble.tex} et personal.tex
# soient tous deux résolus. La dépendance sur preamble.tex fait que toucher au
# préambule recompile les 58 CV — c'est voulu, sinon ils divergent en silence.
PFE-PHD/cv/%.pdf: PFE-PHD/cv/%.tex PFE-PHD/cv/preamble.tex
	$(PDFLATEX) -output-directory=$(dir $@) $<
	$(PDFLATEX) -output-directory=$(dir $@) $<
	@if [ -f personal.tex ]; then \
	  num=$$(sed -n 's/.*myphone}{\([^}]*\)}.*/\1/p' personal.tex); \
	  if [ -z "$$num" ] || ! pdftotext $@ - 2>/dev/null | grep -qF "$$num"; then \
	    echo ">>> $@ : vrai numero ABSENT du PDF (le montage gdrive a rate une"; \
	    echo ">>> lecture pendant le build). Relancer make pfe."; \
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
	@rm -f PFE-PHD/cv/*/*.aux PFE-PHD/cv/*/*.log PFE-PHD/cv/*/*.out \
	       PFE-PHD/cv/*/*.fls PFE-PHD/cv/*/*.fdb_latexmk PFE-PHD/cv/*/*.synctex.gz

# Supprime tout ce qui est généré, PDF compris
clean: cleanaux
	@rm -f $(FRENCH).pdf $(GENERAL).pdf $(RESUME).pdf $(TARGETED_PDF) $(PFE_PDF)

help:
	@echo "make all      — compile tous les CV"
	@echo "make french   — CV français (xelatex)"
	@echo "make general  — CV recherche, version générale (pdflatex)"
	@echo "make resume   — CV recherche, version une page (pdflatex)"
	@echo "make targeted — tous les CV ciblés de targeted/*/"
	@echo "make pfe      — tous les CV de la campagne PFE-PHD/cv/*/"
	@echo "make compile FILE=x.tex — compile un fichier isolé"
	@echo "make cleanaux — supprime les auxiliaires"
	@echo "make clean    — supprime auxiliaires et PDF"
	@echo ""
	@echo "CV ciblés détectés :"
	@for f in $(TARGETED_SRC); do echo "  $$f"; done
