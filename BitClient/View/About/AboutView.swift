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
                UrlLink(title: Constants.About.web, linkTitle: "BitClient", url: "https://github.com/AlanLang/BitClient")
                UrlLink(title: Constants.About.license, linkTitle: "GPL v3.0", url: "https://github.com/AlanLang/BitClient/blob/main/LICENSE")
                UrlLink(title: Constants.About.changelog, linkTitle: "", url: "https://github.com/AlanLang/BitClient/blob/main/CHANGELOG.md")
                Button(action: {
                    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }) {
                    Text(Constants.About.settings)
                }
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
