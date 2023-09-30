//
//  HeaderView.swift
//  todos
//
//  Created by Debasis Mandal on 23/09/23.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let subTitle: String
    let backgroundColor: Color
    let backgroundAngle: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(backgroundColor)
                .rotationEffect(Angle(degrees: backgroundAngle))
            
            VStack {
                Text(title)
                    .font(.system(size: 52))
                    .foregroundStyle(.white)
                    .bold()
                
                Text(subTitle)
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
            }
            .padding(.top, 80)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 230)
        .offset(y: -80)
    }
}

#Preview {
    HeaderView(title: "Todos", subTitle: "Get things done!", backgroundColor: Color.pink, backgroundAngle: 8)
}
