import SwiftUI

struct StoreView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userState = UserState.shared
    
    enum StoreTab: String, CaseIterable, Identifiable {
        case featured = "DESTACADOS"
        case clothing = "ROPA"
        case crates = "CAJAS"
        case characters = "PERSONAJES"
        case pets = "MASCOTAS"
        case magicCube = "CUBO MÁGICO"
        
        var id: String { rawValue }
    }
    
    @State private var selectedTab: StoreTab = .featured
    @State private var selectedItem: CosmeticItem? = CosmeticItem.classic2019Cosmetics[0]
    @State private var showPurchaseSuccess = false
    @State private var purchaseMessage = ""
    
    var filteredItems: [CosmeticItem] {
        switch selectedTab {
        case .featured:
            return CosmeticItem.classic2019Cosmetics.filter { $0.rarity == .legendary }
        case .clothing:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category != .pets }
        case .crates:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .bundle }
        case .characters:
            return []
        case .pets:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .pets }
        case .magicCube:
            return CosmeticItem.classic2019Cosmetics.filter { $0.id.contains("sakura") || $0.id.contains("criminal") }
        }
    }
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header Bar
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
                        Image(systemName: "cart.fill")
                            .foregroundColor(FreeFireTheme.gold)
                        Text("TIENDA CLÁSICA 2019")
                            .font(.system(size: 18, weight: .black))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // Currency display
                    HStack(spacing: 14) {
                        HStack(spacing: 6) {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .foregroundColor(.yellow)
                            Text("\(userState.gold)")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(6)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "diamond.fill")
                                .foregroundColor(.cyan)
                            Text("\(userState.diamonds)")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(6)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "cube.fill")
                                .foregroundColor(.purple)
                            Text("\(userState.magicCubes)")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(6)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(FreeFireTheme.secondaryDark)
                
                // Body Content
                HStack(spacing: 0) {
                    // Left Tab Navigation
                    VStack(spacing: 8) {
                        ForEach(StoreTab.allCases) { tab in
                            Button(action: {
                                selectedTab = tab
                                SoundManager.shared.playButtonClick()
                                if let first = filteredItems.first {
                                    selectedItem = first
                                }
                            }) {
                                HStack {
                                    Text(tab.rawValue)
                                        .font(.system(size: 13, weight: .black))
                                        .foregroundColor(selectedTab == tab ? .black : .white)
                                    Spacer()
                                    if selectedTab == tab {
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: 6, height: 6)
                                    }
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 12)
                                .background(selectedTab == tab ? FreeFireTheme.gold : Color.black.opacity(0.35))
                                .cornerRadius(6)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 170)
                    .padding(14)
                    
                    Divider().background(Color.white.opacity(0.12))
                    
                    // Middle Items Grid
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 140), spacing: 12)], spacing: 12) {
                            ForEach(filteredItems) { item in
                                Button(action: {
                                    selectedItem = item
                                    SoundManager.shared.playButtonClick()
                                }) {
                                    VStack(spacing: 6) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(
                                                    LinearGradient(
                                                        colors: [item.primaryColor.opacity(0.3), item.secondaryColor.opacity(0.5)],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                                .frame(height: 90)
                                            
                                            Image(systemName: item.iconName)
                                                .font(.system(size: 38))
                                                .foregroundColor(item.rarity.color)
                                                .shadow(color: item.rarity.color.opacity(0.6), radius: 6)
                                            
                                            if userState.ownedCosmetics.contains(item.id) {
                                                VStack {
                                                    HStack {
                                                        Spacer()
                                                        Text("OBTENIDO")
                                                            .font(.system(size: 8, weight: .black))
                                                            .padding(.horizontal, 4)
                                                            .padding(.vertical, 2)
                                                            .background(Color.green)
                                                            .foregroundColor(.black)
                                                            .cornerRadius(3)
                                                    }
                                                    Spacer()
                                                }
                                                .padding(4)
                                            }
                                        }
                                        
                                        Text(item.name)
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                        
                                        // Price label
                                        HStack(spacing: 4) {
                                            if let dia = item.priceDiamonds {
                                                Image(systemName: "diamond.fill")
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.cyan)
                                                Text("\(dia)")
                                                    .font(.system(size: 11, weight: .heavy))
                                                    .foregroundColor(.cyan)
                                            } else if let gold = item.priceGold {
                                                Image(systemName: "bitcoinsign.circle.fill")
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.yellow)
                                                Text("\(gold)")
                                                    .font(.system(size: 11, weight: .heavy))
                                                    .foregroundColor(.yellow)
                                            }
                                        }
                                    }
                                    .padding(8)
                                    .background(selectedItem?.id == item.id ? Color.white.opacity(0.15) : Color.black.opacity(0.35))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedItem?.id == item.id ? FreeFireTheme.gold : item.rarity.color.opacity(0.4), lineWidth: 1.5)
                                    )
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding(16)
                    }
                    
                    Divider().background(Color.white.opacity(0.12))
                    
                    // Right Detail & Purchase Panel
                    if let item = selectedItem {
                        VStack(alignment: .leading, spacing: 14) {
                            // Item Big Icon & Rarity
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        RadialGradient(
                                            colors: [item.rarity.color.opacity(0.35), Color.black.opacity(0.8)],
                                            center: .center,
                                            startRadius: 10,
                                            endRadius: 100
                                        )
                                    )
                                    .frame(height: 120)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(item.rarity.color, lineWidth: 1.5)
                                    )
                                
                                Image(systemName: item.iconName)
                                    .font(.system(size: 64))
                                    .foregroundColor(item.rarity.color)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.rarity.rawValue)
                                    .font(.system(size: 10, weight: .black))
                                    .foregroundColor(item.rarity.color)
                                
                                Text(item.name)
                                    .font(.system(size: 18, weight: .black))
                                    .foregroundColor(.white)
                                
                                Text(item.season)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(FreeFireTheme.gold)
                            }
                            
                            Text(item.description)
                                .font(.system(size: 11))
                                .foregroundColor(.white.opacity(0.75))
                                .lineLimit(4)
                            
                            Spacer()
                            
                            // Buy Button
                            if userState.ownedCosmetics.contains(item.id) {
                                Button(action: {
                                    userState.equipCosmetic(id: item.id, category: item.category == .bundle ? "bundle" : item.category == .head ? "head" : item.category == .top ? "top" : item.category == .pants ? "pants" : "shoes")
                                }) {
                                    Text("EQUIPAR ASPECTO")
                                        .font(.system(size: 14, weight: .black))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(FreeFireTheme.gold)
                                        .cornerRadius(6)
                                }
                            } else {
                                Button(action: {
                                    purchaseItem(item)
                                }) {
                                    HStack(spacing: 8) {
                                        Text("COMPRAR")
                                            .font(.system(size: 14, weight: .black))
                                        
                                        if let dia = item.priceDiamonds {
                                            Image(systemName: "diamond.fill")
                                            Text("\(dia)")
                                                .font(.system(size: 14, weight: .black))
                                        } else if let gold = item.priceGold {
                                            Image(systemName: "bitcoinsign.circle.fill")
                                            Text("\(gold)")
                                                .font(.system(size: 14, weight: .black))
                                        }
                                    }
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        LinearGradient(
                                            colors: [Color.yellow, FreeFireTheme.gold, Color.orange],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .cornerRadius(6)
                                }
                            }
                        }
                        .frame(width: 220)
                        .padding(16)
                    }
                }
            }
            
            // Purchase Notification Alert
            if showPurchaseSuccess {
                ZStack {
                    Color.black.opacity(0.75).ignoresSafeArea()
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 50))
                            .foregroundColor(FreeFireTheme.gold)
                        Text("¡FELICITACIONES!")
                            .font(.system(size: 20, weight: .black))
                            .foregroundColor(FreeFireTheme.gold)
                        Text(purchaseMessage)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Button("CONTINUAR") {
                            showPurchaseSuccess = false
                        }
                        .font(.system(size: 13, weight: .black))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(FreeFireTheme.gold)
                        .cornerRadius(6)
                    }
                    .padding(24)
                    .background(Color(white: 0.15))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(FreeFireTheme.gold, lineWidth: 2))
                }
            }
        }
    }
    
    private func purchaseItem(_ item: CosmeticItem) {
        if let dia = item.priceDiamonds {
            if userState.buyWithDiamonds(cost: dia, itemId: item.id, category: item.category == .bundle ? "bundle" : item.category == .head ? "head" : item.category == .top ? "top" : item.category == .pants ? "pants" : "shoes") {
                purchaseMessage = "Has adquirido \(item.name) y se ha equipado en tu personaje."
                showPurchaseSuccess = true
            }
        } else if let gold = item.priceGold {
            if userState.buyWithGold(cost: gold, itemId: item.id, category: item.category == .bundle ? "bundle" : item.category == .head ? "head" : item.category == .top ? "top" : item.category == .pants ? "pants" : "shoes") {
                purchaseMessage = "Has adquirido \(item.name) y se ha equipado en tu personaje."
                showPurchaseSuccess = true
            }
        }
    }
}

