//
//  ServiceOfflineTipView.swift
//  BitClient
//
//  Created by alan on 2021/11/8.
//

import SwiftUI

struct ServiceOfflineTipView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("服务器无法访问")
                .font(.title2)
                .fontWeight(.medium)
            
            Text("请检查网络连接或服务器地址是否正确")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                appState.logOut()
            }) {
                Text("退出登录")
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

struct ServiceOfflineTipView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceOfflineTipView()
            .environmentObject(AppState())
    }
}
