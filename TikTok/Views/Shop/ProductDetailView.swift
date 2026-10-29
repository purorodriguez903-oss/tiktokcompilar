import SwiftUI

struct ProductDetailView: View {
    let product: ShopProduct
    @ObservedObject var shopViewModel: ShopViewModel
    @ObservedObject var languageManager = LanguageManager.shared
    @Environment(\.dismiss) var dismiss
    
    @State private var quantity: Int = 1
    @State private var selectedColor: String = "Negro"
    @State private var addedToCartNotice: Bool = false
    
    let colors = ["Negro", "Blanco", "Azul Espacial", "Gris"]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header bar
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color(white: 0.2))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Button(action: {
                    shopViewModel.showCartSheet = true
                }) {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "cart")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color(white: 0.2))
                            .clipShape(Circle())
                        
                        if shopViewModel.cartItemCount > 0 {
                            Text("\(shopViewModel.cartItemCount)")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                                .padding(4)
                                .background(TikTokTheme.red)
                                .clipShape(Circle())
                                .offset(x: 4, y: -4)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Product Image
                    AsyncImage(url: URL(string: product.imageUrl)) { phase in
                        if let img = phase.image {
                            img.resizable().scaledToFill()
                        } else {
                            Rectangle().fill(Color(white: 0.2))
                        }
                    }
                    .frame(height: 320)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(12)
                    
                    // Price & Discount row
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Text(product.formattedPrice)
                            .font(.system(size: 26, weight: .black))
                            .foregroundColor(TikTokTheme.red)
                        
                        Text(product.formattedOriginalPrice)
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .strikethrough()
                        
                        Text("-\(product.discountPercent)%")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(TikTokTheme.red)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(TikTokTheme.red.opacity(0.15))
                            .cornerRadius(4)
                        
                        Spacer()
                    }
                    
                    // Free shipping tag
                    if product.freeShipping {
                        HStack(spacing: 4) {
                            Image(systemName: "truck.box.badge.clock.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.green)
                            Text(languageManager.t("shop_free_shipping"))
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.green)
                        }
                    }
                    
                    // Title
                    Text(product.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    
                    // Rating & Sold
                    HStack(spacing: 8) {
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(TikTokTheme.yellow)
                            Text(String(format: "%.1f", product.rating))
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Text("(\(product.reviewCount) \(languageManager.t("shop_reviews")))")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        
                        Text("•")
                            .foregroundColor(.gray)
                        
                        Text(product.formattedSoldCount)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    
                    Divider().background(Color(white: 0.2))
                    
                    // Seller / Store info
                    HStack(spacing: 12) {
                        Image(systemName: "storefront.fill")
                            .font(.system(size: 20))
                            .foregroundColor(TikTokTheme.cyan)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(product.sellerName)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                            Text("Tienda oficial verificada")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("Ver tienda")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color(white: 0.2))
                            .cornerRadius(6)
                    }
                    .padding(12)
                    .background(Color(white: 0.12))
                    .cornerRadius(10)
                    
                    // Variants
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Color:")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 10) {
                            ForEach(colors, id: \.self) { color in
                                Button(action: { selectedColor = color }) {
                                    Text(color)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(selectedColor == color ? .white : .gray)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(selectedColor == color ? TikTokTheme.red : Color(white: 0.16))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
            
            // Bottom Action Bar: Add to Cart & Buy Now
            VStack(spacing: 8) {
                if addedToCartNotice {
                    Text("✓ Añadido a la cesta de TikTok Shop")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.green)
                        .transition(.opacity)
                }
                
                HStack(spacing: 12) {
                    // Add to cart
                    Button(action: {
                        shopViewModel.addToCart(product: product)
                        withAnimation { addedToCartNotice = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation { addedToCartNotice = false }
                        }
                    }) {
                        Text(languageManager.t("shop_add_to_cart"))
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color(white: 0.22))
                            .cornerRadius(8)
                    }
                    
                    // Buy Now
                    Button(action: {
                        shopViewModel.addToCart(product: product)
                        shopViewModel.showCartSheet = true
                    }) {
                        Text(languageManager.t("shop_buy_now"))
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(TikTokTheme.red)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            .background(TikTokTheme.darkCard)
        }
        .background(TikTokTheme.darkBg.ignoresSafeArea())
    }
}

