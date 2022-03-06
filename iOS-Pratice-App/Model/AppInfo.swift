//
//  AppInfo.swift
//  testeImagePicker
//
//  Created by Rodrigo Guimaraes on 2017-10-27.
//  Copyright © 2017 RodrigoLG. All rights reserved.
//

import Foundation
import FirebaseDatabase

class AppInfo : FIRDataObject{
    @objc var name : String = ""
    @objc var price : Int = 0
    @objc var imageUrl : String = ""
    
    var dictionaryRepresentation : [String : Any] {
        return [
            "name" : name,
            "price" : price,
            "imageUrl" : imageUrl
        ]
    }
    
    init(name: String, price: Int, imageUrl: String){
        super.init(snapShot: DataSnapshot())
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
    }
    
    required init(snapShot: DataSnapshot){
        super.init(snapShot: snapShot)
    }
}
