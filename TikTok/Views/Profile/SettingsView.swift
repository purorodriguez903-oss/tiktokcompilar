import SwiftUI

struct SettingsView: View {
    @ObservedObject var languageManager = LanguageManager.shared
    @Environment(\.dismiss) var dismiss
    @State private var cacheCleared: Bool = false
    @State private var cacheSize: String = "248.5 MB"
    @State private var showLanguagePicker: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                TikTokTheme.darkBg.ignoresSafeArea()
                
                List {
                    // Language Selection Section
                    Section(header: Text(languageManager.t("settings_content")).foregroundColor(.gray)) {
                        // Current Language row
                        Button(action: {
                            showLanguagePicker = true
                        }) {
                            HStack {
                                Image(systemName: "globe")
                                    .foregroundColor(TikTokTheme.cyan)
                                    .frame(width: 24)
                                
                                Text(languageManager.t("settings_language"))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("\(languageManager.currentLanguage.flag) \(languageManager.currentLanguage.displayName)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Dark Mode Toggle
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.purple)
                                .frame(width: 24)
                            Text(languageManager.t("settings_dark_mode"))
                                .foregroundColor(.white)
                            Spacer()
                            Text("Activado")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }
                    }
                    .listRowBackground(Color(white: 0.12))
                    
                    // TikTok Shop Section
                    Section(header: Text("TIKTOK SHOP").foregroundColor(.gray)) {
                        HStack {
                            Image(systemName: "bag.fill")
                                .foregroundColor(TikTokTheme.yellow)
                                .frame(width: 24)
                            Text(languageManager.t("shop_orders"))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Image(systemName: "ticket.fill")
                                .foregroundColor(TikTokTheme.red)
                                .frame(width: 24)
                            Text(languageManager.t("shop_coupons"))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                    }
                    .listRowBackground(Color(white: 0.12))
                    
                    // Account Section
                    Section(header: Text(languageManager.t("settings_account")).foregroundColor(.gray)) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(TikTokTheme.cyan)
                                .frame(width: 24)
                            Text(languageManager.t("settings_manage_acc"))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Image(systemName: "lock.shield.fill")
                                .foregroundColor(.green)
                                .frame(width: 24)
                            Text(languageManager.t("settings_privacy"))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                    }
                    .listRowBackground(Color(white: 0.12))
                    
                    // Cache & Storage
                    Section(header: Text("ALMACENAMIENTO").foregroundColor(.gray)) {
                        Button(action: {
                            TikTokTheme.hapticNotification(.success)
                            withAnimation {
                                cacheSize = "0.0 MB"
                                cacheCleared = true
                            }
                        }) {
                            HStack {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(TikTokTheme.red)
                                    .frame(width: 24)
                                Text(languageManager.t("settings_cache"))
                                    .foregroundColor(.white)
                                Spacer()
                                Text(cacheSize)
                                    .foregroundColor(cacheCleared ? .green : .gray)
                                    .font(.system(size: 14))
                            }
                        }
                        
                        if cacheCleared {
                            Text(languageManager.t("settings_cache_cleared"))
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.green)
                        }
                    }
                    .listRowBackground(Color(white: 0.12))
                    
                    // Support & About
                    Section(header: Text(languageManager.t("settings_support")).foregroundColor(.gray)) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(.blue)
                                .frame(width: 24)
                            Text(languageManager.t("settings_help_center"))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.gray)
                                .frame(width: 24)
                            Text(languageManager.t("settings_version"))
                                .foregroundColor(.gray)
                                .font(.system(size: 13))
                        }
                    }
                    .listRowBackground(Color(white: 0.12))
                    
                    // Logout
                    Section {
                        Button(action: {
                            TikTokTheme.haptic(.heavy)
                            dismiss()
                        }) {
                            HStack {
                                Spacer()
                                Text(languageManager.t("settings_logout"))
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(TikTokTheme.red)
                                Spacer()
                            }
                        }
                    }
                    .listRowBackground(Color(white: 0.12))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle(languageManager.t("settings_title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Listo") { dismiss() }
                        .foregroundColor(.white)
                }
            }
            .confirmationDialog("Seleccionar idioma", isPresented: $showLanguagePicker, titleVisibility: .visible) {
                ForEach(AppLanguage.allCases) { lang in
                    Button("\(lang.flag) \(lang.displayName)") {
                        TikTokTheme.hapticNotification(.success)
                        languageManager.currentLanguage = lang
                    }
                }
                Button("Cancelar", role: .cancel) {}
            }
        }
    }
}
