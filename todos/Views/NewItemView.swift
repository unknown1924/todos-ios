//
//  NewItemView.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import SwiftUI

struct NewItemView: View {
    
    @StateObject var viewModel = NewItemViewModel()
    @Binding var showNewItemView: Bool
    //    private let userId: String
    
    //    init(userId: String) {
    //        self.userId = userId
    //    }
    
    var body: some View {
        VStack {
            Text("New Todo")
                .font(.system(size: 32))
                .bold()
                .padding(.top)
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .padding()
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(.graphical)
                
                // Button
                TButton(title: "Create", icon: "plus.app.fill", color: .blue) {
                    // Action
                    if viewModel.validate {
                        viewModel.save()
                        showNewItemView = false
                    } else {
                        viewModel.isShowAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.isShowAlert) {
                Alert(title: Text("Error Saving"), message: Text("Please fill in all the fields and choose a date today or newer."))
            }
        }
    }
}

#Preview {
    NewItemView(showNewItemView: Binding(get: {
        return true
    }, set: { _ in
        // Do nothing
    }))
}
