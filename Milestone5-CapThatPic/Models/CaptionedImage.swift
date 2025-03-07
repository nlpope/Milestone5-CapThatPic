//
//  CaptionedImage.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 2/25/25.
//

import UIKit

class CaptionedImage: NSObject, Codable
{
    var caption: String!
    var imageName: String!
    
    init(caption: String, imageName: String)
    {
        self.caption    = caption
        self.imageName  = imageName
    }
}
