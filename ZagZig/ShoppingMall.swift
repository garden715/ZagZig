//
//  ShoppingMall.swift
//  TableView3
//  hello
//  Created by seojungwon on 2016. 4. 6..
//  Copyright © 2016년 seojungwon. All rights reserved.
//

import Foundation
import UIKit

// MARK - 쇼핑몰 페이지 객체를 위한 클래스

class ShoppingMall {
    var name : String
    var photo : UIImage?
    var url : String
    
    init?(name : String, photo : UIImage?, url : String) {
        self.name = name
        self.photo = photo
        self.url = url
        
        if name.isEmpty || url.isEmpty {
            return nil
        }
    }
}