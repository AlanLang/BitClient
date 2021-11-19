//
//  AboutNavigationBar.swift
//  BitClient
//
//  Created by Alan on 2021/11/5.
//

import SwiftUI
private let kButtonHeight: CGFloat = 24;

struct AboutNavigationBar: View {
    var title: String;
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Spacer()
            Text(title)
                .bold()
                .padding(.bottom, 4)
            Spacer()
        }.frame(width: UIScreen.main.bounds.width)
    }
}

struct AboutNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        AboutNavigationBar(title: "关于我")
    }
}
