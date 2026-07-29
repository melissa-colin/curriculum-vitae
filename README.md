# CV — Mélissa Colin

Sources LaTeX de mes CV. Trois documents, deux moteurs, une classe maison.

| Fichier | Moteur | Usage |
|---|---|---|
| `french.tex` | XeLaTeX | CV français, mise en page deux colonnes (classe `assets/template/cvclass`) |
| `cv-research-general.tex` | pdfLaTeX | CV anglais, candidatures recherche et LinkedIn |
| `google-student-researcher.tex` | pdfLaTeX | CV anglais ciblé Google Student Researcher |

## Données personnelles

Le numéro de téléphone n'est pas dans le dépôt. Il vit dans `personal.tex`, ignoré par git :

```latex
\newcommand{\myphone}{+33 6 XX XX XX XX}
```

Chaque CV fait `\IfFileExists{personal.tex}{\input{personal.tex}}{}` suivi d'un `\providecommand` de repli. En local tu compiles avec le vrai numéro, un clone du dépôt obtient une version masquée, et il n'y a rien à penser avant chaque commit.

Les PDF compilés ne sont pas suivis non plus, pour la même raison : en local ils contiennent le vrai numéro.

## Compilation

```sh
make all      # les trois CV
make french   # français uniquement
make general  # CV recherche généraliste
make google   # CV ciblé Google
make clean    # supprime auxiliaires et PDF
make help     # liste les cibles
```

Il faut XeLaTeX et pdfLaTeX. Les polices sont incluses dans `assets/fonts/`.

## Structure

- `assets/fonts/` — Lekton, Poppins, RobotoMono
- `assets/img/` — photos et icônes
- `assets/template/` — classe LaTeX `cvclass.cls` et script Lua

## Licence

**Tous droits réservés.** Vous n'êtes pas autorisé à copier, réutiliser, modifier ou distribuer tout ou partie de ce code ou de sa sortie compilée sans autorisation écrite explicite de l'autrice.

Si ce template vous intéresse, écrivez-moi.
