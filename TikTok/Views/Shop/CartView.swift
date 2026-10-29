import SwiftUI

struct CartView: View {
    @ObservedObject var shopViewModel: ShopViewModel
    @ObservedObject var languageManager = LanguageManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("\(languageManager.t("shop_cart")) (\(shopViewModel.cartItemCount))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            Divider().background(Color(white: 0.2))
            
            if shopViewModel.cart.isEmpty {
                VStack(spacing: 16) {
                    Spacer()
                    Image(systemName: "bag")
                        .font(.system(size: 64))
                        .foregroundColor(.gray)
                    Text(languageManager.t("shop_cart_empty"))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(Array(shopViewModel.cart.keys), id: \.self) { prodId in
                            if let product = shopViewModel.products.first(where: { $0.id == prodId }) {
                                let qty = shopViewModel.cart[prodId] ?? 1
                                HStack(spacing: 12) {
                                    AsyncImage(url: URL(string: product.imageUrl)) { phase in
                                        if let img = phase.image {
                                            img.resizable().scaledToFill()
                                        } else {
                                            Rectangle().fill(Color(white: 0.2))
                                        }
                                    }
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                    .cornerRadius(8)
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(product.title)
                                            .font(.system(size: 13, weight: .medium))
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                        
                                        HStack {
                                            Text(product.formattedPrice)
                                                .font(.system(size: 15, weight: .bold))
                                                .foregroundColor(TikTokTheme.red)
                                            
                                            Spacer()
                                            
                                            // Stepper controls
                                            HStack(spacing: 12) {
                                                Button(action: { shopViewModel.removeFromCart(product: product) }) {
                                                    Image(systemName: "minus")
                                                        .font(.system(size: 11, weight: .bold))
                                                        .foregroundColor(.white)
                                                        .frame(width: 24, height: 24)
                                                        .background(Color(white: 0.25))
                                                        .cornerRadius(4)
                                                }
                                                
                                                Text("\(qty)")
                                                    .font(.system(size: 13, weight: .bold))
                                                    .foregroundColor(.white)
                                                
                                                Button(action: { shopViewModel.addToCart(product: product) }) {
                                                    Image(systemName: "plus")
                                                        .font(.system(size: 11, weight: .bold))
                                                        .foregroundColor(.white)
                                                        .frame(width: 24, height: 24)
                                                        .background(Color(white: 0.25))
                                                        .cornerRadius(4)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(12)
                                .background(Color(white: 0.12))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(16)
                }
                
                // Bottom Checkout summary
                VStack(spacing: 12) {
                    HStack {
                        Text(languageManager.t("shop_total"))
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text(String(format: "$%.2f", shopViewModel.cartSubtotal))
                            .font(.system(size: 22, weight: .black))
                            .foregroundColor(TikTokTheme.red)
                    }
                    
                    Button(action: {
                        shopViewModel.checkout()
                    }) {
                        Text(languageManager.t("shop_checkout"))
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(TikTokTheme.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(TikTokTheme.darkCard)
            }
        }
        .background(TikTokTheme.darkBg.ignoresSafeArea())
        .alert("¡Pedido realizado con éxito!", isPresented: $shopViewModel.showCheckoutSuccess) {
            Button("OK", role: .cancel) { dismiss() }
        } message: {
            Text("Tu pedido de TikTok Shop ha sido procesado. Recibirás una notificación cuando sea enviado.")
        }
    }
}

