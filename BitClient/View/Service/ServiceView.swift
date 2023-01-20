//
//  ServiceView.swift
//  BitClient
//
//  Created by Alan on 2021/11/5.
//

import SwiftUI

struct ServiceView: View {
    var bitService = BitService()
    var serverState: ServerState?
    @EnvironmentObject var state: AppState
    
    init(serverState: ServerState?) {
        UITableView.appearance().sectionFooterHeight = 4
        self.serverState = serverState
    }
    
    var body: some View {
        if (bitService.url == "") {
            NoServiceTipView()
        } else if(serverState == nil) {
            ServiceOfflineTipView()
        } else {
            Form {
                Section {
                    HStack {
                        Text("磁盘剩余空间")
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.freeSpaceOnDisk))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("平均分享率")
                        Spacer()
                        Text(String(serverState!.globalRatio))
                            .foregroundColor(.gray)
                    }
                }
                
                Section {
                    HStack {
                        Text("下载速度")
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.dlInfoSpeed) + "/S")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("上传速度")
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.upInfoSpeed) + "/S")
                            .foregroundColor(.gray)
                    }
                    Toggle("备用速度限制", isOn: Binding<Bool>(
                        get: { serverState!.useAltSpeedLimits },
                        set: {
                            print("value: \($0)")
                            bitService.toggleSpeedLimitsMode()
                        }
                        )
                    )
                }
                
                Section {
                    HStack {
                        Text("下载总量")
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.dlInfoData))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("上传总量")
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.upInfoData))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("节点数")
                        Spacer()
                        Text(String(serverState!.dhtNodes))
                            .foregroundColor(.gray)
                    }
                }
                
                Section {
                    Button("退出登录", action: {
                        state.logOut()
                    })
                }
            }
        }
        
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView(serverState: nil)
    }
}
