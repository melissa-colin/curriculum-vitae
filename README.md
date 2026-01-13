# My LaTeX CV

This repository contains the LaTeX source code for my personal CV, available in both French and English. The project uses custom LaTeX classes and fonts for a modern, professional look.

## Overview

- **French version:** `french.tex`
- **English version:** `academic.tex`
- Custom class and Lua script: `assets/template/cvclass.cls`, `assets/template/creationdate.lua`
- Fonts: `assets/fonts/`
- Images/icons: `assets/img/`

## Build Instructions

You need a working LaTeX environment with `xelatex` and `pdflatex` (for English version). Fonts are included in the repository.

To compile both CVs and clean auxiliary files:

```sh
make all
```

To compile only the French or English version:

```sh
make french   # Compile french.tex → french.pdf
make academic # Compile academic.tex → academic.pdf
```

To clean all generated files (including PDFs):

```sh
make clean
```

## Project Structure

- `french.tex` : CV principal en français (utilise une classe personnalisée)
- `academic.tex` : CV académique en anglais (format article)
- `assets/fonts/` : Polices utilisées (Lekton, Poppins, RobotoMono)
- `assets/img/` : Images et icônes (GitHub, LinkedIn, etc.)
- `assets/template/` : Classe LaTeX et scripts Lua
- `Makefile` : Commandes de compilation et nettoyage

## Requirements

- [XeLaTeX](https://www.tug.org/xetex/)
- [pdfLaTeX](https://www.tug.org/applications/pdftex/)
- Standard LaTeX packages (geometry, fontawesome5, xcolor, hyperref, paracol, etc.)

## License

⚠️ **All rights reserved.**

You are **not permitted** to copy, reuse, modify, or distribute any part of this code or its compiled output without **explicit written permission** from the author.

If you're interested in using this template or have any questions, feel free to reach out.
