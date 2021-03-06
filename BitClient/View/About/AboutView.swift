//
//  AboutView.swift
//  BitClient
//
//  Created by alan on 2021/11/9.
//

import SwiftUI

struct UrlLink: View {
    var title: String
    var linkTitle: String
    var url: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Link(linkTitle, destination: URL(string: url)!)
                .foregroundColor(.gray)
            Image(systemName: "chevron.right").foregroundColor(.gray)
        }
    }
}

struct AboutView: View {
    var appName = Bundle.main.infoDictionary?["CFBundleName"] as? String
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
        VStack() {
            VStack {
                Image(uiImage: UIImage(named: "logo")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height:120)
                    .cornerRadius(20)
                Text((appName ?? "") + " " + (appVersion ?? "")).padding(.top, 4).foregroundColor(.gray)
            }
            Form {
                UrlLink(title: "网站", linkTitle: "BitClient", url: "https://github.com/AlanLang/BitClient")
                UrlLink(title: "Telegram", linkTitle: "@alan2333", url: "https://t.me/alan2333")
                UrlLink(title: "开源协议", linkTitle: "GPL v3.0", url: "https://github.com/AlanLang/BitClient/blob/main/LICENSE")
                UrlLink(title: "更新说明", linkTitle: "", url: "https://github.com/AlanLang/BitClient/blob/main/CHANGELOG.md")
            }
            Spacer()
        }
        .padding(.top, 40)
        .frame(width: UIScreen.main.bounds.width)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
