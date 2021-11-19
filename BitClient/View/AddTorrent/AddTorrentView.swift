//
//  AddTorrentView.swift
//  BitClient
//
//  Created by alan on 2021/11/5.
//

import SwiftUI


struct AddTorrentLinkView: View {
    @ObservedObject private var addTorrentLinkFormModel: AddTorrentLinkFormModel
    
    init(defaultSavePath: String) {
        UITableView.appearance().sectionFooterHeight = 8
        addTorrentLinkFormModel = AddTorrentLinkFormModel(savepath: defaultSavePath)
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        Form{
            Section(header: Text("磁力链接地址")) {
                TextEditor(text: $addTorrentLinkFormModel.urls)
                    .frame(height: 100)
            }
            
            Section(header: Text("下载设置")) {
                TextField("保存文件到", text: $addTorrentLinkFormModel.savepath)
                TextField("重命名", text: $addTorrentLinkFormModel.rename)
                Toggle("添加后暂停", isOn: $addTorrentLinkFormModel.paused)
                Toggle("保留顶层文件", isOn: $addTorrentLinkFormModel.root_folder)
                Toggle("按顺序下载", isOn: $addTorrentLinkFormModel.sequentialDownload)
                Toggle("跳过哈希值", isOn: $addTorrentLinkFormModel.skip_checking)
            }
            
            Section(header: Button(action: {
                if(addTorrentLinkFormModel.urls == "") {
                    Message.warning(message: "下载地址不能为空", title: "磁力下载")
                }else {
                    addTorrentLinkFormModel.download() { result in
                        if(result) {
                            self.mode.wrappedValue.dismiss()
                        }
                    }
                }
            }) {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "trash")
                        Text("开始下载")
                        Spacer()
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                .background(Color.blue)
                .frame(height: 35)
            }){}
        }
    }
}

struct AddTorrentView: View {
    var defaultSavePath: String
    var body: some View {
        AddTorrentLinkView(defaultSavePath: defaultSavePath)
        .listStyle(PlainListStyle())
        .navigationBarTitle(Text("磁力下载"), displayMode: .inline)
    }
}

struct AddTorrentView_Previews: PreviewProvider {
    static var previews: some View {
        AddTorrentView(defaultSavePath: "")
    }
}
