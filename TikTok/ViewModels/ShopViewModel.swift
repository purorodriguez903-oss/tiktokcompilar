import SwiftUI
import Combine

class ShopViewModel: ObservableObject {
    @Published var products: [ShopProduct] = ShopProduct.sampleProducts
    @Published var selectedCategory: String = "Para ti"
    @Published var searchText: String = ""
    @Published var cart: [String: Int] = [:] // Product ID -> Quantity
    @Published var selectedProductForDetail: ShopProduct? = nil
    @Published var showCartSheet: Bool = false
    @Published var showCheckoutSuccess: Bool = false
    @Published var flashSaleTimeLeft: String = "03:45:18"
    
    let categories: [String] = [
        "Para ti", "Moda", "Belleza", "Electrónica", "Hogar", "Calzado"
    ]
    
    var filteredProducts: [ShopProduct] {
        var result = products
        if selectedCategory != "Para ti" {
            result = result.filter { $0.category.lowercased() == selectedCategory.lowercased() }
        }
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.category.localizedCaseInsensitiveContains(searchText)
            }
        }
        return result
    }
    
    var cartItemCount: Int {
        cart.values.reduce(0, +)
    }
    
    var cartSubtotal: Double {
        var total: Double = 0
        for (prodId, qty) in cart {
            if let prod = products.first(where: { $0.id == prodId }) {
                total += prod.price * Double(qty)
            }
        }
        return total
    }
    
    func addToCart(product: ShopProduct) {
        TikTokTheme.haptic(.medium)
        cart[product.id, default: 0] += 1
    }
    
    func removeFromCart(product: ShopProduct) {
        TikTokTheme.haptic(.light)
        guard let current = cart[product.id] else { return }
        if current > 1 {
            cart[product.id] = current - 1
        } else {
            cart.removeValue(forKey: product.id)
        }
    }
    
    func clearCart() {
        cart.removeAll()
    }
    
    func checkout() {
        TikTokTheme.hapticNotification(.success)
        showCheckoutSuccess = true
        cart.removeAll()
    }
}
