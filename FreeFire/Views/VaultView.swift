import SwiftUI

struct VaultView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userState = UserState.shared
    
    @State private var activeCategory: CosmeticType = .bundle
    @State private var selectedItem: CosmeticItem? = nil
    
    var itemsForCategory: [CosmeticItem] {
        CosmeticItem.classic2019Cosmetics.filter { $0.category == activeCategory }
    }
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header
                HStack(spacing: 16) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .bold))
                            Text("SALIR")
                                .font(.system(size: 14, weight: .black))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(6)
                    }
                    
                    HStack(spacing: 6) {
                        Image(systemName: "archivebox.fill")
                            .foregroundColor(FreeFireTheme.gold)
                        Text("BÓVEDA / INVENTARIO 2019")
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("EQUIPA TRAJES POR PIEZAS")
                        .font(.system(size: 11, weight: .heavy))
                        .foregroundColor(FreeFireTheme.gold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(4)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(FreeFireTheme.secondaryDark)
                
                // Main Content
                HStack(spacing: 0) {
                    // Left: Visual Preview of Equipped Combination
                    VStack(spacing: 14) {
                        Text("VISTA EN VIVO")
                            .font(.system(size: 11, weight: .black))
                            .foregroundColor(.gray)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(colors: [Color.black.opacity(0.7), Color(red: 0.1, green: 0.12, blue: 0.15)], startPoint: .top, endPoint: .bottom))
                                .frame(width: 170, height: 260)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(FreeFireTheme.gold.opacity(0.5), lineWidth: 1.5))
                            
                            VStack(spacing: 4) {
                                // Head slot preview
                                Image(systemName: userState.equippedHead.isEmpty ? "person.crop.circle" : "theatermasks.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(.pink)
                                
                                // Top slot preview
                                Image(systemName: "tshirt.fill")
                                    .font(.system(size: 54))
                                    .foregroundColor(userState.equippedTop.contains("sakura") ? .pink : userState.equippedTop.contains("hiphop") ? .yellow : .red)
                                
                                // Pants slot preview
                                Image(systemName: "figure.walk")
                                    .font(.system(size: 60))
                                    .foregroundColor(userState.equippedPants.contains("angelic") ? .cyan : .purple)
                                
                                // Shoes preview
                                Image(systemName: "shoeprints.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        VStack(spacing: 2) {
                            Text("CONJUNTO ACTIVO:")
                                .font(.system(size: 9, weight: .black))
                                .foregroundColor(.gray)
                            Text(userState.equippedBundle.isEmpty ? "PIEZAS INDIVIDUALES" : userState.equippedBundle.replacingOccurrences(of: "bundle_", with: "").uppercased())
                                .font(.system(size: 11, weight: .black))
                                .foregroundColor(FreeFireTheme.gold)
                        }
                    }
                    .frame(width: 200)
                    .padding(14)
                    
                    Divider().background(Color.white.opacity(0.12))
                    
                    // Middle: Category Tabs
                    VStack(spacing: 6) {
                        ForEach(CosmeticType.allCases.filter { $0 != .pets }) { cat in
                            Button(action: {
                                activeCategory = cat
                                SoundManager.shared.playButtonClick()
                                if let first = itemsForCategory.first {
                                    selectedItem = first
                                }
                            }) {
                                HStack {
                                    Text(cat.rawValue)
                                        .font(.system(size: 12, weight: .black))
                                        .foregroundColor(activeCategory == cat ? .black : .white)
                                    Spacer()
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                .background(activeCategory == cat ? FreeFireTheme.gold : Color.black.opacity(0.4))
                                .cornerRadius(6)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 150)
                    .padding(14)
                    
                    Divider().background(Color.white.opacity(0.12))
                    
                    // Right: Items List
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 110, maximum: 130), spacing: 12)], spacing: 12) {
                            ForEach(itemsForCategory) { item in
                                let isEquipped = checkIsEquipped(item)
                                let isOwned = userState.ownedCosmetics.contains(item.id)
                                
                                Button(action: {
                                    selectedItem = item
                                    if isOwned {
                                        equipItem(item)
                                    }
                                    SoundManager.shared.playButtonClick()
                                }) {
                                    VStack(spacing: 6) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(
                                                    LinearGradient(
                                                        colors: [item.primaryColor.opacity(0.35), item.secondaryColor.opacity(0.5)],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                                .frame(height: 80)
                                            
                                            Image(systemName: item.iconName)
                                                .font(.system(size: 32))
                                                .foregroundColor(item.rarity.color)
                                            
                                            if isEquipped {
                                                VStack {
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "checkmark.circle.fill")
                                                            .foregroundColor(FreeFireTheme.gold)
                                                            .font(.system(size: 14))
                                                    }
                                                    Spacer()
                                                }
                                                .padding(4)
                                            }
                                        }
                                        
                                        Text(item.name)
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                        
                                        if isEquipped {
                                            Text("EQUIPADO")
                                                .font(.system(size: 8, weight: .black))
                                                .padding(.horizontal, 6)
                                                .padding(.vertical, 2)
                                                .background(FreeFireTheme.gold)
                                                .foregroundColor(.black)
                                                .cornerRadius(3)
                                        } else if isOwned {
                                            Text("EN BÓVEDA")
                                                .font(.system(size: 8, weight: .heavy))
                                                .foregroundColor(.gray)
                                        } else {
                                            Text("BLOQUEADO")
                                                .font(.system(size: 8, weight: .heavy))
                                                .foregroundColor(.red.opacity(0.8))
                                        }
                                    }
                                    .padding(8)
                                    .background(isEquipped ? Color.white.opacity(0.15) : Color.black.opacity(0.35))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(isEquipped ? FreeFireTheme.gold : Color.clear, lineWidth: 1.5)
                                    )
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding(16)
                    }
                }
            }
        }
    }
    
    private func checkIsEquipped(_ item: CosmeticItem) -> Bool {
        if item.category == .bundle {
            return userState.equippedBundle == item.id
        } else if item.category == .head {
            return userState.equippedHead == item.id
        } else if item.category == .top {
            return userState.equippedTop == item.id
        } else if item.category == .pants {
            return userState.equippedPants == item.id
        } else if item.category == .shoes {
            return userState.equippedShoes == item.id
        }
        return false
    }
    
    private func equipItem(_ item: CosmeticItem) {
        let catStr = item.category == .bundle ? "bundle" : item.category == .head ? "head" : item.category == .top ? "top" : item.category == .pants ? "pants" : "shoes"
        userState.equipCosmetic(id: item.id, category: catStr)
    }
}

