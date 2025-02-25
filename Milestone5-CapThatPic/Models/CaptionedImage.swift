//
//  CaptionedImage.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 2/25/25.
//

import UIKit

class CaptionedImage: NSObject
{
    var image: UIImage
    var caption: String
    
    init(image: UIImage, caption: String)
    {
        self.image      = image
        self.caption    = caption
    }
}
