//
//  Animation.swift
//  todos
//
//  Created by Debasis Mandal on 28/09/23.
//

import SwiftUI

struct Animation: View {
    
    @State var isConnectingToInternet: Bool = true
    
    var body: some View {
        Image(systemName: "wifi.router")
            .scaleEffect(4)
            .symbolEffect(.pulse, value: isConnectingToInternet)
            .onTapGesture {
                isConnectingToInternet.toggle()
            }
    }
}

#Preview {
    Animation()
}
