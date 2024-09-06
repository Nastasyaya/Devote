//
//  BlanckView.swift
//  Devote
//
//  Created by Анастасия Кутняхова on 03.09.2024.
//

import SwiftUI

struct BlanckView: View {
    let backgroundColor: Color
    let backgroundOpacity: Double
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        
    }
}

#Preview {
    BlanckView(backgroundColor: Color.black, backgroundOpacity: 0.3)
        .background(BackgroundImageView())
        .background(backgroundGradient.ignoresSafeArea())
}
