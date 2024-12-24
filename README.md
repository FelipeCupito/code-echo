# CodeEcho

CodeEcho es una herramienta de línea de comandos que permite extraer la estructura de un proyecto, junto con el contenido de sus archivos de texto, y copiar el resultado al portapapeles. Diseñada para facilitar el análisis de código y compartir proyectos con herramientas de colaboración como ChatGPT.

## Características
- Genera un diagrama estructurado del árbol de archivos del proyecto.
- Extrae el contenido de los archivos de texto seleccionados.
- Permite excluir archivos o directorios específicos.
- Copia la salida al portapapeles automáticamente.
- Compatible con macOS.

## Requisitos previos
- Sistema operativo:
  - macOS.
- Comandos disponibles:
  - `tree`
  - `find`
  - `grep`
  - `pbcopy`

## Instalación

1. Clona este repositorio:
   ```bash
   git clone https://github.com/tuusuario/codeEcho.git
   cd codeEcho
   ```

2. Da permisos de ejecución al script:
   ```bash
   chmod +x codeEcho.sh
   ```

3. (Opcional) Añádelo a tu PATH para usarlo como un comando:
   ```bash
   sudo ln -s $(pwd)/codeEcho.sh /usr/local/bin/codeEcho
   ```

   Ahora puedes usar `codeEcho` desde cualquier directorio.

## Uso

```bash
codeEcho [archivo_a_excluir]
```

### Argumentos
- `archivo_a_excluir`: (opcional) Nombre del archivo que deseas excluir del análisis. Por ejemplo, si no quieres incluir `output.txt` en la salida, pásalo como argumento.

### Ejemplo

1. Generar el árbol de archivos y copiar el contenido al portapapeles:
   ```bash
   codeEcho
   ```

2. Excluir un archivo específico:
   ```bash
   codeEcho proyecto_dump.txt
   ```

### Ejemplo de salida

```markdown
Estructura de archivos:
```
```
lib/
├── main.dart                      // Punto de entrada
├── models/
│   ├── channel.dart               // Modelo del canal
│   └── live_stream.dart           // Modelo de transmisiones
...
Contenido de los archivos:

Nombre del archivo: lib/main.dart

\```
void main() {
  runApp(MyApp());
}
\```
```

