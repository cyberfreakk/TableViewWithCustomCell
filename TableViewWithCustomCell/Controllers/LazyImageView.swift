//
//  LazyImageView.swift
//  TableViewAssignment
//
//  Created by Arunesh Gupta on 08/10/23.
//

import Foundation
import UIKit

class LazyImageView: UIImageView{
    
    private let imageCache = NSCache<AnyObject, UIImage>()
    func loadImage(fromURL imageURL: URL, placeholderImage: String){
        self.image = UIImage(systemName: placeholderImage)
        
        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject){
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async{
            [weak self] in
            if let imageData = try? Data(contentsOf: imageURL){
                if let image = UIImage(data: imageData){
                    DispatchQueue.main.async {
                        self?.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
