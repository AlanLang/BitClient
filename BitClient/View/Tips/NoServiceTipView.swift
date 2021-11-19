//
//  NoServiceTipView.swift
//  BitClient
//
//  Created by Alan on 2021/11/6.
//

import SwiftUI

struct NoServiceTipView: View {
    var body: some View {
        VStack {
            Text("尚未配置服务器数据").foregroundColor(.gray)
        }.frame(height: UIScreen.main.bounds.height)
    }
}

struct NoServiceTipView_Previews: PreviewProvider {
    static var previews: some View {
        NoServiceTipView()
    }
}
