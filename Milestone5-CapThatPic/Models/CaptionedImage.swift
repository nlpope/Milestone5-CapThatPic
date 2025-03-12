//
//  CaptionedImage.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 2/25/25.
//

import UIKit

class CaptionedImage: NSObject, Codable
{
    var caption: String
    var imageName: String
    
    init(imageName: String, caption: String)
    {
        self.imageName  = imageName
        self.caption    = caption
    }
}
