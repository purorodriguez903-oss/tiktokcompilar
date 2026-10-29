# 📱 TikTok Clone para iOS (Compilación Automática de IPA con GitHub Actions)

Un clon completo, nativo y ultra realista de **TikTok** desarrollado en **Swift** y **SwiftUI** para iOS, configurado para compilarse automáticamente en la nube a través de **GitHub Actions** y generar un archivo `.ipa` listo para instalar en tu iPhone.

---

## 🌟 Características de la App

### 1. 🏠 Inicio (Feed & Para ti)
- **Desplazamiento vertical fluido** de vídeos a pantalla completa con `AVPlayer`.
- Pestañas superiores: **"Siguiendo"**, **"Para ti"**, botón **LIVE** y buscador.
- **Acciones laterales idénticas a TikTok**:
  - Avatar del creador con botón `+` interactivo para seguir.
  - Botón de **Me gusta** con animación de rebote y efecto de doble toque con corazones flotantes en pantalla.
  - **Hoja modal de comentarios** completa: lee comentarios, da likes y escribe nuevos comentarios.
  - Botón de **Favoritos / Guardar** (se ilumina en amarillo).
  - Hoja de **Compartir**: amigos directos, copiar enlace al portapapeles, WhatsApp, guardar vídeo, dúo y pegar.
  - **Disco de vinilo giratorio** con portada del álbum y notas musicales (`♪ ♫`) flotando animadas.
- **Cinta de sonido en marquesina** con texto deslizante continuo.

### 2. 🛍️ TikTok Shop (Tienda)
- Barra de búsqueda de productos con filtro en vivo.
- **Cesta de compras (Carrito)** con contador de artículos y cálculo dinámico de subtotal.
- **Ofertas relámpago (Flash Deals)** con temporizador de cuenta regresiva en tiempo real.
- **Selector de categorías**: Para ti, Moda, Belleza, Electrónica, Hogar, Calzado.
- **Cuadrícula de productos de 2 columnas**:
  - Imágenes en alta resolución.
  - Precio rebajado y precio original tachado.
  - Porcentaje de descuento (hasta -62%).
  - Etiqueta de **Envío Gratis**.
  - Número de unidades vendidas y valoración con estrellas.
- **Ficha detallada del producto**: selector de colores/variantes, opiniones y botones para *"Añadir a la cesta"* y *"Comprar ahora"*.

### 3. 👥 Amigos
- Pantalla de descubrimiento de amigos.
- Tarjeta interactiva para **Sincronizar contactos**.
- Cuentas sugeridas con botones de *"Seguir"*.

### 4. ➕ Crear / Cámara (Botón Central TikTok)
- El icónico botón central con capas superpuestas en color **Cian** y **Rojo**.
- Pantalla completa de grabación / cámara:
  - Selector de velocidad: `0.3x`, `0.5x`, `1x`, `2x`, `3x`.
  - Selector de duración: `10m`, `60s`, `15s`, `Foto`, `Texto`.
  - Filtros, temporizador, embellecer y botón de sonido.
  - Botón rojo de grabación con pulsación animada.

### 5. 📬 Bandeja de entrada (Inbox & Mensajes)
- Píldoras de actividad rápida (Nuevos seguidores, Actividad, TikTok Shop, Sistema).
- Lista de mensajes directos con avatares, previsualizaciones y puntos de no leídos.
- **Pantalla de chat en tiempo real** interactiva con burbujas de mensajes.

### 6. 👤 Perfil & Ajustes
- Avatar con botón para editar foto.
- Nombre, `@handle` y medalla azul de **Verificado**.
- Contadores reales: **Siguiendo**, **Seguidores** y **Me gusta**.
- Botones de *"Editar perfil"* y *"Compartir perfil"*.
- Pestañas de perfil:
  - 🎬 Vídeos subidos con contadores de vistas (1.2M, 840K, etc.) y etiqueta *"Fijado"*.
  - 🔒 Vídeos privados.
  - 🔖 Vídeos favoritos/guardados.
  - ❤️ Vídeos que te han gustado.
- **Modal de edición de perfil** para cambiar nombre, usuario y descripción.

### 7. 🌐 Ajustes y Selector Dinámico de Idioma
- Menú de **Ajustes y privacidad** completo:
  - **Selector de Idioma**: Cambia al instante entre **Español 🇪🇸**, **English 🇺🇸**, **Français 🇫🇷** y **Português 🇧🇷**. Toda la interfaz se actualiza de forma reactiva.
  - **Limpiador de caché**: Libera memoria con animación y contador en MB.
  - Secciones para pedidos de TikTok Shop, cuenta y soporte.

