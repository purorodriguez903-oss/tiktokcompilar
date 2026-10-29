import SwiftUI

struct ShopView: View {
    @StateObject var shopViewModel = ShopViewModel()
    @ObservedObject var languageManager = LanguageManager.shared
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                TikTokTheme.darkBg.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top Search & Cart Header
                    HStack(spacing: 12) {
                        // Search bar
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                            
                            TextField(languageManager.t("shop_search_placeholder"), text: $shopViewModel.searchText)
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                            
                            if !shopViewModel.searchText.isEmpty {
                                Button(action: { shopViewModel.searchText = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(Color(white: 0.16))
                        .cornerRadius(8)
                        
                        // Cart Icon
                        Button(action: {
                            TikTokTheme.haptic(.light)
                            shopViewModel.showCartSheet = true
                        }) {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "cart.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                
                                if shopViewModel.cartItemCount > 0 {
                                    Text("\(shopViewModel.cartItemCount)")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(TikTokTheme.red)
                                        .clipShape(Circle())
                                        .offset(x: 8, y: -8)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                    .padding(.bottom, 8)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            // Category Selector
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(shopViewModel.categories, id: \.self) { cat in
                                        Button(action: {
                                            TikTokTheme.haptic(.light)
                                            shopViewModel.selectedCategory = cat
                                        }) {
                                            Text(cat)
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(shopViewModel.selectedCategory == cat ? .white : .gray)
                                                .padding(.horizontal, 14)
                                                .padding(.vertical, 7)
                                                .background(
                                                    shopViewModel.selectedCategory == cat ? TikTokTheme.red : Color(white: 0.15)
                                                )
                                                .cornerRadius(18)
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            
                            // Promotional Banner
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color(red: 0.9, green: 0.1, blue: 0.3), Color(red: 0.3, green: 0.1, blue: 0.5)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("TikTok Shop Days")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.yellow)
                                        Text("Hasta 70% OFF")
                                            .font(.system(size: 20, weight: .black))
                                            .foregroundColor(.white)
                                        Text("+ Envío Gratis en todo")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(Color.white.opacity(0.9))
                                    }
                                    Spacer()
                                    Image(systemName: "gift.fill")
                                        .font(.system(size: 42))
                                        .foregroundColor(.white.opacity(0.85))
                                }
                                .padding(16)
                            }
                            .frame(height: 95)
                            .padding(.horizontal, 16)
                            
                            // Flash Deals Section
                            VStack(spacing: 10) {
                                HStack {
                                    Text(languageManager.t("shop_flash_sale"))
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 4) {
                                        Text(languageManager.t("shop_ends_in"))
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                        
                                        Text(shopViewModel.flashSaleTimeLeft)
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(TikTokTheme.red)
                                            .cornerRadius(4)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            
                            // Products 2-Column Grid
                            LazyVGrid(columns: columns, spacing: 14) {
                                ForEach(shopViewModel.filteredProducts) { product in
                                    Button(action: {
                                        TikTokTheme.haptic(.light)
                                        shopViewModel.selectedProductForDetail = product
                                    }) {
                                        VStack(alignment: .leading, spacing: 6) {
                                            // Product Image
                                            ZStack(alignment: .topLeading) {
                                                AsyncImage(url: URL(string: product.imageUrl)) { phase in
                                                    if let img = phase.image {
                                                        img.resizable().scaledToFill()
                                                    } else {
                                                        Rectangle().fill(Color(white: 0.2))
                                                    }
                                                }
                                                .frame(height: 160)
                                                .frame(maxWidth: .infinity)
                                                .clipped()
                                                .cornerRadius(8)
                                                
                                                if product.isBestSeller {
                                                    Text("MÁS VENDIDO")
                                                        .font(.system(size: 9, weight: .black))
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal, 6)
                                                        .padding(.vertical, 3)
                                                        .background(TikTokTheme.red)
                                                        .cornerRadius(4)
                                                        .padding(6)
                                                }
                                            }
                                            
                                            // Title
                                            Text(product.title)
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(.white)
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)
                                            
                                            // Price & Discount
                                            HStack(alignment: .firstTextBaseline, spacing: 6) {
                                                Text(product.formattedPrice)
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(TikTokTheme.red)
                                                
                                                Text(product.formattedOriginalPrice)
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.gray)
                                                    .strikethrough()
                                            }
                                            
                                            // Badges
                                            HStack(spacing: 4) {
                                                if product.freeShipping {
                                                    Text("Envío gratis")
                                                        .font(.system(size: 9, weight: .bold))
                                                        .foregroundColor(.green)
                                                        .padding(.horizontal, 4)
                                                        .padding(.vertical, 2)
                                                        .background(Color.green.opacity(0.15))
                                                        .cornerRadius(3)
                                                }
                                                
                                                Text(product.formattedSoldCount)
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .padding(8)
                                        .background(Color(white: 0.12))
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 80)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(item: $shopViewModel.selectedProductForDetail) { prod in
            ProductDetailView(product: prod, shopViewModel: shopViewModel)
                .presentationDetents([.fraction(0.85), .large])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $shopViewModel.showCartSheet) {
            CartView(shopViewModel: shopViewModel)
                .presentationDetents([.fraction(0.7), .large])
                .presentationDragIndicator(.visible)
        }
    }
}

