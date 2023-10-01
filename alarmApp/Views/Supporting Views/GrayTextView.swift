//
//  GrayTextView.swift
//  alarmApp
//
//  Created by Bogdan Livanov on 2023-10-01.
//

import SwiftUI

struct GrayTextView: View {
    let text: LocalizedStringKey
    var font = Font.headline
    var body: some View {
        Text(text)
            .foregroundColor(.gray)
            .font(font)
    }
}

struct GrayTextView_Previews: PreviewProvider {
    static var previews: some View {
        GrayTextView(text: "On")
    }
}
