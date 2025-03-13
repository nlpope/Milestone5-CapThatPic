//
//  DetailVC.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 2/25/25.
//

import UIKit

class DetailVC: UIViewController
{
    /**
     since I'm using IB, I won't bother w the initializer
     instantiateVC (unlike a programmatic approach, doesn't acct for the initializer
     so guessing I'll just need to use a dot operator to access these values
     */
    
    @IBOutlet var imageViewzz: UIImageView!
    @IBOutlet var imageCaption: UILabel!
    var selectedPhoto: String?
    var caption: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpNavigation()
        loadPhoto()
    }
    
    
    private func setUpNavigation()
    {
        navigationItem.largeTitleDisplayMode    = .never
    }
    
    
    private func loadPhoto()
    {
        /**
         was having issues populating DetailVC w an image (black screen)
         b/c img not saved to Content folder but written to docDirectory, access that to find UIImage(named...)
         **/
        if let photoToLoad = selectedPhoto {
            let path            = getDocumentsDirectory().appendingPathComponent(photoToLoad)
            imageViewzz.image   = UIImage(contentsOfFile: path.path)
            imageCaption.text   = caption
        }
        assert(selectedPhoto != nil, "selectedPhoto has no value")
    }
}
