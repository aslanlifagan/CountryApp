//
//  UIImage+Extensions.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 23.12.22.
//

import UIKit

extension UIImage {
    
    func resizeImage(_ newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func paddingImage(_ padding: UIEdgeInsets) -> UIImage? {
        let width = padding.left + self.size.width
        let height = padding.top + self.size.height
        let adjustSizeForBetterHorizontalAlignment: CGSize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(adjustSizeForBetterHorizontalAlignment, false, 0)
        self.draw(at: CGPoint(x: padding.left, y: padding.bottom))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imageWithColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func crop(to:CGSize) -> UIImage {

        guard let cgimage = self.cgImage else { return self }

        let contextImage: UIImage = UIImage(cgImage: cgimage)

        guard let newCgImage = contextImage.cgImage else { return self }

        let contextSize: CGSize = contextImage.size

        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height

        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height

        if to.width > to.height { //Landscape
          cropWidth = contextSize.width
          cropHeight = contextSize.width / cropAspect
          posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
          cropHeight = contextSize.height
          cropWidth = contextSize.height * cropAspect
          posX = (contextSize.width - cropWidth) / 2
        } else { //Square
          if contextSize.width >= contextSize.height { //Square on landscape (or square)
              cropHeight = contextSize.height
              cropWidth = contextSize.height * cropAspect
              posX = (contextSize.width - cropWidth) / 2
          }else{ //Square on portrait
              cropWidth = contextSize.width
              cropHeight = contextSize.width / cropAspect
              posY = (contextSize.height - cropHeight) / 2
          }
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)

        // Create bitmap image from context using the rect
        guard let imageRef: CGImage = newCgImage.cropping(to: rect) else { return self}

        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

        UIGraphicsBeginImageContextWithOptions(to, false, self.scale)
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resized ?? self
    }
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
