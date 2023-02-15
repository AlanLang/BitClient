//
//  AddTorrentView.swift
//  BitClient
//
//  Created by alan on 2021/11/5.
//

import SwiftUI

import UniformTypeIdentifiers


func regexGetSub(pattern:String, str:String) -> String {
    var subStr = ""
    let regex = try! NSRegularExpression(pattern: pattern, options:[])
    let matches = regex.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.count))
    if let match = matches.first {
        subStr = String(str[Range(match.range(at: 0), in: str)!])
    }
    return subStr
}

enum DownloadType: String, CaseIterable {
    case url = "磁链"
    case file = "种子"
    
    var localizedText: String {
        switch self {
        case .url:
            return Constants.Add.magnet
        case .file:
            return Constants.Add.file
        }
    }
}

struct AddTorrentLinkView: View {
    @ObservedObject private var addTorrentLinkFormModel: AddTorrentLinkFormModel
    @State private var showAlert = false
    @State private var copyUrl = ""
    
    @State var fileName = ""
    @State var fileUrl: URL = URL(string: "123")!
    @State var openFile = false
    
    @State private var downloadType: DownloadType = .url
    
    
    init(defaultSavePath: String) {
        UITableView.appearance().sectionFooterHeight = 8
        addTorrentLinkFormModel = AddTorrentLinkFormModel(savepath: defaultSavePath)
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        Form{
            HStack(){
                Picker("a", selection: $downloadType) {
                    ForEach(DownloadType.allCases, id: \.self ) {
                        Text($0.localizedText)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }.listRowBackground(Color(UIColor.systemGroupedBackground))
            
            if(downloadType == .url) {
                Section(header: Text(Constants.Add.magnetUrl)) {
                    TextEditor(text: $addTorrentLinkFormModel.urls)
                        .frame(height: 100)
                }
            } else {
                Section(header: Text(Constants.Add.torrentFile)) {
                    Button(action: {openFile.toggle()}, label: {
                        Text(fileName == "" ? Constants.Add.selectTorrent : fileName)
                    })
                }
            }

            Section(header: Text(Constants.Add.downloadSettings)) {
                TextField(Constants.Add.savePath, text: $addTorrentLinkFormModel.savepath)
                TextField(Constants.Add.rename, text: $addTorrentLinkFormModel.rename)
                Toggle(Constants.Add.pauseAfterAdding, isOn: $addTorrentLinkFormModel.paused)
                Toggle(Constants.Add.rootFolder, isOn: $addTorrentLinkFormModel.root_folder)
                Toggle(Constants.Add.sequentialDownload, isOn: $addTorrentLinkFormModel.sequentialDownload)
                Toggle(Constants.Add.skipChecking, isOn: $addTorrentLinkFormModel.skip_checking)
            }
        }
        .fileImporter(isPresented: $openFile, allowedContentTypes: [UTType(filenameExtension: "torrent")!]) { res in
            do {
                fileUrl = try res.get()
                if fileUrl.startAccessingSecurityScopedResource() {
                    fileName = fileUrl.lastPathComponent
                }
                print(fileUrl)
            }catch {
                print("error reading docs")
                print(error.localizedDescription)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        if(downloadType == .url) {
                            if(addTorrentLinkFormModel.urls == "") {
                                Message.warning(message: Constants.Add.Warnings.emptyMessage, title: Constants.Add.Warnings.emptyTitle)
                            }else {
                                addTorrentLinkFormModel.download() { result in
                                    if(result) {
                                        self.mode.wrappedValue.dismiss()
                                    }
                                }
                            }
                        } else {
                            if(fileName == "") {
                                Message.warning(message: Constants.Add.Warnings.fileMessage, title: Constants.Add.Warnings.fileTitle)
                            } else {
                                addTorrentLinkFormModel.downloadFile(fileUrl: fileUrl, fileName: fileName) { result in
                                    if(result) {
                                        self.mode.wrappedValue.dismiss()
                                    }
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
                    title: Text(Constants.Add.Alert.title),
                    message: Text(Constants.Add.Alert.message),
                    primaryButton: .default(
                        Text(Constants.Add.Alert.primaryButton),
                        action: {
                            showAlert = false
                        }
                    ),
                    secondaryButton: .default(
                        Text(Constants.Add.Alert.secondaryButton),
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
        .navigationBarTitle(Text(Constants.Add.NavBar.title), displayMode: .inline)
    }
}

struct AddTorrentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddTorrentView(defaultSavePath: "")
            AddTorrentView(defaultSavePath: "")
        }
    }
}
