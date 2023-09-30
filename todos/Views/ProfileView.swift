//
//  ProfileView.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @State var showProfileSelector = false
    @State var profileImage = "cat"      // I mean cats are cute, aren't they?
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.currentUser {
                    profile(user: user, image: profileImage, showProfileSelector: showProfileSelector)
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
        .sheet(isPresented: $showProfileSelector) {
            ProfileImageGridView(profileImage: $profileImage)
                .presentationDetents([.medium, .large])
        }
    }
    
    @ViewBuilder
    func profile(user: User, image: String, showProfileSelector: Bool) -> some View {
        // Avatar
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.blue)
            .frame(width: 200, height: 200)
            .padding()
            .onTapGesture {
                self.showProfileSelector = true
            }
        
        // User Info: Name, Email, Member since
        Form {
            HStack {
                Text("Name")
                Spacer()
                //                Text("Debasis Mandal")
                Text(user.name)
                    .bold()
            }
            HStack {
                Text("Email")
                Spacer()
                //                Text("debasismandal900@gmail.com")
                Text(user.email)
            }
            HStack {
                Text("Member Since")
                Spacer()
                //                Text("24 Sept 2023")
                Text(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .omitted))
            }
        }
        
        // Sign Out
        TButton(title: "Log Out", icon: "power.circle.fill", color: .red) {
            viewModel.logout()
        }
    }
}

#Preview {
    ProfileView()
}
