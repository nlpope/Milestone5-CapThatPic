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
    var image: String
    
    init(caption: String, image: String)
    {
        self.caption    = caption
        self.image      = image
    }
}
