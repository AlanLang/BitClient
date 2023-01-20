//
//  ServiceNavigationBar.swift
//  BitClient
//
//  Created by alan on 2021/11/5.
//

import SwiftUI

private let kButtonHeight: CGFloat = 24;
private let paddingTop: CGFloat = 5;

struct ServiceNavigationBar<ServiceConfigView>: View where ServiceConfigView : View {
    var title: String;
    var serviceConfigView: ServiceConfigView;
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Button(action: {
                print("click name action")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                    .hidden()// 暂时先不需要
            }
            Spacer()
            Text(title)
                .bold()
                .padding(.top, paddingTop)
            Spacer()
            NavigationLink(destination: serviceConfigView) {
                Image(systemName: "externaldrive.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 5)
                    .foregroundColor(.primary)
                    .hidden()
            }
        }.frame(width: UIScreen.main.bounds.width)
    }
}

struct ServiceNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ServiceNavigationBar(title:"服务器", serviceConfigView: Text(""))
    }
}
