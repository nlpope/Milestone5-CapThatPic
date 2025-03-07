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
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    var selectedPhoto: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpNavigation()
        loadPhoto()
    }
    
    
    private func setUpNavigation()
    {
        navigationItem.largeTitleDisplayMode    = .never
        title                                   = selectedPhoto
    }
    
    
    private func loadPhoto()
    {
        if let photoToLoad = selectedPhoto { imageView.image = UIImage(named: photoToLoad) }
        assert(selectedPhoto != nil, "selectedPhoto has no value")
    }
}
