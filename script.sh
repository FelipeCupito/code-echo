#!/usr/bin/env bash

excluded_file="$1"

(
  echo "Estructura de archivos:"
  echo '```'
  tree -I "(.git|node_modules|build|dist)" --prune
  echo '```'

  echo ""
  echo "Contenido de los archivos:"
  # Construir el comando find de manera dinámica para incluir o no el archivo a excluir
  if [ -n "$excluded_file" ]; then
    find_cmd="find . \
      -path './.git' -prune -o \
      -path './node_modules' -prune -o \
      -path './build' -prune -o \
      -path './dist' -prune -o \
      -name '$excluded_file' -prune -o \
      -type f -print"
  else
    find_cmd="find . \
      -path './.git' -prune -o \
      -path './node_modules' -prune -o \
      -path './build' -prune -o \
      -path './dist' -prune -o \
      -type f -print"
  fi

  # Ejecutar el comando find y procesar archivos
  eval "$find_cmd" | while read file; do
    # Verificar si es un archivo de texto
    if file "$file" | grep -q "text"; then
      echo ""
      echo "Nombre del archivo: $file"
      echo '```'
      cat "$file"
      echo '```'
    fi
  done
) | pbcopy