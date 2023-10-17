# 1.Visual Studio Code Portátil para Windows y Linux `vscode-portable.sh`

Este tutorial te mostrará cómo crear una instalación portátil de Visual Studio Code (VSCode) que funcione tanto en sistemas Windows como en sistemas Linux. Esto te permitirá llevar tu entorno de desarrollo contigo en una unidad USB o cualquier otro medio de almacenamiento portátil.

## Paso 1: Descargar Visual Studio Code

1. Visita el [sitio web oficial de descarga de VSCode](https://code.visualstudio.com/).
2. Descarga la versión de Windows en formato `.zip` y la versión de Linux en formato `.tar.gz`.

## Paso 2: Estructura de Directorios

Crea la siguiente estructura de directorios en la ubicación donde deseas almacenar la instalación portátil de VSCode:

vscode-portable/
data/
vscode-win/
(archivos de VSCode para Windows)
vscode-linux/
(archivos de VSCode para Linux)
vscode-portable.sh (script de inicio)
bash
Copy code

Asegúrate de que todas las carpetas estén en el mismo directorio raíz (`vscode-portable`).

## Paso 3: Crear el Script de Inicio

Crea un script de inicio llamado `vscode-portable.sh` en la carpeta `vscode-portable` y agrega el siguiente contenido:

```markdown
#!/bin/bash
VSCODE_CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_NAME=$(uname -s)

if [[ "$OS_NAME" == "Linux" ]]; then
  cd "$VSCODE_CWD/vscode-linux"
  ./code --user-data-dir="$VSCODE_CWD/data" "$@"
elif [[ "$OS_NAME" == "MINGW"* || "$OS_NAME" == "MSYS"* || "$OS_NAME" == "CYGWIN"* ]]; then
  cd "$VSCODE_CWD/vscode-win"
  ./Code.exe --user-data-dir="$VSCODE_CWD/data" "$@"
else
  echo "El sistema operativo $OS_NAME no es compatible."
  exit 1
fi
```


## Paso 4: Permisos de Ejecución

Asegúrate de que el script vscode-portable.sh tenga permisos de ejecución en Linux con el siguiente comando:

```
chmod +x vscode-portable.sh
```

## Paso 5: Copiar Archivos

Copia los archivos de VSCode para Windows en la carpeta vscode-win y los archivos de VSCode para Linux en la carpeta vscode-linux. Asegúrate de que los nombres de los archivos sean correctos según el sistema operativo.

## Paso 6: Ejecutar VSCode Portátil

Para usar VSCode portátil, simplemente ejecuta el script vscode-portable.sh en el directorio vscode-portable. Este script detectará automáticamente el sistema operativo y ejecutará la versión correspondiente de VSCode desde vscode-win/ o vscode-linux/, utilizando la carpeta data/ para las configuraciones portátiles.

```
./vscode-portable.sh
```

Con estos pasos, has creado una instalación portátil de Visual Studio Code que funciona tanto en Windows como en Linux. Esto te permite llevar tu entorno de desarrollo personalizado en una unidad USB o en cualquier otro medio de almacenamiento y utilizarlo en diferentes computadoras sin necesidad de instalación.

# 2.Mejora en el Script de Bash para Ejecutar Visual Studio Code `code.sh`

En esta versión mejorada del script de Bash para ejecutar Visual Studio Code, se ha implementado la capacidad de utilizar la instalación de Visual Studio Code del sistema si está disponible, pero aún se utiliza la ubicación personalizada de datos y extensiones almacenadas en el pendrive. A continuación, se describe el funcionamiento de esta mejora:

## Líneas del Script


## Obtener el Directorio del Script

```
DIR=$(dirname "$0")
```
Esta línea obtiene el directorio en el que se encuentra el script y almacena la ubicación en la variable DIR.

## Definir la Ubicación de los Datos de Visual Studio Code

```
DATA="$DIR/vscode-win/data"
```
Esta línea define la ubicación de los datos de usuario de Visual Studio Code. Los datos se asumen que se encuentran en la subcarpeta vscode-win/data dentro del directorio del script.

# Determinar la Ubicación del Ejecutable de Visual Studio Code

```
CODE=$(which code 2>/dev/null || echo "$DIR"/vscode-linux/code)
```

En esta línea, se busca el comando code en el sistema utilizando el comando which. Si se encuentra el comando code, CODE se establecerá con la ubicación del ejecutable. Si no se encuentra code, se usará la ubicación del ejecutable code en la carpeta $DIR/vscode-linux. Esto proporciona flexibilidad en la búsqueda del ejecutable.

## Ejecutar Visual Studio Code

```
"$CODE" --user-data-dir="$DATA" --extensions-dir "$DATA/extensions" "$@"
```
Finalmente, esta línea ejecuta Visual Studio Code con los siguientes argumentos:

- ``CODE``: La ubicación del ejecutable de Visual Studio Code.
- ``--user-data-dir="$DATA"``: Personaliza la ubicación de los datos de usuario.
- ``--extensions-dir "$DATA/extensions"``: Define la ubicación de las extensiones instaladas.
- ``$@``: Reenvía cualquier argumento adicional proporcionado al script.

Este script permite la ejecución de Visual Studio Code con personalización de rutas, lo que puede ser útil para mantener múltiples instancias de Visual Studio Code con diferentes configuraciones y extensiones.
