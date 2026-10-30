import SwiftUI

struct Settings2019View: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userState = UserState.shared
    
    enum MainSection: String, CaseIterable, Identifiable {
        case duringMatch = "DURANTE LAS PARTIDAS"
        case screen = "PANTALLA"
        case sound = "SONIDO"
        case recording = "GRABACIÓN"
        case notification = "NOTIFICACIÓN"
        case account = "CUENTA Y BÁSICO"
        
        var id: String { rawValue }
    }
    
    enum SubMatchSection: String, CaseIterable, Identifiable {
        case hud = "HUD"
        case controls = "CONTROLES"
        case info = "INFORMACIÓN"
        case sensitivity = "SENSIBILIDAD"
        case autoPickup = "TOMAR AUTOMÁTICAMENTE"
        case vibration = "VIBRACIÓN"
        
        var id: String { rawValue }
    }
    
    @State private var activeMainSection: MainSection = .duringMatch
    @State private var activeSubSection: SubMatchSection = .info
    
    // Sensitivity Sliders
    @AppStorage("sensGeneral") private var sensGeneral: Double = 95
    @AppStorage("sensRedDot") private var sensRedDot: Double = 90
    @AppStorage("sens2x") private var sens2x: Double = 85
    @AppStorage("sens4x") private var sens4x: Double = 80
    @AppStorage("sensAWM") private var sensAWM: Double = 50
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header (Exact match to video ff2019_04.jpg)
                HStack {
                    Spacer()
                    Text("AJUSTES")
                        .font(.system(size: 16, weight: .black))
                        .foregroundColor(.white)
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.12))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(FreeFireTheme.secondaryDark)
                
                // Body Layout
                HStack(spacing: 0) {
                    // Left Main Tabs (DURANTE LAS PARTIDAS, PANTALLA, etc.)
                    VStack(spacing: 4) {
                        ForEach(MainSection.allCases) { sec in
                            Button(action: {
                                activeMainSection = sec
                                SoundManager.shared.playButtonClick()
                            }) {
                                HStack {
                                    Text(sec.rawValue)
                                        .font(.system(size: 11, weight: .black))
                                        .foregroundColor(activeMainSection == sec ? .black : .white)
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 10)
                                .background(activeMainSection == sec ? FreeFireTheme.gold : Color.black.opacity(0.4))
                                .cornerRadius(4)
                            }
                        }
                        
                        Spacer()
                        
                        // Region & Nick (Exact match to video: NORTE AMÉRICA | Rafa OxModz)
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 4) {
                                Image(systemName: "globe").font(.system(size: 9)).foregroundColor(.gray)
                                Text(userState.region).font(.system(size: 8, weight: .bold)).foregroundColor(.gray)
                            }
                            Text("Rafa | OxModz").font(.system(size: 9, weight: .black)).foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    }
                    .frame(width: 160)
                    .padding(8)
                    
                    Divider().background(Color.white.opacity(0.12))
                    
                    // Right Content Area
                    VStack(spacing: 0) {
                        // Subtabs when in "DURANTE LAS PARTIDAS" (HUD, CONTROLES, INFORMACIÓN, etc.)
                        if activeMainSection == .duringMatch {
                            HStack(spacing: 6) {
                                ForEach(SubMatchSection.allCases) { sub in
                                    Button(action: {
                                        activeSubSection = sub
                                        SoundManager.shared.playButtonClick()
                                    }) {
                                        Text(sub.rawValue)
                                            .font(.system(size: 9, weight: .black))
                                            .foregroundColor(activeSubSection == sub ? .black : .white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 6)
                                            .background(activeSubSection == sub ? Color.white : Color.black.opacity(0.4))
                                            .cornerRadius(4)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color.black.opacity(0.25))
                        }
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 14) {
                                if activeMainSection == .duringMatch && activeSubSection == .info {
                                    informationVisualSettingsView
                                } else if activeMainSection == .duringMatch && activeSubSection == .sensitivity {
                                    sensitivitySettingsView
                                } else if activeMainSection == .account {
                                    accountSettingsView
                                } else {
                                    informationVisualSettingsView
                                }
                            }
                            .padding(16)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - INFORMACIÓN (Visual settings from user video ff2019_04.jpg)
    private var informationVisualSettingsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("VISUAL")
                .font(.system(size: 12, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
            
            toggleOptionRow(title: "Tipo de Punto de Mira", opt1: "Clásico", opt2: "Nuevo", selected: $userState.crosshairType)
            toggleOptionRow(title: "Indicador de Daño", opt1: "Clásico", opt2: "Nuevo", selected: $userState.damageIndicatorType)
            toggleOptionRow(title: "Efectos de Golpe/Herida", opt1: "Oscuro", opt2: "Sin sangre", selected: $userState.hitEffectType)
            toggleOptionRow(title: "Marcadores de impacto", opt1: "Clásico", opt2: "Nuevo", selected: $userState.impactMarkersType)
            
            toggleBooleanRow(title: "Sugerencias de mensajes", isOn: $userState.messageSuggestions)
            toggleBooleanRow(title: "Apodo del Compañero", isOn: $userState.teammateNickname)
            toggleBooleanRow(title: "Contorno enemigo", isOn: $userState.enemyOutline)
        }
    }
    
    private func toggleOptionRow(title: String, opt1: String, opt2: String, selected: Binding<String>) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            HStack(spacing: 2) {
                Button(action: { selected.wrappedValue = opt1 }) {
                    Text(opt1)
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(selected.wrappedValue == opt1 ? .black : .white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 5)
                        .background(selected.wrappedValue == opt1 ? Color.white : Color.black.opacity(0.5))
                        .cornerRadius(3)
                }
                Button(action: { selected.wrappedValue = opt2 }) {
                    Text(opt2)
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(selected.wrappedValue == opt2 ? .black : .white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 5)
                        .background(selected.wrappedValue == opt2 ? Color.white : Color.black.opacity(0.5))
                        .cornerRadius(3)
                }
            }
            .padding(2)
            .background(Color.black.opacity(0.6))
            .cornerRadius(4)
        }
        .padding(8)
        .background(Color.white.opacity(0.04))
        .cornerRadius(6)
    }
    
    private func toggleBooleanRow(title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            HStack(spacing: 2) {
                Button(action: { isOn.wrappedValue = false }) {
                    Text("Apagado")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(!isOn.wrappedValue ? .black : .white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(!isOn.wrappedValue ? Color.white : Color.black.opacity(0.5))
                        .cornerRadius(3)
                }
                Button(action: { isOn.wrappedValue = true }) {
                    Text("Encendido")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(isOn.wrappedValue ? .black : .white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(isOn.wrappedValue ? Color.white : Color.black.opacity(0.5))
                        .cornerRadius(3)
                }
            }
            .padding(2)
            .background(Color.black.opacity(0.6))
            .cornerRadius(4)
        }
        .padding(8)
        .background(Color.white.opacity(0.04))
        .cornerRadius(6)
    }
    
    // MARK: - SENSIBILIDAD
    private var sensitivitySettingsView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("SENSIBILIDAD DE APUNTADO")
                .font(.system(size: 12, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
            
            sensSlider(title: "General", val: $sensGeneral)
            sensSlider(title: "Punto Rojo", val: $sensRedDot)
            sensSlider(title: "Mira 2x", val: $sens2x)
            sensSlider(title: "Mira 4x", val: $sens4x)
            sensSlider(title: "Mira Francotirador (AWM)", val: $sensAWM)
        }
    }
    
    private func sensSlider(title: String, val: Binding<Double>) -> some View {
        VStack(spacing: 2) {
            HStack {
                Text(title).font(.system(size: 11, weight: .bold)).foregroundColor(.white)
                Spacer()
                Text("\(Int(val.wrappedValue))").font(.system(size: 11, weight: .black)).foregroundColor(FreeFireTheme.gold)
            }
            Slider(value: val, in: 0...100, step: 1).accentColor(FreeFireTheme.gold)
        }
        .padding(8)
        .background(Color.white.opacity(0.04))
        .cornerRadius(6)
    }
    
    // MARK: - CUENTA Y BÁSICO (From video ff2019_03.jpg)
    private var accountSettingsView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("CUENTA")
                .font(.system(size: 12, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
            
            HStack {
                Text("Estado: Google • Rafa (0xModz)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text("Vinculada")
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(.green)
            }
            .padding(10)
            .background(Color.white.opacity(0.04))
            .cornerRadius(6)
            
            HStack {
                Text("Idioma:")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text("Español")
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(FreeFireTheme.gold)
            }
            .padding(10)
            .background(Color.white.opacity(0.04))
            .cornerRadius(6)
            
            HStack {
                Text("Caché del juego:")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Button("Borrar Caché") {
                    SoundManager.shared.playButtonClick()
                }
                .font(.system(size: 10, weight: .black))
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.white)
                .cornerRadius(4)
            }
            .padding(10)
            .background(Color.white.opacity(0.04))
            .cornerRadius(6)
        }
    }
}
