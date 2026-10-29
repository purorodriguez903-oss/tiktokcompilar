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
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Section: Cache & Cellular (Frame 017)
                        SettingsSectionHeader(title: "Cache & Cellular")
                        
                        VStack(spacing: 0) {
                            SettingsNavigationRow(icon: "arrow.down.circle", title: "Offline videos")
                            Divider().background(Color(white: 0.16)).padding(.leading, 50)
                            
                            Button(action: {
                                TikTokTheme.hapticNotification(.success)
                                withAnimation {
                                    cacheSize = "0.0 MB"
                                    cacheCleared = true
                                }
                            }) {
                                HStack(spacing: 16) {
                                    Image(systemName: "trash")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .frame(width: 24)
                                    
                                    Text("Free up space")
                                        .font(.system(size: 15))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text(cacheSize)
                                        .font(.system(size: 13))
                                        .foregroundColor(cacheCleared ? .green : .gray)
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                            }
                            
                            Divider().background(Color(white: 0.16)).padding(.leading, 50)
                            SettingsNavigationRow(icon: "drop", title: "Data Saver")
                        }
                        .background(Color(white: 0.12))
                        .cornerRadius(10)
                        
                        // Section: App Language & TikTok Shop
                        SettingsSectionHeader(title: "Content & Display")
                        VStack(spacing: 0) {
                            Button(action: { showLanguagePicker = true }) {
                                HStack(spacing: 16) {
                                    Image(systemName: "globe")
                                        .font(.system(size: 18))
                                        .foregroundColor(TikTokTheme.cyan)
                                        .frame(width: 24)
                                    
                                    Text("App Language")
                                        .font(.system(size: 15))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("\(languageManager.currentLanguage.flag) \(languageManager.currentLanguage.displayName)")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                            }
                            
                            Divider().background(Color(white: 0.16)).padding(.leading, 50)
                            SettingsNavigationRow(icon: "bag", title: "TikTok Shop Orders")
                        }
                        .background(Color(white: 0.12))
                        .cornerRadius(10)
                        
                        // Section: Support & About (Frame 017)
                        SettingsSectionHeader(title: "Support & About")
                        VStack(spacing: 0) {
                            SettingsNavigationRow(icon: "headphones", title: "Help Center")
                            Divider().background(Color(white: 0.16)).padding(.leading, 50)
                            SettingsNavigationRow(icon: "lock.shield", title: "Privacy Center")
                            Divider().background(Color(white: 0.16)).padding(.leading, 50)
                            SettingsNavigationRow(icon: "info.circle", title: "Terms and Policies")
                        }
                        .background(Color(white: 0.12))
                        .cornerRadius(10)
                        
                        // Section: Login (Frame 017)
                        SettingsSectionHeader(title: "Login")
                        VStack(spacing: 0) {
                            HStack(spacing: 16) {
                                Image(systemName: "arrow.left.arrow.right")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .frame(width: 24)
                                
                                Text("Switch account")
                                    .font(.system(size: 15))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Circle()
                                    .fill(Color(white: 0.3))
                                    .frame(width: 26, height: 26)
                                    .overlay(
                                        Text("A")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.white)
                                    )
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            
                            Divider().background(Color(white: 0.16)).padding(.leading, 50)
                            
                            Button(action: {
                                TikTokTheme.haptic(.medium)
                                dismiss()
                            }) {
                                HStack(spacing: 16) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.system(size: 16))
                                        .foregroundColor(TikTokTheme.red)
                                        .frame(width: 24)
                                    
                                    Text("Log out")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(TikTokTheme.red)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                            }
                        }
                        .background(Color(white: 0.12))
                        .cornerRadius(10)
                        
                        // Exact Version String (Frame 017)
                        VStack {
                            Text("v47.4.0 (4740320)")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.top, 16)
                                .padding(.bottom, 24)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
            }
            .navigationTitle("Settings and privacy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            .confirmationDialog("App Language", isPresented: $showLanguagePicker, titleVisibility: .visible) {
                ForEach(AppLanguage.allCases) { lang in
                    Button("\(lang.flag) \(lang.displayName)") {
                        TikTokTheme.hapticNotification(.success)
                        languageManager.currentLanguage = lang
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

struct SettingsSectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(.gray)
            .padding(.horizontal, 4)
    }
}

struct SettingsNavigationRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button(action: { TikTokTheme.haptic(.light) }) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 24)
                
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
    }
}
