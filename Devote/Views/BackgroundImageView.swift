//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Анастасия Кутняхова on 03.09.2024.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundImageView()
}
