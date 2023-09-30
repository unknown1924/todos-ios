//
//  TButton.swift
//  todos
//
//  Created by Debasis Mandal on 24/09/23.
//

import SwiftUI

struct TButton: View {
    
    let title: String
    var icon: String?
    let color: Color
    let buttonClickAction: () -> Void
    
    @State var trigger = false
    
    var body: some View {
        if let icon = icon {
            HStack {
                Button(title, systemImage: icon) {
                    buttonClickAction()
                    trigger.toggle()
                }
                .foregroundStyle(color)
                .tint(color)
                .buttonStyle(.bordered)
                .symbolEffect(.bounce, value: trigger)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        } else {
            Button(title) {
                buttonClickAction()
            }
            .foregroundStyle(color)
            .tint(color)
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    TButton(title: "Button Sample", icon: "person.crop.circle", color: .blue) {
//    TButton(title: "Button Sample", color: .blue) {
        // Action
    }
}