---

## ⚙️ ¿Cómo compilar el archivo `.ipa` en GitHub?

Este proyecto ya cuenta con el flujo de trabajo automatizado en `.github/workflows/build-ipa.yml`.

### Compilación Automática:
1. Simplemente haz un `git push` a la rama `main`.
2. Dirígete a la pestaña **Actions** en tu repositorio de GitHub:
   `https://github.com/purorodriguez903-oss/tiktokcompilar/actions`
3. Verás la ejecución en curso: **"Compilar TikTok iOS IPA"**.
4. GitHub Actions levantará una máquina macOS con Xcode, compilará el proyecto en modo Release y generará el archivo `TikTok.ipa`.

### Compilación Manual (1 Clic):
1. Ve a la pestaña **Actions** en GitHub.
2. En la barra lateral izquierda, selecciona el workflow **"Compilar TikTok iOS IPA"**.
3. Haz clic en el botón **"Run workflow"** -> **"Run workflow"**.

---

## 📥 ¿Cómo descargar tu archivo `.ipa`?

Una vez completada la compilación en GitHub Actions:
1. **Opción 1 (Releases)**: Ve a la sección **Releases** de tu repositorio (`https://github.com/purorodriguez903-oss/tiktokcompilar/releases`) donde encontrarás la última versión publicada con `TikTok.ipa` adjunto.
2. **Opción 2 (Artifacts)**: En la página del trabajo completado en **Actions**, desplázate hacia abajo hasta la sección **Artifacts** y descarga el archivo `TikTok-iOS-IPA.zip` (que contiene `TikTok.ipa`).

---

## 📲 ¿Cómo instalar `TikTok.ipa` en tu iPhone?

Puedes instalar el archivo en cualquier iPhone (iOS 15 o superior) mediante cualquiera de estos métodos:

| Método | Requiere PC | Descripción |
| :--- | :--- | :--- |
| **TrollStore** | No | Instalación permanente y sin revocar (para versiones de iOS compatibles). |
| **Sideloadly** | Sí (Win / Mac) | Conectas el iPhone por USB/WiFi, arrastras el archivo `TikTok.ipa` e introduces tu Apple ID. |
| **AltStore / SideStore** | Sí (inicial) | Tienda de apps sideloaded que se renueva automáticamente. |
| **Scarlet / Esign** | No | Instalador directo desde Safari en el iPhone. |

---

## 🛠️ Estructura del Proyecto

```text
├── .github/workflows/
│   └── build-ipa.yml                 # Workflow de GitHub Actions (macOS 14 + Xcode)
├── TikTok/
│   ├── TikTokApp.swift               # Entrada principal de la aplicación (@main)
│   ├── Info.plist                    # Permisos y configuración de iOS
│   ├── Theme/
│   │   └── TikTokTheme.swift         # Colores oficiales, hápticos y formato
│   ├── Services/
│   │   └── LanguageManager.swift     # Gestor de idiomas (ES, EN, FR, PT)
│   ├── Models/                       # Modelos de datos (Video, Shop, Comment, Inbox, Profile)
│   ├── ViewModels/                   # Lógica de estados y acciones
│   ├── Views/
│   │   ├── MainTabView.swift         # Barra de navegación inferior
│   │   ├── Components/               # Botón +, corazones flotantes, marquesina, disco giratorio
│   │   ├── Feed/                     # Feed de vídeos, comentarios y compartir
│   │   ├── Shop/                     # TikTok Shop, detalles de producto y carrito
│   │   ├── Friends/                  # Amigos y sugerencias
│   │   ├── Camera/                   # Grabadora y estudio de cámara
│   │   ├── Inbox/                    # Notificaciones y chat
│   │   └── Profile/                  # Perfil, edición y ajustes
│   └── Resources/
│       └── Assets.xcassets/          # Iconos oficiales (1024x1024) y colores
├── TikTok.xcodeproj/                 # Archivo de proyecto Xcode
│   ├── project.pbxproj
│   └── xcshareddata/xcschemes/TikTok.xcscheme
├── ExportOptions.plist
└── README.md
```

---

¡Disfruta tu propia aplicación de TikTok para iOS! 🚀
