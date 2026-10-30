import SwiftUI

struct ArmoryView: View {
    @Binding var selectedWeapon: Weapon
    @Environment(\.dismiss) var dismiss
    @State private var activeCategory: WeaponCategory = .assaultRifle
    
    var filteredWeapons: [Weapon] {
        Weapon.classic2019Weapons.filter { $0.category == activeCategory }
    }
    
    var body: some View {
        ZStack {
            FreeFireTheme.darkBg.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Bar
                HStack {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                            Text("ARMERÍA 2019")
                                .font(.system(size: 16, weight: .black))
                        }
                        .foregroundColor(FreeFireTheme.gold)
                    }
                    
                    Spacer()
                    
                    // Category Picker
                    HStack(spacing: 8) {
                        ForEach(WeaponCategory.allCases, id: \.self) { cat in
                            Button(action: {
                                FreeFireTheme.glooWallHaptic()
                                activeCategory = cat
                            }) {
                                Text(cat.rawValue)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(activeCategory == cat ? .black : .white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(activeCategory == cat ? FreeFireTheme.gold : Color.white.opacity(0.12))
                                    .cornerRadius(4)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 12)
                .background(FreeFireTheme.panelBg)
                
                Divider().background(Color(white: 0.2))
                
                HStack(spacing: 16) {
                    // Left: Weapon List
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(filteredWeapons) { weapon in
                                Button(action: {
                                    FreeFireTheme.gunshotHaptic()
                                    selectedWeapon = weapon
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 3) {
                                            Text(weapon.name)
                                                .font(.system(size: 15, weight: .black))
                                                .foregroundColor(selectedWeapon.id == weapon.id ? FreeFireTheme.gold : .white)
                                            Text("Cartucho: \(weapon.magazineSize) balas")
                                                .font(.system(size: 11))
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: weapon.iconSystemName)
                                            .font(.system(size: 18))
                                            .foregroundColor(selectedWeapon.id == weapon.id ? FreeFireTheme.gold : .gray)
                                    }
                                    .padding(12)
                                    .background(selectedWeapon.id == weapon.id ? FreeFireTheme.panelBg : Color(white: 0.12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(selectedWeapon.id == weapon.id ? FreeFireTheme.gold : Color.clear, lineWidth: 1.5)
                                    )
                                    .cornerRadius(6)
                                }
                            }
                        }
                        .padding(14)
                    }
                    .frame(width: 240)
                    
                    // Right: Weapon Inspection & Stats
                    VStack(alignment: .leading, spacing: 14) {
                        // Weapon Showcase Area
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(FreeFireTheme.panelBg)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(FreeFireTheme.cardBorder, lineWidth: 1.5)
                                )
                            
                            VStack(spacing: 10) {
                                Image(systemName: selectedWeapon.iconSystemName)
                                    .font(.system(size: 72))
                                    .foregroundColor(selectedWeapon.colorTheme)
                                    .shadow(color: selectedWeapon.colorTheme.opacity(0.6), radius: 10)
                                
                                Text(selectedWeapon.name)
                                    .font(.system(size: 26, weight: .black))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(height: 150)
                        
                        // Weapon Description
                        Text(selectedWeapon.description)
                            .font(.system(size: 13))
                            .foregroundColor(Color.white.opacity(0.85))
                        
                        // Stat Bars (Classic Free Fire stat display)
                        VStack(spacing: 8) {
                            StatBarRow(label: "DAÑO", value: selectedWeapon.damage)
                            StatBarRow(label: "RANGO", value: selectedWeapon.range)
                            StatBarRow(label: "CADENCIA", value: selectedWeapon.rateOfFire)
                            StatBarRow(label: "PRECISIÓN", value: selectedWeapon.accuracy)
                            StatBarRow(label: "VEL. RECARGA", value: selectedWeapon.reloadSpeed)
                        }
                        
                        Spacer()
                        
                        // Equip Button
                        Button(action: {
                            FreeFireTheme.booyahVictoryHaptic()
                            dismiss()
                        }) {
                            Text("EQUIPAR EN EL LOBBY")
                                .font(.system(size: 15, weight: .black))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(FreeFireTheme.gold)
                                .cornerRadius(6)
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.vertical, 12)
                }
            }
        }
    }
}

struct StatBarRow: View {
    let label: String
    let value: Int
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 11, weight: .black))
                .foregroundColor(.gray)
                .frame(width: 90, alignment: .leading)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(white: 0.18))
                    .frame(height: 8)
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(
                        LinearGradient(
                            colors: [FreeFireTheme.gold, .yellow],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: CGFloat(value) * 1.8, height: 8)
            }
            
            Text("\(value)")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 30, alignment: .trailing)
        }
    }
}
