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
                        Text(Constants.Server.freeDiskSpace)
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.freeSpaceOnDisk))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(Constants.Server.averageShareRate)
                        Spacer()
                        Text(String(serverState!.globalRatio))
                            .foregroundColor(.gray)
                    }
                }
                
                Section {
                    HStack {
                        Text(Constants.Server.downloadSpeed)
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.dlInfoSpeed) + "/S")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(Constants.Server.uploadSpeed)
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.upInfoSpeed) + "/S")
                            .foregroundColor(.gray)
                    }
                    Toggle(Constants.Server.alternateSpeedLimit, isOn: Binding<Bool>(
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
                        Text(Constants.Server.totalDownloads)
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.dlInfoData))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(Constants.Server.totalUploads)
                        Spacer()
                        Text(UtilsManager.getSizeText(serverState!.upInfoData))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(Constants.Server.numberOfNodes)
                        Spacer()
                        Text(String(serverState!.dhtNodes))
                            .foregroundColor(.gray)
                    }
                }
                
                Section {
                    if let url = URL(string: bitService.url) {
                        Link(Constants.Server.openInBrowser, destination: url)
                    }
                    Button(Constants.Server.signOut, action: {
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
