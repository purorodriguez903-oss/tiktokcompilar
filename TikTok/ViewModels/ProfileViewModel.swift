import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: UserProfile = UserProfile.currentUser
    @Published var selectedTab: Int = 0 // 0: Videos, 1: Private, 2: Saved, 3: Liked
    @Published var showEditProfile: Bool = false
    @Published var showSettings: Bool = false
    @Published var showShareProfileSheet: Bool = false
    
    func updateProfile(name: String, handle: String, bio: String) {
        user.name = name
        user.handle = handle
        user.bio = bio
        TikTokTheme.hapticNotification(.success)
    }
}

