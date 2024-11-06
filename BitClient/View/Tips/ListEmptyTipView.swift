//
//  ListEmptyTipView.swift
//  BitClient
//
//  Created by alan on 2021/11/8.
//

import SwiftUI
import SVGKit

struct ListEmptyTipView: View {
    var body: some View {
        VStack {
            if let svgImage = SVGKImage(named: "empty") {
                Image(uiImage: svgImage.uiImage)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 24
                    )
                    .frame(maxWidth: .infinity)
            }
            Text(Constants.Tips.noContent)
                .foregroundColor(.gray)
        }
        .frame(height: UIScreen.main.bounds.height)
    }
}

struct ListEmptyTipView_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyTipView()
    }
}
