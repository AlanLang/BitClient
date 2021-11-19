//
//  TorrentItem.swift
//  BitClient
//
//  Created by alan on 2021/11/3.
//

import SwiftUI

private let secondFontSize: CGFloat = 12;
private let mainFontSize: CGFloat = 15;

/*
 * 速度显示
 * 显示下载速度和上传速度
 */
struct SpeedView: View {
    var dlSpeed: Int
    var upSpeed: Int
    var ratio: Double
    var state: String
    
    var body: some View {
        HStack{
            Spacer()
            if (state == "pausedUP") {
                Image(systemName: "pause.circle")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.red).offset(x: 5)
                Text(String(format:"%.2f",ratio)).font(.system(size: secondFontSize))
            }else if (dlSpeed > 0) {
                Image(systemName: "arrow.down")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.blue).offset(x: 5)
                Text(UtilsManager.getSizeText(dlSpeed) + "/S").font(.system(size: secondFontSize))
            } else if (upSpeed > 0) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.red).offset(x: 5)
                Text(UtilsManager.getSizeText(upSpeed) + "/S").font(.system(size: secondFontSize))
            } else {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.blue).offset(x: 5)
                Text(String(format:"%.2f",ratio)).font(.system(size: secondFontSize))
            }
        }
        .frame(width: 120)
    }
}

/*
 * 下载时显示下载进度，下载完成时显示分享率
 */
struct RatioView: View {
    var ratio: Double
    var body: some View {
        Text(String(format:"%.2f",ratio)).font(.system(size: secondFontSize))
    }
}

struct AddTime: View {
    var addedOn: Int
    var body: some View {
        Text(UtilsManager.timeStampToCurrennTime(timeStamp: Double(addedOn))).font(.system(size: secondFontSize))
    }
}

/*
 * 文件大小显示
 */
struct SizeView: View {
    var size: Int
    var body: some View {
        HStack{
            Text(UtilsManager.getSizeText(size)).font(.system(size: secondFontSize))
            Spacer()
        }.frame(width: 120)
    }
}

/*
 * 文件名称
 */
struct FileNameView: View {
    var text: String;
    init(_ text: String) { // _ 表示该参数传递时不用写参数名
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: mainFontSize))
            .frame(height: 20)
            .lineLimit(nil)
    }
}

struct TorrentItem: View {
    var torrent: Torrent
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                FileNameView(torrent.name)
                Spacer()
            }
            
            ProgressView("",value:  Double(torrent.progress * 100), total: 100).frame(height: 1).offset(y: 2)
            
            HStack(spacing: 0) {
                SizeView(size: torrent.size)
                Spacer()
                AddTime(addedOn: torrent.addedOn)
                Spacer()
                SpeedView(dlSpeed: torrent.dlspeed, upSpeed: torrent.upspeed, ratio: torrent.ratio, state: torrent.state)
            }.offset(y: 22)
        }.padding(.bottom, 17)
    }
}
