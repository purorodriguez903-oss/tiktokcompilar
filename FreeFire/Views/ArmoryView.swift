import SwiftUI

struct ArmoryView: View {
    @Binding var selectedWeapon: Weapon
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userState = UserState.shared
    
    @State private var activeCategory: WeaponCategory = .assaultRifle
    @State private var selectedSkin: WeaponSkin? = WeaponSkin.classic2019Skins[0]
    @State private var showingSkinsTab: Bool = false
    
    var filteredWeapons: [Weapon] {
        Weapon.classic2019Weapons.filter { $0.category == activeCategory }
    }
    
    var skinsForSelectedWeapon: [WeaponSkin] {
        WeaponSkin.classic2019Skins.filter { $0.weaponId == selectedWeapon.id }
    }
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header Bar
                HStack(spacing: 14) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .bold))
                            Text("SALIR")
                                .font(.system(size: 14, weight: .black))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(6)
                    }
                    
                    Text("ARMERÍA CLÁSICA 2019")
                        .font(.system(size: 18, weight: .black))
                        .foregroundColor(FreeFireTheme.gold)
                    
                    Spacer()
                    
                    // Toggle Skins vs Base Guns
                    HStack(spacing: 4) {
                        Button("ARMAS BASE") {
                            showingSkinsTab = false
                            SoundManager.shared.playButtonClick()
                        }
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(showingSkinsTab ? .gray : .black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(!showingSkinsTab ? FreeFireTheme.gold : Color.black.opacity(0.4))
                        .cornerRadius(4)
                        
                        Button("SKINS CON ATRIBUTOS") {
                            showingSkinsTab = true
                            SoundManager.shared.playButtonClick()
                        }
                        .font(.system(size: 11, weight: .black))
                        .foregroundColor(!showingSkinsTab ? .gray : .black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(showingSkinsTab ? FreeFireTheme.gold : Color.black.opacity(0.4))
                        .cornerRadius(4)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(FreeFireTheme.secondaryDark)
                
                // Categories Bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(WeaponCategory.allCases) { cat in
                            Button(action: {
                                activeCategory = cat
                                if let first = Weapon.classic2019Weapons.first(where: { $0.category == cat }) {
                                    selectedWeapon = first
                                    selectedSkin = skinsForSelectedWeapon.first
                                }
                                SoundManager.shared.playButtonClick()
                            }) {
                                Text(cat.rawValue)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(activeCategory == cat ? .black : .white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(activeCategory == cat ? FreeFireTheme.gold : Color.white.opacity(0.08))
                                    .cornerRadius(4)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .background(Color.black.opacity(0.3))
                
                // Main Content
                HStack(spacing: 16) {
                    // Left: Weapon List
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 8) {
                            ForEach(filteredWeapons) { weapon in
                                Button(action: {
                                    selectedWeapon = weapon
                                    selectedSkin = skinsForSelectedWeapon.first
                                    FreeFireTheme.gunshotHaptic()
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(weapon.name)
                                                .font(.system(size: 14, weight: .black))
                                                .foregroundColor(selectedWeapon.id == weapon.id ? FreeFireTheme.gold : .white)
                                            Text("Daño: \(weapon.damage) | Cadencia: \(weapon.rateOfFire)")
                                                .font(.system(size: 10))
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: weapon.iconSystemName)
                                            .font(.system(size: 16))
                                            .foregroundColor(selectedWeapon.id == weapon.id ? FreeFireTheme.gold : .gray)
                                    }
                                    .padding(10)
                                    .background(selectedWeapon.id == weapon.id ? Color.white.opacity(0.12) : Color.black.opacity(0.3))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(selectedWeapon.id == weapon.id ? FreeFireTheme.gold : Color.clear, lineWidth: 1.5)
                                    )
                                    .cornerRadius(6)
                                }
                            }
                        }
                        .padding(12)
                    }
                    .frame(width: 220)
                    
                    Divider().background(Color.white.opacity(0.12))
                    
                    // Middle / Right: Weapon Inspection & Skin Attributes
                    VStack(alignment: .leading, spacing: 12) {
                        // Showcase Banner
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    RadialGradient(
                                        colors: [selectedWeapon.colorTheme.opacity(0.3), Color.black.opacity(0.8)],
                                        center: .center,
                                        startRadius: 10,
                                        endRadius: 180
                                    )
                                )
                                .frame(height: 110)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(FreeFireTheme.gold.opacity(0.6), lineWidth: 1))
                            
                            VStack(spacing: 4) {
                                Image(systemName: selectedWeapon.iconSystemName)
                                    .font(.system(size: 48))
                                    .foregroundColor(selectedSkin != nil && showingSkinsTab ? selectedSkin!.color : selectedWeapon.colorTheme)
                                    .shadow(color: (selectedSkin?.color ?? selectedWeapon.colorTheme).opacity(0.8), radius: 8)
                                
                                Text(showingSkinsTab && selectedSkin != nil ? selectedSkin!.name : selectedWeapon.name)
                                    .font(.system(size: 16, weight: .black))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // If in Skins mode, show available skins selector
                        if showingSkinsTab && !skinsForSelectedWeapon.isEmpty {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("SKINS EXCLUSIVAS DE 2019:")
                                    .font(.system(size: 11, weight: .black))
                                    .foregroundColor(.gray)
                                
                                HStack(spacing: 10) {
                                    ForEach(skinsForSelectedWeapon) { skin in
                                        Button(action: {
                                            selectedSkin = skin
                                            userState.equippedWeaponSkinId = skin.id
                                            FreeFireTheme.booyahVictoryHaptic()
                                        }) {
                                            VStack(spacing: 2) {
                                                Text(skin.name)
                                                    .font(.system(size: 10, weight: .black))
                                                    .foregroundColor(selectedSkin?.id == skin.id ? .black : .white)
                                                    .lineLimit(1)
                                                
                                                HStack(spacing: 4) {
                                                    if skin.damageBonus > 0 {
                                                        Text("+\(skin.damageBonus) Daño")
                                                            .font(.system(size: 8, weight: .heavy))
                                                            .foregroundColor(.green)
                                                    }
                                                    if skin.rateOfFireBonus > 0 {
                                                        Text("+\(skin.rateOfFireBonus) Cadencia")
                                                            .font(.system(size: 8, weight: .heavy))
                                                            .foregroundColor(.green)
                                                    }
                                                }
                                            }
                                            .padding(8)
                                            .background(selectedSkin?.id == skin.id ? FreeFireTheme.gold : Color.black.opacity(0.5))
                                            .cornerRadius(6)
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Stat Bars
                        VStack(spacing: 6) {
                            StatBarRow(title: "DAÑO", value: selectedWeapon.damage + (showingSkinsTab ? (selectedSkin?.damageBonus ?? 0) * 5 : 0), maxVal: 100, color: .red)
                            StatBarRow(title: "RANGO", value: selectedWeapon.range + (showingSkinsTab ? (selectedSkin?.rangeBonus ?? 0) * 5 : 0), maxVal: 100, color: .blue)
                            StatBarRow(title: "CADENCIA", value: selectedWeapon.rateOfFire + (showingSkinsTab ? (selectedSkin?.rateOfFireBonus ?? 0) * 5 : 0), maxVal: 100, color: .orange)
                            StatBarRow(title: "PRECISIÓN", value: selectedWeapon.accuracy, maxVal: 100, color: .yellow)
                            StatBarRow(title: "VELOCIDAD DE RECARGA", value: selectedWeapon.reloadSpeed + (showingSkinsTab ? (selectedSkin?.reloadBonus ?? 0) * 5 : 0), maxVal: 100, color: .green)
                        }
                        
                        Spacer()
                        
                        // Equip button
                        Button(action: {
                            userState.equippedWeaponId = selectedWeapon.id
                            if let s = selectedSkin {
                                userState.equippedWeaponSkinId = s.id
                            }
                            FreeFireTheme.booyahVictoryHaptic()
                            dismiss()
                        }) {
                            Text("EQUIPAR PARA COMBATE")
                                .font(.system(size: 14, weight: .black))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(FreeFireTheme.gold)
                                .cornerRadius(6)
                        }
                    }
                    .padding(14)
                }
            }
        }
    }
}

struct StatBarRow: View {
    let title: String
    let value: Int
    let maxVal: Int
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.system(size: 10, weight: .black))
                .foregroundColor(.gray)
                .frame(width: 140, alignment: .leading)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.white.opacity(0.1))
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(color)
                        .frame(width: geo.size.width * CGFloat(min(value, maxVal)) / CGFloat(maxVal))
                }
            }
            .frame(height: 8)
            
            Text("\(value)")
                .font(.system(size: 11, weight: .heavy))
                .foregroundColor(.white)
                .frame(width: 30, alignment: .trailing)
        }
    }
}
