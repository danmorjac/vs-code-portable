# vs-code-portable

# Visual Studio Code Portátil para Windows y Linux

Este repositorio contiene instrucciones y archivos necesarios para crear y utilizar una instalación portátil de Visual Studio Code (VSCode) que funcione tanto en sistemas Windows como en sistemas Linux.

## Paso 1: Descargar Visual Studio Code

Visita el [sitio web oficial de descarga de VSCode](https://code.visualstudio.com/) y descarga la versión de Windows (en formato `.zip`) y la versión de Linux (en formato `.tar.gz`).

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

```bash
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

## Paso 4: Permisos de Ejecución

Asegúrate de que el script vscode-portable.sh tenga permisos de ejecución en Linux con el siguiente comando:


chmod +x vscode-portable.sh

## Paso 5: Copiar Archivos

Copia los archivos de VSCode para Windows en la carpeta vscode-win y los archivos de VSCode para Linux en la carpeta vscode-linux. Asegúrate de que los nombres de los archivos sean correctos según el sistema operativo.

##Paso 6: Ejecutar VSCode Portátil
Para usar VSCode portátil, simplemente ejecuta el script vscode-portable.sh en el directorio vscode-portable. Este script detectará automáticamente el sistema operativo y ejecutará la versión correspondiente de VSCode desde vscode-win/ o vscode-linux/, utilizando la carpeta data/ para las configuraciones portátiles.



./vscode-portable.sh

Con estos pasos, has creado una instalación portátil de Visual Studio Code que funciona tanto en Windows como en Linux. Esto te permite llevar tu entorno de desarrollo personalizado en una unidad USB o en cualquier otro medio de almacenamiento y utilizarlo en diferentes computadoras sin necesidad de instalación.

¡Ahora estás listo para programar en cualquier lugar y en cualquier sistema operativo!
