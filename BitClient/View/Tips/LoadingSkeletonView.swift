//
//  LoadingSkeletonView.swift
//  BitClient
//
//  Created by Claude on 2025/9/8.
//

import SwiftUI

struct LoadingSkeletonView: View {
    @State private var isAnimating = false
    
    var body: some View {
        List {
            ForEach(0..<8, id: \.self) { _ in
                SkeletonRowView(isAnimating: $isAnimating)
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            print("LoadingSkeletonView appeared - showing skeleton screen")
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating.toggle()
            }
        }
    }
}

struct SkeletonRowView: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部：文件名
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.gray.opacity(isAnimating ? 0.3 : 0.6))
                    .frame(height: 20)
                    .cornerRadius(4)
                Spacer()
            }
            
            // 中间：进度条
            Rectangle()
                .fill(Color.gray.opacity(isAnimating ? 0.2 : 0.4))
                .frame(height: 2)
                .cornerRadius(1)
                .padding(.top, 4)
            
            // 增加间隔
            Spacer().frame(height: 8)
            
            // 底部：大小、时间、速度
            HStack(spacing: 0) {
                // 左侧：文件大小
                Rectangle()
                    .fill(Color.gray.opacity(isAnimating ? 0.3 : 0.6))
                    .frame(width: 80, height: 12)
                    .cornerRadius(2)
                
                Spacer()
                
                // 中间：添加时间
                Rectangle()
                    .fill(Color.gray.opacity(isAnimating ? 0.3 : 0.6))
                    .frame(width: 60, height: 12)
                    .cornerRadius(2)
                
                Spacer()
                
                // 右侧：速度信息
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.gray.opacity(isAnimating ? 0.3 : 0.6))
                        .frame(width: 10, height: 10)
                    Rectangle()
                        .fill(Color.gray.opacity(isAnimating ? 0.3 : 0.6))
                        .frame(width: 50, height: 12)
                        .cornerRadius(2)
                }
                .frame(width: 120, alignment: .trailing)
            }
            
            // 确保总高度
            Spacer().frame(height: 8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 19)
    }
}

struct LoadingSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSkeletonView()
    }
}