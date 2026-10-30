import SwiftUI

struct VaultView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userState = UserState.shared
    
    enum InventoryMainCategory: String, CaseIterable, Identifiable {
        case clothes = "ROPA"
        case collection = "COLECCIÓN"
        case emote = "EMOTE"
        case skillSkin = "ASPECTO DE HABILIDAD"
        case posture = "POSTURA"
        case vehicles = "VEHÍCULOS"
        case profile = "PERFIL"
        case other = "OTROS"
        
        var id: String { rawValue }
    }
    
    enum RopaSubCategory: String, CaseIterable, Identifiable {
        case bundles = "Conjuntos (14)"
        case heads = "Cabezas (19)"
        case masks = "Máscaras (16)"
        case facePaint = "Rostro (5)"
        case tops = "Pecho (26)"
        case pants = "Pantalones (18)"
        case shoes = "Zapatos (18)"
        
        var id: String { rawValue }
        
        var iconName: String {
            switch self {
            case .bundles: return "person.crop.rectangle.stack.fill"
            case .heads: return "comb.fill"
            case .masks: return "theatermasks.fill"
            case .facePaint: return "face.smiling.fill"
            case .tops: return "tshirt.fill"
            case .pants: return "figure.walk"
            case .shoes: return "shoeprints.fill"
            }
        }
    }
    
    @State private var activeMainCat: InventoryMainCategory = .clothes
    @State private var activeRopaSubCat: RopaSubCategory = .bundles
    @State private var selectedItem: CosmeticItem? = CosmeticItem.classic2019Cosmetics[0]
    @State private var isDancingEmote: Bool = false
    @State private var emoteRotation: Double = 0.0
    
    var itemsForCurrentSelection: [CosmeticItem] {
        if activeMainCat == .emote {
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .emote }
        }
        switch activeRopaSubCat {
        case .bundles:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .bundle }
        case .heads:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .head }
        case .masks:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .mask }
        case .facePaint:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .head }
        case .tops:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .top }
        case .pants:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .pants }
        case .shoes:
            return CosmeticItem.classic2019Cosmetics.filter { $0.category == .shoes }
        }
    }
    
    var body: some View {
        ZStack {
            FreeFireTheme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Header Bar (Exact match to video ff2019_10.jpg)
                HStack(spacing: 12) {
                    // Profile Tag: 000ECRT Lv. 57
                    HStack(spacing: 6) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4).fill(Color.blue.opacity(0.8)).frame(width: 32, height: 32)
                            Image(systemName: "soccerball").font(.system(size: 14)).foregroundColor(.white)
                        }
                        VStack(alignment: .leading, spacing: 1) {
                            Text(userState.playerName).font(.system(size: 12, weight: .black)).foregroundColor(.white)
                            Text("LV. 57").font(.system(size: 9, weight: .bold)).foregroundColor(FreeFireTheme.gold)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(6)
                    
                    // Gold
                    HStack(spacing: 4) {
                        Image(systemName: "bitcoinsign.circle.fill").foregroundColor(.yellow)
                        Text("\(userState.gold)").font(.system(size: 12, weight: .black)).foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(6)
                    
                    // Diamonds
                    HStack(spacing: 4) {
                        Image(systemName: "diamond.fill").foregroundColor(.cyan)
                        Text("\(userState.diamonds)+").font(.system(size: 12, weight: .black)).foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(6)
                    
                    Spacer()
                    
                    Text("INVENTARIO")
                        .font(.system(size: 16, weight: .black))
                        .foregroundColor(.white)
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.15))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(FreeFireTheme.secondaryDark)
                
                // Main Content
                HStack(spacing: 0) {
                    // Left 1: Main Category Vertical List (ROPA, COLECCIÓN, EMOTE, etc.)
                    VStack(spacing: 4) {
                        ForEach(InventoryMainCategory.allCases) { cat in
                            Button(action: {
                                activeMainCat = cat
                                SoundManager.shared.playButtonClick()
                            }) {
                                HStack {
                                    Text(cat.rawValue)
                                        .font(.system(size: 10, weight: .black))
                                        .foregroundColor(activeMainCat == cat ? .black : .white)
                                    Spacer()
                                    if cat == .emote {
                                        Text("NEW")
                                            .font(.system(size: 6, weight: .black))
                                            .padding(.horizontal, 3)
                                            .padding(.vertical, 1)
                                            .background(Color.red)
                                            .foregroundColor(.white)
                                            .cornerRadius(2)
                                    }
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(activeMainCat == cat ? FreeFireTheme.gold : Color.black.opacity(0.4))
                                .cornerRadius(4)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 120)
                    .padding(8)
                    
                    // Left 2: Subcategory Vertical Icons (Conjuntos, Cabezas, etc.)
                    if activeMainCat == .clothes {
                        VStack(spacing: 8) {
                            ForEach(RopaSubCategory.allCases) { sub in
                                Button(action: {
                                    activeRopaSubCat = sub
                                    SoundManager.shared.playButtonClick()
                                }) {
                                    VStack(spacing: 2) {
                                        Image(systemName: sub.iconName)
                                            .font(.system(size: 16))
                                            .foregroundColor(activeRopaSubCat == sub ? FreeFireTheme.gold : .white)
                                    }
                                    .frame(width: 38, height: 38)
                                    .background(activeRopaSubCat == sub ? Color.white.opacity(0.18) : Color.black.opacity(0.4))
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(activeRopaSubCat == sub ? FreeFireTheme.gold : Color.clear, lineWidth: 1.5))
                                    .cornerRadius(6)
                                }
                            }
                            Spacer()
                        }
                        .frame(width: 48)
                        .padding(.vertical, 8)
                    }
                    
                    Divider().background(Color.white.opacity(0.1))
                    
                    // Middle: Grid of Cosmetics or 8-Slot Emote Wheel
                    if activeMainCat == .emote {
                        emoteInventoryView
                    } else {
                        cosmeticGridView
                    }
                    
                    Divider().background(Color.white.opacity(0.1))
                    
                    // Right: 3D Platform Character Viewer (Exact match to video ff2019_10.jpg)
                    VStack {
                        Spacer()
                        
                        ZStack {
                            // Metallic Hexagonal Platform with Lighting
                            ZStack {
                                Circle()
                                    .fill(RadialGradient(colors: [Color.yellow.opacity(0.35), Color.clear], center: .center, startRadius: 10, endRadius: 110))
                                    .frame(width: 190, height: 50)
                                    .scaleEffect(y: 0.4)
                                    .offset(y: 90)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LinearGradient(colors: [Color(white: 0.35), Color(white: 0.15)], startPoint: .top, endPoint: .bottom))
                                    .frame(width: 170, height: 26)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.3), lineWidth: 1))
                                    .offset(y: 95)
                            }
                            
                            // Character in Cyber Bone Set
                            VStack(spacing: 1) {
                                // Head with fire hair
                                ZStack {
                                    Circle().fill(Color.orange).frame(width: 28, height: 28)
                                    Image(systemName: "flame.fill").font(.system(size: 22)).foregroundColor(.yellow).offset(y: -8)
                                }
                                
                                // Jacket with bone ribs
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.black)
                                    .frame(width: 52, height: 60)
                                    .overlay(
                                        VStack(spacing: 2) {
                                            ForEach(0..<3) { _ in
                                                Rectangle().fill(Color.yellow).frame(width: 30, height: 3)
                                            }
                                        }
                                    )
                                
                                // Pants
                                HStack(spacing: 3) {
                                    Rectangle().fill(Color(white: 0.15)).frame(width: 20, height: 50)
                                    Rectangle().fill(Color(white: 0.15)).frame(width: 20, height: 50)
                                }
                                
                                // Sneakers
                                HStack(spacing: 6) {
                                    RoundedRectangle(cornerRadius: 2).fill(Color.white).frame(width: 18, height: 7)
                                    RoundedRectangle(cornerRadius: 2).fill(Color.white).frame(width: 18, height: 7)
                                }
                            }
                            .rotationEffect(.degrees(isDancingEmote ? emoteRotation : 0))
                        }
                        
                        Spacer()
                    }
                    .frame(width: 220)
                }
            }
        }
    }
    
    // MARK: - Cosmetics Grid
    private var cosmeticGridView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 95, maximum: 110), spacing: 8)], spacing: 8) {
                ForEach(itemsForCurrentSelection) { item in
                    let isEquipped = checkIsEquipped(item)
                    Button(action: {
                        selectedItem = item
                        equipItem(item)
                        SoundManager.shared.playButtonClick()
                    }) {
                        VStack(spacing: 4) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(LinearGradient(colors: [item.primaryColor.opacity(0.3), item.secondaryColor.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(height: 70)
                                
                                Image(systemName: item.iconName)
                                    .font(.system(size: 28))
                                    .foregroundColor(item.rarity.color)
                                
                                if isEquipped {
                                    VStack {
                                        HStack {
                                            Spacer()
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(FreeFireTheme.gold)
                                                .font(.system(size: 12))
                                        }
                                        Spacer()
                                    }
                                    .padding(3)
                                }
                            }
                            
                            Text(item.name)
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.white)
                                .lineLimit(1)
                        }
                        .padding(6)
                        .background(isEquipped ? Color.white.opacity(0.15) : Color.black.opacity(0.4))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(isEquipped ? FreeFireTheme.gold : Color.clear, lineWidth: 1.5))
                        .cornerRadius(6)
                    }
                }
            }
            .padding(12)
        }
    }
    
    // MARK: - Emote Inventory & Wheel (Exact match to video ff2019_12.jpg)
    private var emoteInventoryView: some View {
        VStack(spacing: 12) {
            Text("RUEDA DE EMOTES (8 RANURAS)")
                .font(.system(size: 13, weight: .black))
                .foregroundColor(FreeFireTheme.gold)
            
            HStack(spacing: 16) {
                // Emote List
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(userState.wheelEmotes, id: \.self) { emoteName in
                            Button(action: {
                                playEmoteAnimation(emoteName)
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: emoteName.contains("baile") ? "figure.dance" : "flame.fill")
                                        .foregroundColor(FreeFireTheme.gold)
                                    Text(emoteName)
                                        .font(.system(size: 11, weight: .black))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("EQUIPADO")
                                        .font(.system(size: 8, weight: .heavy))
                                        .foregroundColor(FreeFireTheme.gold)
                                }
                                .padding(8)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(6)
                            }
                        }
                    }
                }
                .frame(width: 170)
                
                // Emote Circular Preview Wheel
                ZStack {
                    Circle().stroke(Color.white.opacity(0.2), lineWidth: 1).frame(width: 160, height: 160)
                    
                    ForEach(0..<userState.wheelEmotes.count, id: \.self) { idx in
                        let angle = Double(idx) * (360.0 / Double(userState.wheelEmotes.count))
                        let radians = angle * .pi / 180.0
                        let x = 60.0 * cos(radians)
                        let y = 60.0 * sin(radians)
                        
                        Circle()
                            .fill(idx == 0 ? FreeFireTheme.gold : Color.black.opacity(0.7))
                            .frame(width: 32, height: 32)
                            .overlay(
                                Image(systemName: idx == 0 ? "figure.dance" : "hand.wave.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(idx == 0 ? .black : .white)
                            )
                            .offset(x: x, y: y)
                    }
                }
                .frame(width: 180, height: 180)
            }
        }
        .padding(14)
    }
    
    private func playEmoteAnimation(_ name: String) {
        SoundManager.shared.playButtonClick()
        FreeFireTheme.booyahVictoryHaptic()
        
        isDancingEmote = true
        withAnimation(.easeInOut(duration: 0.4).repeatCount(4, autoreverses: true)) {
            emoteRotation = 25.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isDancingEmote = false
            emoteRotation = 0.0
        }
    }
    
    private func checkIsEquipped(_ item: CosmeticItem) -> Bool {
        if item.category == .bundle { return userState.equippedBundle == item.id }
        if item.category == .head { return userState.equippedHead == item.id }
        if item.category == .top { return userState.equippedTop == item.id }
        if item.category == .pants { return userState.equippedPants == item.id }
        if item.category == .shoes { return userState.equippedShoes == item.id }
        return false
    }
    
    private func equipItem(_ item: CosmeticItem) {
        let cat = item.category == .bundle ? "bundle" : item.category == .head ? "head" : item.category == .top ? "top" : item.category == .pants ? "pants" : "shoes"
        userState.equipCosmetic(id: item.id, category: cat)
    }
}
