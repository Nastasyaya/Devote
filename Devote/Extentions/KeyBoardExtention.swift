//
//  KeyBoardExtention.swift
//  Devote
//
//  Created by Анастасия Кутняхова on 26.07.2024.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
