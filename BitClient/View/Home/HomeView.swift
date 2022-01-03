//
//  HomeView.swift
//  Demo
//
//  Created by alan on 2021/11/2.
//

import SwiftUI

struct HomeView: View {
    var bitService = BitService()
    var torrents: [String: Torrent]?
    @State private var deleteConfirmationShown = false
    @State private var selectedKey = "";
    
    var body: some View {
        if (bitService.url == "") {
            NoServiceTipView()
        } else if(torrents == nil) {
            ServiceOfflineTipView()
        } else if(torrents!.count == 0) {
            ListEmptyTipView()
        } else {
            List{
                ForEach(torrents!.sorted{(s1, s2) -> Bool in return s1.value.addedOn == s2.value.addedOn ? s1.key < s2.key : s1.value.addedOn < s2.value.addedOn}, id: \.key){ key, torrent in
                    TorrentItem(torrent: torrent).frame(height: 70)
                        .swipeActions {
                            Button {
                                deleteConfirmationShown = true
                                selectedKey = key
                            } label: {
                                Label("删除", systemImage: "trash")
                            }
                            .tint(.red)
                            Button {
                                if(torrent.state != "pausedUP") {
                                    bitService.pause(id: key)
                                }else {
                                    bitService.resume(id: key)
                                }
                            } label: {
                                Label("Favorite", systemImage: torrent.state != "pausedUP" ? "pause" : "play.fill")
                            }
                            .tint(.yellow)
                    }
                }
            }.confirmationDialog(
                "提示",
                 isPresented: $deleteConfirmationShown,
                titleVisibility: .visible
            ) {
                Button("删除") {
                    bitService.delete(id: selectedKey, deleteFiles: false)
                    selectedKey = ""
                }
                Button("删除并删除文件", role: .destructive) {
                    bitService.delete(id: selectedKey, deleteFiles: true)
                    selectedKey = ""
                }
                Button("取消", role: .cancel) {
                    deleteConfirmationShown = false
                }
            }
        }
    }
}
