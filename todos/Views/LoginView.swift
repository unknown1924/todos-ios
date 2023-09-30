//
//  LoginView.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State var isShowPassword = false
    @State var isShowCheck = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                // Header
                HeaderView(title: "Todos", subTitle: "Get things done!", backgroundColor: .pink, backgroundAngle: 8)
                
                // Login Form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
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
                    
                    TButton(title: "Log In", icon: "arrow.forward.circle", color: .pink) {
                        viewModel.login()
                    }
                }
                
                // Create Account
                VStack {
                    Text("New around here?")
                    NavigationLink("Create an Account", destination: RegisterView())
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
