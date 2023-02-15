//
//  ServiceOfflineTipView.swift
//  BitClient
//
//  Created by alan on 2021/11/8.
//

import SwiftUI

struct ServiceOfflineTipView: View {
    var body: some View {
        VStack {
            Text(Constants.Tips.offline).foregroundColor(.gray)
        }.frame(height: UIScreen.main.bounds.height)
    }
}

struct ServiceOfflineTipView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceOfflineTipView()
    }
}
