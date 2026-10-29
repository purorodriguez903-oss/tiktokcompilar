import SwiftUI

struct EditProfileView: View {
    @ObservedObject var profileViewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var handle: String = ""
    @State private var bio: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                TikTokTheme.darkBg.ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Avatar edit
                    VStack(spacing: 8) {
                        AsyncImage(url: URL(string: profileViewModel.user.avatarUrl)) { phase in
                            if let img = phase.image {
                                img.resizable().scaledToFill()
                            } else {
                                Circle().fill(Color.gray)
                            }
                        }
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .fill(Color.black.opacity(0.3))
                                .overlay(
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                )
                        )
                        
                        Text("Cambiar foto")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(TikTokTheme.cyan)
                    }
                    .padding(.top, 20)
                    
                    // Form fields
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Nombre")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.gray)
                            TextField("Nombre", text: $name)
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color(white: 0.14))
                                .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Nombre de usuario")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.gray)
                            TextField("Nombre de usuario", text: $handle)
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color(white: 0.14))
                                .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Descripción")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.gray)
                            TextEditor(text: $bio)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .frame(height: 90)
                                .scrollContentBackground(.hidden)
                                .padding(8)
                                .background(Color(white: 0.14))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
            .navigationTitle("Editar perfil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                        .foregroundColor(.gray)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        profileViewModel.updateProfile(name: name, handle: handle, bio: bio)
                        dismiss()
                    }
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(TikTokTheme.red)
                }
            }
            .onAppear {
                name = profileViewModel.user.name
                handle = profileViewModel.user.handle
                bio = profileViewModel.user.bio
            }
        }
    }
}

