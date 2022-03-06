//
//  FIRDataObject.swift
//  testeImagePicker
//
//  Created by Rodrigo Guimaraes on 2017-10-27.
//  Copyright © 2017 RodrigoLG. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FIRDataObject : NSObject {
    
    let snapShot : DataSnapshot
    @objc var key : String { return snapShot.key }
    
    required init(snapShot : DataSnapshot){
        self.snapShot = snapShot
        
        super.init()
        
        for child in snapShot.children.allObjects as? [DataSnapshot] ?? [] {
            if responds(to: Selector(child.key)){
                setValue(child.value, forKey: child.key)
            }
        }
    }
}
