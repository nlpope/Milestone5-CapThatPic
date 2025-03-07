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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var selectedImage: CaptionedImage?
    
    init(withSelectedImage selectedImage: CaptionedImage? = nil)
    {
        super.init(nibName: nil, bundle: nil)
        self.selectedImage = selectedImage
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode    = .never
        title                                   = selectedImage?.caption
        
        assert(selectedImage != nil, "selectedImage has no value")
    }
}
