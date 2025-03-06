//
//  PersistenceManager.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 3/5/25.
//

import Foundation

enum PersistenceManager
{
    enum SaveKeys { static let captionedImages = "captionedImages"}
    
    //-------------------------------------//
    // MARK: SAVE & LOAD
    
    static func save(_ photoArray: [CaptionedImage])
    {
        let jsonEncoder     = JSONEncoder()
        if let encodedArray = try? jsonEncoder.encode(photoArray)
        {
            let defaults = UserDefaults.standard
            defaults.set(encodedArray, forKey: SaveKeys.captionedImages)
        }
        else { print("unable to save array") }
    }
    
    
    static func load(forArray photoArray: [CaptionedImage] = [CaptionedImage]()) -> [CaptionedImage]
    {
        var arrayToReturn   = photoArray
        let defaults        = UserDefaults.standard
        
        if let encodedArray = defaults.object(forKey: SaveKeys.captionedImages) as? Data
        {
            let jsonDecoder = JSONDecoder()
            do { arrayToReturn = try jsonDecoder.decode([CaptionedImage].self, from: encodedArray) }
            catch { print("unable to load array") }
        }
        
        return arrayToReturn
    }
}
