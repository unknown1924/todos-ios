//
//  RegisterView.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    @State var isShowPassword = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Header
                HeaderView(title: "Register", subTitle: "Start organising today", backgroundColor: .green, backgroundAngle: -8)
                
                // Login Form
                Form {
                    HStack {
                        Image(systemName: "person")
                        TextField("Name", text: $viewModel.userName)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
                    
                    HStack {
                        Image(systemName: "envelope")
                        TextField("Email", text: $viewModel.userEmail)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
                    
                    HStack {
                        Image(systemName: "lock")
                        if isShowPassword {
                            TextField("Password", text: $viewModel.userPassword)
                        } else {
                            SecureField("Password", text: $viewModel.userPassword)
                        }
                        Image(systemName: isShowPassword ? "eye" : "eye.slash")
                            .contentTransition(.symbolEffect(.replace.offUp))
                            .onTapGesture {
                                isShowPassword.toggle()
                            }
                    }
                    
                    TButton(title: "Create Account", icon: "person.crop.circle.badge.plus", color: .green) {
                        viewModel.register()
                    }
                }
                
                Spacer()
            }
        }
    
    }
}

#Preview {
    RegisterView()
}
