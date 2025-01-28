#!/usr/bin/env bash

# Inicializar variables
excluded_files=()
excluded_dirs=()

# Función para mostrar ayuda
show_help() {
  echo "Uso: $0 [-f archivo_a_excluir] [-d carpeta_a_excluir]"
  echo ""
  echo "Opciones:"
  echo "  -f FILE   Especifica un archivo a excluir (puedes usar múltiples -f)"
  echo "  -d DIR    Especifica una carpeta a excluir (puedes usar múltiples -d)"
  echo "  -h        Muestra esta ayuda"
}

# Procesar flags con getopts
while getopts "f:d:h" opt; do
  case $opt in
    f) excluded_files+=("$OPTARG") ;;  # Agregar archivo a la lista de exclusión
    d) excluded_dirs+=("$OPTARG") ;;   # Agregar carpeta a la lista de exclusión
    h) show_help; exit 0 ;;            # Mostrar ayuda y salir
    *) show_help; exit 1 ;;            # Manejar opciones no reconocidas
  esac
done

# Construir patrón de exclusión para `tree`
tree_exclude_pattern=".git|node_modules|build|dist"

# Agregar carpetas excluidas por el usuario al patrón de tree
for dir in "${excluded_dirs[@]}"; do
  tree_exclude_pattern="$tree_exclude_pattern|$dir"
done

# Construir comando `find` dinámicamente
find_cmd="find ."

# Excluir carpetas predeterminadas
find_cmd="$find_cmd -path './.git' -prune -o \
-path './node_modules' -prune -o \
-path './build' -prune -o \
-path './dist' -prune -o"

# Excluir carpetas proporcionadas por el usuario
for dir in "${excluded_dirs[@]}"; do
  find_cmd="$find_cmd -path './$dir' -prune -o"
done

# Excluir archivos proporcionados por el usuario
for file in "${excluded_files[@]}"; do
  find_cmd="$find_cmd -name '$file' -prune -o"
done

# Completar el comando find
find_cmd="$find_cmd -type f -print"

(
  echo "Estructura de archivos:"
  echo '```'
  # Ejecutar el comando tree con el patrón de exclusión correcto y sin colores
  tree -I "$tree_exclude_pattern" -n --prune
  echo '```'

  echo ""
  echo "Contenido de los archivos:"
  # Ejecutar el comando `find` y procesar archivos
  eval "$find_cmd" | while IFS= read -r file; do
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