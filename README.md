# CV — Mélissa Colin

Sources LaTeX de mes CV. Deux moteurs, une classe maison.

**CV généralistes**, à la racine :

| Fichier | Moteur | Usage |
|---|---|---|
| `french.tex` | XeLaTeX | CV français, mise en page deux colonnes (classe `assets/template/cvclass`) |
| `cv-research-general.tex` | pdfLaTeX | CV anglais, candidatures recherche et LinkedIn |

**CV ciblés**, un sous-dossier par entreprise dans `targeted/` :

| Dossier | Poste |
|---|---|
| `targeted/google-student-researcher/` | Google — Student Researcher, BS/MS, Fall 2026 |
| `targeted/google-swe-apprentice/` | Google — apprentissage ingénierie logicielle |
| `targeted/ami-labs/` | AMI Labs — CV et lettre |

Le Makefile découvre `targeted/*/*.tex` tout seul : un nouveau dossier entre dans le build sans qu'on touche au Makefile.

## Données personnelles

Le numéro de téléphone n'est pas dans le dépôt. Il vit dans `personal.tex`, ignoré par git :

```latex
\newcommand{\myphone}{+33 6 XX XX XX XX}
```

Chaque CV fait `\IfFileExists{personal.tex}{\input{personal.tex}}{}` suivi d'un `\providecommand` de repli. En local tu compiles avec le vrai numéro, un clone du dépôt obtient une version masquée, et il n'y a rien à penser avant chaque commit.

Les PDF compilés ne sont pas suivis non plus, pour la même raison : en local ils contiennent le vrai numéro.

## Compilation

```sh
make all      # tout
make french   # français uniquement
make general  # CV recherche généraliste
make targeted # tous les CV ciblés
make clean    # supprime auxiliaires et PDF
make help     # liste les cibles et les CV ciblés détectés
```

Il faut XeLaTeX et pdfLaTeX. Les polices sont incluses dans `assets/fonts/`.

**Toujours compiler depuis la racine du dépôt**, jamais depuis un sous-dossier : LaTeX résout les chemins relatifs depuis le répertoire courant, pas depuis le `.tex`. C'est ce qui permet à `targeted/*/cv.tex` de trouver `personal.tex`.

## Intégration continue

`.github/workflows/build-cv.yml` compile tout à chaque poussée sur `main` et attache les deux CV généralistes à la release `latest`, donc à une URL qui ne change jamais.

Le runner n'a pas `personal.tex` : les PDF publiés portent le numéro masqué. Une étape du workflow refuse de publier si un PDF contient un motif de mobile français complet — elle cherche le motif, pas le numéro actuel, pour rester valable si celui-ci change.

## Structure

- `assets/fonts/` — Lekton, Poppins, RobotoMono
- `assets/img/` — photos et icônes
- `assets/template/` — classe LaTeX `cvclass.cls` et script Lua

## Licence

**Tous droits réservés.** Vous n'êtes pas autorisé à copier, réutiliser, modifier ou distribuer tout ou partie de ce code ou de sa sortie compilée sans autorisation écrite explicite de l'autrice.

Si ce template vous intéresse, écrivez-moi.
