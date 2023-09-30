//
//  ProfileImageGridView.swift
//  todos
//
//  Created by Debasis Mandal on 28/09/23.
//

import SwiftUI

struct ProfileImageGridView: View {
    
    @Binding var profileImage: String
    @State var isPressed: Bool = false
    
    let images = [
        "cat",
        "chicken",
        "dog",
        "fox",
        "giraffe",
        "koala",
        "lion",
        "rabbit",
        "snake"  ]
    
    var columnGrid: [GridItem] = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)]
    
    var body: some View {
        VStack {
            Spacer()
                
            Image(profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.blue)
                .shadow(color: .black, radius: 20)
                .padding()
            
            Spacer()
            
            LazyVGrid(columns: columnGrid) {
                ForEach(images, id: \.self) { image in
                    profileAvatar(image: image)
                }
            }
            .padding()
        }
    }
    
    
    @ViewBuilder
    func profileAvatar(image: String) -> some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .clipped()
            .padding(10)
            .scaleEffect(profileImage == image ? (isPressed ? 1.2 : 1.0) : 1.0)
            .animation(.smooth, value: profileImage == image ? true : false)
            .onTapGesture {
//                self.selectedImage = image
                profileImage = image
                isPressed = true
                print(profileImage)
            }
    }
}

#Preview {
    ProfileImageGridView(profileImage: .constant("cat"))
}
