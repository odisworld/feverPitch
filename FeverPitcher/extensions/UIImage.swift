//
//  UIImage.swift
//  FeverPitcher
//
//  Created by Consultant on 26/08/2022.
//

import Foundation
import UIKit

private let imageCache = NSCache<NSString, UIImage>()
extension UIImage {
  var scaledToSafeUploadSize: UIImage? {
    let maxImageSideLength: CGFloat = 480

    let largerSide: CGFloat = max(size.width, size.height)
    let ratioScale: CGFloat = largerSide > maxImageSideLength ? largerSide / maxImageSideLength : 1
    let newImageSize = CGSize(
      width: size.width / ratioScale,
      height: size.height / ratioScale)

    return image(scaledTo: newImageSize)
  }

  func image(scaledTo size: CGSize) -> UIImage? {
    defer {
      UIGraphicsEndImageContext()
    }

    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    draw(in: CGRect(origin: .zero, size: size))

    return UIGraphicsGetImageFromCurrentImageContext()
  }
  
    
  
    
    
}

extension UIImageView {

    func loadImageFrom(url: URL, placeHolderImage: UIImage?) {
        
        image = nil
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.image = placeHolderImage
                }
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                        self.image = downloadedImage
                    }
                }
            }
        }).resume()
    }
}

