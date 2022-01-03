//
//  BitClientAppViewModel.swift
//  BitClient
//
//  Created by Alan on 2021/11/7.
//

import Foundation
import SwiftUI

class BitClientAppViewModel: ObservableObject {
    @Published var mainData: Maindata?
    @Published var error: String = ""
    var timer: Timer? = nil
    
    init (){
        
    }
    
    func start(){
        self.timer = Timer.init(timeInterval: 1, repeats:true) { (kTimer) in
            self.loadMainData()
        }
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        // TODO : 启动定时器
        self.timer!.fire()
    }
    
    func stop(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func loadMainData(){
        if(BitService().url != "") {
            NetworkAPi.getMainData() {result in
                switch result {
                case let .success(data):
                    self.mainData = data;
                case let .failure(error):
                    self.error = "\(error)"
                    print(error)
                }
            }
        }
    }
}
