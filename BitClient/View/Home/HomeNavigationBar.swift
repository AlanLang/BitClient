//
//  HomeNavigationBar.swift
//  Demo
//
//  Created by alan on 2021/11/2.
//

import SwiftUI

private let kLabelWidth: CGFloat = 50;
private let kButtonHeight: CGFloat = 24;
private let paddingTop: CGFloat = 5;

struct HomeNavigationBar<AddView>: View where AddView : View {
    @Binding var leftPercent: CGFloat;// 0: left; 0.5: center; 1: right
    var addView: AddView;
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Button(action: {
                print("click name action")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                    .hidden()// 暂时先不需要
            }
            Spacer()
            VStack(spacing: 3) {
                HStack(spacing: 0) {
                    Text(Constants.NavBar.Home.all)
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
                    Text(Constants.NavBar.Home.active)
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, paddingTop)
                        .opacity(leftPercent == 0.5 ? 1 : 0.5)
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 0.5;
                            }
                        }
                    Spacer()
                    Text(Constants.NavBar.Home.pause)
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, paddingTop)
                        .opacity(leftPercent == 1 ? 1 : 0.5)
                        .onTapGesture {
                            withAnimation{
                                self.leftPercent = 1;
                            }
                        }
                }
                
                GeometryReader{geometry in HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 2)
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width / 4, height: 4)
                        .offset(x: geometry.size.width * (self.leftPercent - 0.5) + kLabelWidth * (0.5 - self.leftPercent))
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                }.frame(height: 6)
                
            }.frame(width: UIScreen.main.bounds.width * 0.5)
            Spacer()
            NavigationLink(destination: addView) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 2)
                    .foregroundColor(.blue)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

//struct HomeNavigationBar_Previews: PreviewProvider {
//    @State var leftPercent:CGFloat = 0
//    static var previews: some View {
//        HomeNavigationBar(leftPercent: leftPercent, addView: Text(""))
//    }
//}


