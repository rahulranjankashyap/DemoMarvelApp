//
//  ListModel.swift
//  DemoMarvelApp
//
//  Created by Rahul Ranjan Kashyap on 02/12/20.
//  Copyright © 2020 Rahul Ranjan Kashyap. All rights reserved.
//

import Foundation

struct ListModel {
    var imageid:Int?
    var title:String?
    var imageName:String?
    var desc:String?

    init(imageid:Int,title:String,imageName:String,desc:String) {
        
        self.imageid = imageid
        self.title = title
        self.imageName = imageName
        self.desc = desc

    }
}
