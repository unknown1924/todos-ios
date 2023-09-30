//
//  EditItemView.swift
//  todos
//
//  Created by Debasis Mandal on 30/09/23.
//

import SwiftUI

struct EditItemView: View {
    
    @StateObject var viewModel = NewItemViewModel()
    @Binding var showEditItemView: Bool
    let itemId: String
    
    var body: some View {
        VStack {
            Text("Edit Todo")
                .foregroundStyle(.green)
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
                    .tint(.green)
                
                // Button
                TButton(title: "Update", icon: "checkmark", color: .green) {
                    // Action
                    if viewModel.validate {
                        viewModel.update(itemId: itemId)
                        showEditItemView = false
                    } else {
                        viewModel.isShowAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.isShowAlert) {
                Alert(title: Text("Error Saving"), message: Text("Please fill in all the fields and choose a date today or newer."))
            }
        }
        .onAppear {
            viewModel.fetch(itemId: itemId)
        }
    }
}

#Preview {
    EditItemView(showEditItemView: .constant(true), itemId: "1C166867-486C-4D4E-9661-B471FA940DCE")
}
