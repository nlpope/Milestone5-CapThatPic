//
//  Constants+Utils.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 3/4/25.
//

import Foundation

enum Error
{
    static let dequeueCellFailure = "Unable to dequeue CaptionedImageCell"
}

enum Messages
{
    static let sourcePrompt     = "Would you like to add from your camera or photo library?"
    static let noCamera         = "Camera unavailable in this context."
    static let createACaption   = "Please create a caption for your image."
    static let deleteOrEdit     = "Would you like to delete this entry or edit its caption?"
}

enum Titles
{
    static let sourcePrompt     = "Please Choose Source Type"
    static let createACaption   = "Create A Caption"
}

enum Identifiers
{
    static let detailz          = "Detailz"
}
