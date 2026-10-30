# 🎮 Free Fire 2019 Clásico (Bermuda Era) para iOS

[![Compilar Free Fire 2019 iOS IPA](https://github.com/purorodriguez903-oss/tiktokcompilar/actions/workflows/build-ipa.yml/badge.svg)](https://github.com/purorodriguez903-oss/tiktokcompilar/actions/workflows/build-ipa.yml)

Recreación nostálgica y jugable del mítico **Free Fire del 2019** desarrollada en lenguaje nativo Swift / SwiftUI para dispositivos iOS (iPhone y iPad).

El proyecto incluye compilación automática en la nube mediante **GitHub Actions** en runners macOS 14 con Xcode, generando directamente el archivo `FreeFire.ipa` listo para instalar mediante TrollStore, Sideloadly o AltStore.

---

## 🔥 Características del Proyecto

### 1. Pantalla de Carga y Splash Clásico
- Animación original de entrada con el icónico logo rojo y blanco de **Garena**.
- Barra de carga militar 2019 con consejos clásicos de supervivencia en Bermuda.
- Pantalla interactiva "Toca para iniciar".

### 2. Lobby Clásico 2019
- Fondo de base militar de Bermuda con iluminación de reflectores amarillos y sombras de época.
- Vista previa de personaje 3D con arma en ristre.
- Barra superior de estado:
  - Nombre: `VETERANO_2019` (Nivel 45 - Rango Diamante I).
  - Monedas de Oro: 🪙 `35,420`
  - Diamantes: 💎 `1,250`
- Botones de acceso rápido laterales:
  - **Armería**: Galería completa de armamento clásico.
  - **Personajes**: Selección de héroes clásicos de 2019.
  - **Bóveda** & **Luck Royale**.
  - **Pase Élite**.
- Selector de modo: **Clásico - Bermuda** (Solo, Dúo, Escuadra).
- Botón animado **INICIAR** con cuenta regresiva de emparejamiento.

### 3. Armería 2019 Completa
- Estadísticas comparativas idénticas a 2019 (Daño, Rango, Cadencia, Precisión, Recarga):
  - **AK-47**: Alto daño destructivo con retroceso desafiante.
  - **MP40**: La reina del rusheo a corta distancia con velocidad insuperable.
  - **SCAR**: El fusil más balanceado y versátil para media distancia.
  - **M1014**: Escopeta letal a quemarropa.
  - **AWM**: El legendario rifle de cerrojo de los Drops.
  - **Pared Gloo**: Escudo de hielo defensivo para supervivencia extrema.

### 4. Personajes Clásicos 2019
- **Adán**: El primer sobreviviente de Bermuda, símbolo de habilidad pura.
- **Kelly**: Habilidad *Carrera Veloz* (+6% de velocidad al correr).
- **Andrew**: Habilidad *Especialista en Armadura* (reducción de pérdida de durabilidad del chaleco).
- **Eva**: La pionera clásica de Bermuda.
- **Ford**: Habilidad *Voluntad de Hierro* (resistencia al daño de la zona segura).

### 5. Partida Battle Royale Interactiva en Bermuda
- **Minimapa Radar**: Puntos de interés clásicos (Clock Tower, Peak, Pochinok, Bimasakti, Mill) y zona segura.
- **Controles HUD Clásicos**:
  - Joystick analógico virtual de 360 grados.
  - Botón de disparo con retroceso reactivo y destello de cañón.
  - Botón de mira de precisión telescópica (punto rojo / 4x zoom).
  - Botón de despliegue de **Pared Gloo** instantánea frente al jugador.
  - Botiquín de curación (Medkit) con barra de regeneración gradual.
  - Indicadores numéricos de impacto en pantalla:
    - **Amarillo**: Impacto en el cuerpo.
    - **Rojo crítico (Headshot)**: ¡Tiro a la cabeza letal!
  - Bots enemigos activos en combate con barra de vida e IA de aproximación.
  - Kill Feed militar en vivo en la parte superior.
  - Pantalla final de victoria legendaria: **¡¡BOOYAH!!** con cálculo de bajas, daño y puntos de rango.

### 6. Ajustes de 2019
- **Gráficos**: Suave, Estándar, Ultra (Modo 60 FPS).
- **Sensibilidades**: General, Punto Rojo, Mira 2x, Mira 4x, Mira AWM.
- **Controles**: Precisión de apuntado, cambio rápido y disparo AWM.

---

## 🚀 Compilación Automática (GitHub Actions)

El proyecto cuenta con un workflow integrado en `.github/workflows/build-ipa.yml`:

1. Cada vez que se realiza un `push` a `main`, el pipeline de GitHub Actions se activa automáticamente.
2. Compila el código fuente con `xcodebuild` en un entorno **macOS 14**.
3. Empaqueta el archivo `FreeFire.ipa`.
4. Publica el archivo `.ipa` en los **Releases** de este repositorio para descarga directa.

---

## 📲 Cómo Instalar el archivo IPA en tu iPhone o iPad

1. Ve a la pestaña **[Releases](../../releases)** del repositorio.
2. Descarga el archivo **`FreeFire.ipa`** de la versión más reciente.
3. Instálalo en tu dispositivo con tu método preferido:
   - **TrollStore** (Recomendado para iOS con soporte: instalación directa y permanente).
   - **Sideloadly** (Para Windows y Mac: conecta tu iPhone por USB, arrastra el `.ipa` e introduce tu Apple ID).
   - **AltStore / Sidestore** (Instalación inalámbrica con refresco automático).
   - **Scarlet / Esign** (Instalación directa en el dispositivo móvil).
