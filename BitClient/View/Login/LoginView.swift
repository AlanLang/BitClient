//
//  LoginView.swift
//  BitClient
//
//  Created by alan lang on 2023/1/20.
//

import SwiftUI
import LoadingButton


struct LoginView: View {
    @EnvironmentObject var state: AppState
    @State var isLoading: Bool = false
    @State var hasNetworkPermission: Bool = true
    
    var body: some View {
        VStack {
            AppImage()
            AppText()
            TextField(Constants.LoginPage.serverAddress, text: $state.url)
                .padding()
                .background(Color("lightGreyColor"))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            TextField(Constants.LoginPage.login, text: $state.username)
                .padding()
                .background(Color("lightGreyColor"))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField(Constants.LoginPage.password, text: $state.password)
                .padding()
                .background(Color("lightGreyColor"))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            LoadingButton(action: {
                print("login");
                if (state.url == "") {
                    Message.warning(message: "服务器地址不能为空");
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.isLoading = false
                    }
                    return;
                }
                if (state.username == "") {
                    Message.warning(message: "用户名不能为空");
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.isLoading = false
                    }
                    return;
                }
                if (state.password == "") {
                    Message.warning(message: "密码不能为空");
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.isLoading = false
                    }
                    return;
                }
                state.test() {
                    result in if (result) {
                        state.save();
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            self.isLoading = false
                        }
                    }else{
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            self.isLoading = false
                        }
                    }
                }
            }, isLoading: $isLoading, style: LoadingButtonStyle(cornerRadius: 27, backgroundColor: .orange)) {
                Text(Constants.LoginPage.buttonTitle).foregroundColor(Color.white)
            }

            if !hasNetworkPermission {
                Text("去授权网络权限")
                    .padding(.top, 50)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }

        }
        .padding()
        .onAppear(){
            state.requestNetworkPermission() { success in
                if success {
                    self.hasNetworkPermission = true
                } else {
                    self.hasNetworkPermission = false
                }
            }
        }
    }
}

struct LoginBottonContent: View {
    var body: some View {
        Text("登录")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.black)
            .cornerRadius(35)
    }
}

struct AppImage: View {
    var body: some View {
        Image(uiImage: UIImage(named: "logo")!)
            .resizable()
            .scaledToFill()
            .frame(width: 120, height:120)
            .cornerRadius(20)
    }
}

struct AppText: View {
    var appName = Bundle.main.infoDictionary?["CFBundleName"] as? String
    
    var body: some View {
        Text((appName ?? ""))
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.top, 1)
    }
}
