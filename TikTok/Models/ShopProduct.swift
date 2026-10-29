import Foundation

struct ShopProduct: Identifiable, Equatable {
    let id: String
    let title: String
    let price: Double
    let originalPrice: Double
    let rating: Double
    let reviewCount: Int
    let soldCount: Int
    let imageUrl: String
    let freeShipping: Bool
    let category: String
    let sellerName: String
    let discountPercent: Int
    let isBestSeller: Bool
    
    var formattedPrice: String {
        return String(format: "$%.2f", price)
    }
    
    var formattedOriginalPrice: String {
        return String(format: "$%.2f", originalPrice)
    }
    
    var formattedSoldCount: String {
        if soldCount >= 1000 {
            return String(format: "%.1fk vendidos", Double(soldCount) / 1000.0)
        }
        return "\(soldCount) vendidos"
    }
}

extension ShopProduct {
    static let sampleProducts: [ShopProduct] = [
        ShopProduct(
            id: "prod_01",
            title: "Auriculares Inalámbricos Pro ANC con Cancelación de Ruido y Estuche LED",
            price: 18.99,
            originalPrice: 49.99,
            rating: 4.8,
            reviewCount: 3410,
            soldCount: 28400,
            imageUrl: "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500",
            freeShipping: true,
            category: "Electrónica",
            sellerName: "TechStore Global",
            discountPercent: 62,
            isBestSeller: true
        ),
        ShopProduct(
            id: "prod_02",
            title: "Sudadera Oversize Vintage Unisex de Algodón Premium Edición TikTok",
            price: 24.50,
            originalPrice: 45.00,
            rating: 4.9,
            reviewCount: 1890,
            soldCount: 15200,
            imageUrl: "https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=500",
            freeShipping: true,
            category: "Moda",
            sellerName: "Urban Streetwear",
            discountPercent: 45,
            isBestSeller: true
        ),
        ShopProduct(
            id: "prod_03",
            title: "Aro de Luz LED 12'' con Trípode Extensible y Soporte para Celular",
            price: 14.99,
            originalPrice: 32.00,
            rating: 4.7,
            reviewCount: 5600,
            soldCount: 41200,
            imageUrl: "https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=500",
            freeShipping: true,
            category: "Electrónica",
            sellerName: "Creator Studio Gear",
            discountPercent: 53,
            isBestSeller: false
        ),
        ShopProduct(
            id: "prod_04",
            title: "Set de Skincare Suero de Ácido Hialurónico y Vitamina C Glow Facial",
            price: 12.80,
            originalPrice: 28.00,
            rating: 4.9,
            reviewCount: 4200,
            soldCount: 33700,
            imageUrl: "https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500",
            freeShipping: true,
            category: "Belleza",
            sellerName: "Glow & Beauty Labs",
            discountPercent: 54,
            isBestSeller: true
        ),
        ShopProduct(
            id: "prod_05",
            title: "Mini Impresora Térmica Portátil Bluetooth para Fotos y Apuntes",
            price: 19.90,
            originalPrice: 39.99,
            rating: 4.6,
            reviewCount: 2100,
            soldCount: 18900,
            imageUrl: "https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?w=500",
            freeShipping: true,
            category: "Hogar",
            sellerName: "Gadgets viral",
            discountPercent: 50,
            isBestSeller: false
        ),
        ShopProduct(
            id: "prod_06",
            title: "Zapatillas Deportivas Ultraligeras Con Amortiguación Deportiva",
            price: 29.99,
            originalPrice: 65.00,
            rating: 4.8,
            reviewCount: 1450,
            soldCount: 9800,
            imageUrl: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500",
            freeShipping: true,
            category: "Calzado",
            sellerName: "Speed Athletic",
            discountPercent: 54,
            isBestSeller: false
        )
    ]
}

