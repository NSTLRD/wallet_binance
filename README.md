# wallet_binance

I new binance clone for a interview challenger

# Wallet Binance Clone

Este proyecto es un clon de la aplicación de Binance, creado como parte de un desafío de entrevista. El propósito de esta aplicación es proporcionar una experiencia similar a la de Binance para el seguimiento y manejo de criptomonedas.

## Características

- Registro e inicio de sesión de usuarios.
- Visualización en tiempo real de precios de criptomonedas a través de la API de Binance.
- Gráficos de precios de criptomonedas utilizando fl_chart.

## Estructura del Proyecto

El proyecto sigue la estructura de paquetes estándar de Flutter:

- `lib/models`: Contiene los modelos de datos que representan la estructura de los objetos utilizados en la aplicación.
- `lib/views`: Contiene los widgets de la interfaz de usuario que presentan la información y permiten la interacción con el usuario.
- `lib/services`: Incluye la lógica de negocio y la comunicación con APIs externas, como la API de Binance para obtener los datos de mercado.

## API de Binance

La aplicación hace uso de la API de Binance para obtener información actualizada del mercado de criptomonedas. Consulte la [documentación oficial de la API de Binance](https://binance-docs.github.io/apidocs/) para más detalles.

## Instalación

Para ejecutar el proyecto, clona el repositorio y ejecuta los siguientes comandos en la raíz del proyecto:

```bash
flutter pub get
flutter run

## Dependencias

Para asegurar el correcto funcionamiento de la aplicación, las siguientes dependencias deben estar incluidas en tu archivo `pubspec.yaml`:

- `flutter` SDK versión entre 3.2.3 y 4.0.0.
- `provider` para el manejo de estado, versión ^6.0.1.
- `http` para realizar peticiones a APIs, versión ^0.13.3.
- `fl_chart` para la creación de gráficos, versión ^0.35.0.
- `flutter_secure_storage` para el almacenamiento seguro, versión ^4.2.1.
- `cupertino_icons` para íconos de estilo iOS, versión ^1.0.2.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas contribuir al proyecto, por favor envía un pull request o abre un issue para discutir lo que te gustaría cambiar.

## Licencia

Este proyecto está bajo la Licencia MIT. Para más información, por favor consulta el archivo [LICENSE](LICENSE) incluido en este repositorio.

