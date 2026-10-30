import SwiftUI

struct Settings2019View: View {
    @Environment(\.dismiss) private var dismiss
    
    enum SettingsTab: String, CaseIterable {
        case basic = "BÁSICA"
        case sensitivity = "SENSIBILIDAD"
        case controls = "CONTROLES"
        case sound = "SONIDO"
    }
    
    @State private var selectedTab: SettingsTab = .sensitivity
    
    // Graphics
    @AppStorage("graphicsQuality") private var graphicsQuality: String = "Ultra"
    @AppStorage("highFps") private var highFps: Bool = true
    
    // Sensitivity (Classic 2019 sliders)
    @AppStorage("sensGeneral") private var sensGeneral: Double = 95
    @AppStorage("sensRedDot") private var sensRedDot: Double = 90
    @AppStorage("sens2x") private var sens2x: Double = 85
    @AppStorage("sens4x") private var sens4x: Double = 80
    @AppStorage("sensAWM") private var sensAWM: Double = 50
    
    // Controls
    @AppStorage("aimAssist") private var aimAssist: String = "Por defecto"
    @AppStorage("quickWeaponSwitch") private var quickWeaponSwitch: Bool = true
    @AppStorage("quickReload") private var quickReload: Bool = true
    @AppStorage("awmHoldToFire") private var awmHoldToFire: Bool = true
    
    // Sound
    @AppStorage("musicVolume") private var musicVolume: Double = 70
    @AppStorage("sfxVolume") private var sfxVolume: Double = 100
    @AppStorage("voiceVolume") private var voiceVolume: Double = 80
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .bold))
                            Text("CERRAR")
                                .font(.system(size: 13, weight: .heavy))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(6)
                    }
                    
                    Text("AJUSTES DEL JUEGO (2019)")
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(FreeFireTheme.gold)
                    
                    Spacer()
                    
                    Button("RESTABLECER") {
                        sensGeneral = 95
                        sensRedDot = 90
                        sens2x = 85
                        sens4x = 80
                        sensAWM = 50
                    }
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(4)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(FreeFireTheme.secondaryDark)
                
                // Body
                HStack(spacing: 0) {
                    // Left Tabs
                    VStack(spacing: 6) {
                        ForEach(SettingsTab.allCases, id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                                SoundManager.shared.playButtonClick()
                            }) {
                                HStack {
                                    Text(tab.rawValue)
                                        .font(.system(size: 14, weight: .black))
                                        .foregroundColor(selectedTab == tab ? .black : .white)
                                    Spacer()
                                    if selectedTab == tab {
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(selectedTab == tab ? FreeFireTheme.gold : Color.black.opacity(0.3))
                                .cornerRadius(6)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 180)
                    .padding(14)
                    
                    Divider().background(Color.white.opacity(0.15))
                    
                    // Right Content
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            switch selectedTab {
                            case .basic:
                                basicSettingsView
                            case .sensitivity:
                                sensitivitySettingsView
                            case .controls:
                                controlsSettingsView
                            case .sound:
                                soundSettingsView
                            }
                        }
                        .padding(20)
                    }
                }
            }
        }
    }
    
    // MARK: - Sensitivity Tab
    private var sensitivitySettingsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("CONFIGURACIÓN DE SENSIBILIDAD")
                .font(.system(size: 14, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
            
            sensitivitySlider(title: "General", value: $sensGeneral)
            sensitivitySlider(title: "Punto Rojo", value: $sensRedDot)
            sensitivitySlider(title: "Mira 2x", value: $sens2x)
            sensitivitySlider(title: "Mira 4x", value: $sens4x)
            sensitivitySlider(title: "Mira AWM", value: $sensAWM)
        }
    }
    
    private func sensitivitySlider(title: String, value: Binding<Double>) -> some View {
        VStack(spacing: 4) {
            HStack {
                Text(title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text("\(Int(value.wrappedValue))")
                    .font(.system(size: 13, weight: .black))
                    .foregroundColor(FreeFireTheme.gold)
                    .frame(width: 40, alignment: .trailing)
            }
            
            Slider(value: value, in: 0...100, step: 1)
                .accentColor(FreeFireTheme.gold)
        }
        .padding(10)
        .background(Color.white.opacity(0.04))
        .cornerRadius(6)
    }
    
    // MARK: - Basic Tab
    private var basicSettingsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("GRÁFICOS")
                .font(.system(size: 14, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
            
            HStack(spacing: 12) {
                ForEach(["Suave", "Estándar", "Ultra"], id: \.self) { quality in
                    Button(action: {
                        graphicsQuality = quality
                    }) {
                        Text(quality)
                            .font(.system(size: 13, weight: .black))
                            .foregroundColor(graphicsQuality == quality ? .black : .white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(graphicsQuality == quality ? FreeFireTheme.gold : Color.white.opacity(0.08))
                            .cornerRadius(6)
                    }
                }
            }
            
            Toggle(isOn: $highFps) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Alto FPS (60 FPS)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                    Text("Mayor fluidez gráfica durante las partidas de Bermuda.")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
            }
            .toggleStyle(SwitchToggleStyle(tint: FreeFireTheme.gold))
            .padding(12)
            .background(Color.white.opacity(0.04))
            .cornerRadius(6)
        }
    }
    
    // MARK: - Controls Tab
    private var controlsSettingsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("PREFERENCIAS DE COMBATE")
                .font(.system(size: 14, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Precisión de apuntar:")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    ForEach(["Por defecto", "Preciso en mira", "Control total"], id: \.self) { mode in
                        Button(action: {
                            aimAssist = mode
                        }) {
                            Text(mode)
                                .font(.system(size: 11, weight: .black))
                                .foregroundColor(aimAssist == mode ? .black : .white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(aimAssist == mode ? FreeFireTheme.gold : Color.white.opacity(0.08))
                                .cornerRadius(4)
                        }
                    }
                }
            }
            .padding(10)
            .background(Color.white.opacity(0.04))
            .cornerRadius(6)
            
            Toggle("Cambio rápido de armas", isOn: $quickWeaponSwitch)
                .toggleStyle(SwitchToggleStyle(tint: FreeFireTheme.gold))
                .foregroundColor(.white)
                .padding(10)
                .background(Color.white.opacity(0.04))
                .cornerRadius(6)
            
            Toggle("Recarga rápida", isOn: $quickReload)
                .toggleStyle(SwitchToggleStyle(tint: FreeFireTheme.gold))
                .foregroundColor(.white)
                .padding(10)
                .background(Color.white.opacity(0.04))
                .cornerRadius(6)
            
            Toggle("AWM Disparar al soltar", isOn: $awmHoldToFire)
                .toggleStyle(SwitchToggleStyle(tint: FreeFireTheme.gold))
                .foregroundColor(.white)
                .padding(10)
                .background(Color.white.opacity(0.04))
                .cornerRadius(6)
        }
    }
    
    // MARK: - Sound Tab
    private var soundSettingsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("VOLUMEN DE AUDIO")
                .font(.system(size: 14, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
            
            sensitivitySlider(title: "Música de fondo", value: $musicVolume)
            sensitivitySlider(title: "Efectos de sonido (Armas & Pasos)", value: $sfxVolume)
            sensitivitySlider(title: "Voz de escuadra", value: $voiceVolume)
        }
    }
}
