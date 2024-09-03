//
//  BlanckView.swift
//  Devote
//
//  Created by Анастасия Кутняхова on 03.09.2024.
//

import SwiftUI

struct BlanckView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .opacity(0.5)
        
    }
}

#Preview {
    BlanckView()
}
