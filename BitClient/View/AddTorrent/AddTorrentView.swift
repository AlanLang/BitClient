//
//  AddTorrentView.swift
//  BitClient
//
//  Created by alan on 2021/11/5.
//

import SwiftUI

func regexGetSub(pattern:String, str:String) -> String {
    var subStr = ""
    let regex = try! NSRegularExpression(pattern: pattern, options:[])
    let matches = regex.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.count))
    if let match = matches.first {
        subStr = String(str[Range(match.range(at: 0), in: str)!])
    }
    return subStr
}

struct AddTorrentLinkView: View {
    @ObservedObject private var addTorrentLinkFormModel: AddTorrentLinkFormModel
    @State private var showAlert = false
    @State private var copyUrl = ""
    
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
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        if(addTorrentLinkFormModel.urls == "") {
                            Message.warning(message: "下载地址不能为空", title: "磁力下载")
                        }else {
                            addTorrentLinkFormModel.download() { result in
                                if(result) {
                                    self.mode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }, label: {
                        Image(systemName: "square.and.arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 4)
                            .foregroundColor(.blue)
                    })
                }
            }
        }
        .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("提示"),
                    message: Text("检测到您复制了磁力链接，是否直接添加到下载？"),
                    primaryButton: .default(
                        Text("不要"),
                        action: {
                            showAlert = false
                        }
                    ),
                    secondaryButton: .default(
                        Text("添加"),
                        action: {
                            showAlert = false
                            addTorrentLinkFormModel.urls = copyUrl
                        }
                    )
                )
        }
        .onAppear() {
            copyUrl = ""
            if UIPasteboard.general.hasStrings {
                let url = regexGetSub(pattern: "magnet:\\?xt=urn:btih:[0-9a-fA-F]{40}", str: UIPasteboard.general.string ?? "")
                if(url != "") {
                    showAlert = true
                    copyUrl = url
                }
            }
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
