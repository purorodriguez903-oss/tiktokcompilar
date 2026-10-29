import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isFromMe: Bool
    let timestamp: String
}

struct ChatDetailView: View {
    let inboxItem: InboxItem
    @Environment(\.dismiss) var dismiss
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "¡Hola! ¿Cómo estás?", isFromMe: false, timestamp: "10:30 AM"),
        ChatMessage(text: "Hola! Todo excelente, probando el TikTok clon en iOS 🔥", isFromMe: true, timestamp: "10:32 AM"),
        ChatMessage(text: "Quedó genial la interfaz, se ve idéntica a la oficial!", isFromMe: false, timestamp: "10:33 AM")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 12) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                
                AsyncImage(url: URL(string: inboxItem.avatarUrl)) { phase in
                    if let img = phase.image {
                        img.resizable().scaledToFill()
                    } else {
                        Circle().fill(Color.gray)
                    }
                }
                .frame(width: 36, height: 36)
                .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(inboxItem.senderName)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                    Text(inboxItem.senderHandle)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(TikTokTheme.darkCard)
            
            Divider().background(Color(white: 0.2))
            
            // Messages Scroll
            ScrollView {
                LazyVStack(spacing: 14) {
                    ForEach(messages) { msg in
                        HStack {
                            if msg.isFromMe { Spacer() }
                            
                            VStack(alignment: msg.isFromMe ? .trailing : .leading, spacing: 4) {
                                Text(msg.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                                    .background(msg.isFromMe ? TikTokTheme.red : Color(white: 0.2))
                                    .cornerRadius(16)
                                
                                Text(msg.timestamp)
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            
                            if !msg.isFromMe { Spacer() }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 16)
            }
            
            // Input bar
            HStack(spacing: 10) {
                TextField("Enviar mensaje...", text: $messageText)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 9)
                    .background(Color(white: 0.16))
                    .cornerRadius(20)
                
                if !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button(action: {
                        TikTokTheme.haptic(.medium)
                        let newMsg = ChatMessage(text: messageText, isFromMe: true, timestamp: "Ahora")
                        messages.append(newMsg)
                        messageText = ""
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 18))
                            .foregroundColor(TikTokTheme.red)
                            .padding(8)
                    }
                } else {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .padding(8)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(TikTokTheme.darkCard)
        }
        .background(TikTokTheme.darkBg.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}
