//
//  UIImageView+download.swift
//  appSuggest
//
//  Created by Rodrigo Guimaraes on 2017-10-27.
//  Copyright © 2017 RodrigoLG. All rights reserved.
//

import UIKit
import ObjectiveC

private var keyAssociate : UInt8 = 0

extension UIImageView {
    
    
    var actualDownloadTask : URLSessionDataTask? {
        get{
            return objc_getAssociatedObject(self, &keyAssociate) as? URLSessionDataTask
        }
        set(value){
            objc_setAssociatedObject(self, &keyAssociate, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        if let oldDownloadTask = self.actualDownloadTask {
            oldDownloadTask.cancel()
        }
        self.actualDownloadTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
                DispatchQueue.main.async() {
                    self.image = image
                }
            
            }
        
        self.actualDownloadTask?.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
