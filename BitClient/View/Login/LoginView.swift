//
//  LoginView.swift
//  BitClient
//
//  Created by alan lang on 2023/1/20.
//

import SwiftUI
import LoadingButton

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0);

struct LoginView: View {
    @State var url: String = "";
    @State var username: String = "";
    @State var password: String  = "";
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            AppImage()
            AppText()
            TextField("服务器地址", text: $url)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            TextField("用户名", text: $username)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("密码", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            LoadingButton(action: {
                print("login");
                if (url == "") {
                    Message.warning(message: "服务器地址不能为空");
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.isLoading = false
                    }
                    return;
                }
                if (username == "") {
                    Message.warning(message: "用户名不能为空");
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.isLoading = false
                    }
                    return;
                }
                if (password == "") {
                    Message.warning(message: "密码不能为空");
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.isLoading = false
                    }
                    return;
                }
            }, isLoading: $isLoading, style: LoadingButtonStyle(cornerRadius: 27, backgroundColor: .orange)) {
                Text("登录").foregroundColor(Color.white)
            }

        }
        .padding()
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
