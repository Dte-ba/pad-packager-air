# PAD packager for AIR

Empaquetador de contenido para la plataforma [PAD](https://github.com/Dte-ba/pad)

# Development

IDE [Flashdevelop](http://www.flashdevelop.org/)

*Tested with the Flex SDK 4.6*

**To compile the application** *on windows*

```
# clone the repo
git clone https://github.com/Dte-ba/pad-packager-air.git
cd pad-packager-air

# Set the Flex_SDK path
echo "path/to/sdk" > bat/sdk_path.txt

# Make a key to sign the application
echo SUPER_SECRET > bat/key.txt

```

## AIR for desktop instructions

- Configuration
	- edit `bat/SetupSDK.bat` for the path to Flex SDK


- Creating a self-signed certificate:
	- run `bat/CreateCertificate.bat` to generate your self-signed certificate,
	- *(!) wait a minute before packaging.*


- Run/debug from FlashDevelop as usual (build F8, build&run F5 or Ctrl+Enter)

- Packaging for release:
	- run `PackageApp.bat` to only create the AIR setup


## Licencia

Copyright(c) 2014 Dirección de Tecnología Educativa de Buenos Aires (Dte-ba)

Distrubuido bajo la licencia [GNU GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)