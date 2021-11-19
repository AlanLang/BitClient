//
//  AddTorrentNavigationBar.swift
//  BitClient
//
//  Created by alan on 2021/11/5.
//

import SwiftUI

private let kLabelWidth: CGFloat = 50;
private let kButtonHeight: CGFloat = 24;
private let paddingTop: CGFloat = 5;

struct AddTorrentNavigationBar: View {
    @State var leftPercent: CGFloat;// 0: left; 1: right
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Spacer()
            VStack(spacing: 3) {
                HStack(spacing: 0) {
                    Text("磁链")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, paddingTop)
                        .opacity(leftPercent == 0 ? 1 : 0.5)
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 0;
                            }
                        }
                    Spacer()
                    Text("种子")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, paddingTop)
                        .opacity(leftPercent == 1 ? 1 : 0.5)
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 1;
                            }
                        }
                }.font(.system(size: 18))
                
                GeometryReader{geometry in HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 2)
                        .foregroundColor(.blue)
                        .frame(width: 30, height: 4)
                        .offset(x: geometry.size.width * (self.leftPercent - 0.5) + kLabelWidth * (0.5 - self.leftPercent))
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                }.frame(height: 6)
            }.frame(width: UIScreen.main.bounds.width * 0.3)
            Spacer()
            Button(action: {
                print("click name action")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                    .hidden()// 暂时先不需要
            }
        }.frame(width: UIScreen.main.bounds.width)
    }
}

struct AddTorrentNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        AddTorrentNavigationBar(leftPercent: 0)
    }
}
