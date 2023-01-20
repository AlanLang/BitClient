//
//  BitClientApp.swift
//  BitClient
//
//  Created by alan on 2021/11/3.
//
// todo: https://github.com/globulus/swiftui-pull-to-refresh 下拉刷新

import SwiftUI

@main
struct BitClientApp: App {
    @StateObject var appState = AppState()

    
    var body: some Scene {
        WindowGroup {
            if (appState.isLogin) {
                ContentView().environmentObject(appState)
            } else {
                LoginView().environmentObject(appState)
            }
        }
    }
}

class Theme {
    static func navigationBarColors(background : UIColor?,
       titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = UIColor.systemBackground
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    @State private var homeMenu: CGFloat = 0;
    private let tabTitle = ["列表","服务器","关于我"]
    @ObservedObject private var bitClientAppViewModel  = BitClientAppViewModel();
    @Environment(\.scenePhase) var scenePhase
    
    @ViewBuilder
    var navigationBarLeadingItems: some View {
        if selectedIndex == 0 {
            HomeNavigationBar(leftPercent: $homeMenu, addView: AddTorrentView(defaultSavePath: ""))
        } else if selectedIndex == 1 {
            ServiceNavigationBar(title:tabTitle[selectedIndex], serviceConfigView: ServiceEditView().onDisappear(){
                BitService().login(completion: self.loadMainData)
            })
        } else {
            AboutNavigationBar(title: tabTitle[selectedIndex])
        }
    }
    
    func loadMainData(needLoad: Bool){
        if(needLoad) {
            bitClientAppViewModel.start()
        }
    }
    
    init(){
        bitClientAppViewModel.start()
        Theme.navigationBarColors(background: .white, titleColor: .black)
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                HomeView(torrents: bitClientAppViewModel.mainData?.torrents.filter { (item) -> Bool in
                    if(self.homeMenu == 0.5) {
                        return (item.value.state == "uploading" || item.value.state == "downloading")
                    }
                    if(self.homeMenu == 1) {
                        return item.value.state == "pausedUP"
                    }
                    return true
                })
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text(tabTitle[0])
                    }.tag(0)
                ServiceView(serverState: bitClientAppViewModel.mainData?.serverState)
                    .tabItem {
                        Image(systemName: "externaldrive")
                        .environment(\.symbolVariants, .none)
                        Text(tabTitle[1])
                    }.tag(1)
                AboutView()
                    .tabItem {
                        Image(systemName: "info.circle")
                        .environment(\.symbolVariants, .none)
                        Text(tabTitle[2])
                    }.tag(2)
            }
            .listStyle(PlainListStyle())
            .navigationBarItems(leading: navigationBarLeadingItems)
            .navigationBarTitle(Text(tabTitle[selectedIndex]), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                BitService().login(completion: self.loadMainData)
            case .inactive:
                bitClientAppViewModel.stop()
            case .background:
                bitClientAppViewModel.stop()
            @unknown default:
              print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
