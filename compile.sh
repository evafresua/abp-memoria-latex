#!/usr/bin/env bash

set -eu

PROJECT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
MAIN_FILE="main.tex"
PDF_FILE="main.pdf"

cd "$PROJECT_DIR"

if ! command -v pdflatex >/dev/null 2>&1; then
  printf 'Error: pdflatex no está instalado o no está disponible en PATH.\n' >&2
  exit 1
fi

printf 'Compilando %s...\n' "$MAIN_FILE"
pdflatex -interaction=nonstopmode -halt-on-error "$MAIN_FILE"
pdflatex -interaction=nonstopmode -halt-on-error "$MAIN_FILE"

rm -f main.aux main.log main.out main.toc missfont.log

if [ ! -f "$PDF_FILE" ]; then
  printf 'Error: no se generó %s.\n' "$PDF_FILE" >&2
  exit 1
fi

printf 'PDF generado correctamente: %s/%s\n' "$PROJECT_DIR" "$PDF_FILE"
