//
//  DetailVC.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 2/25/25.
//

import UIKit

class DetailVC:     UITableViewController,
                    UIImagePickerControllerDelegate,
                    UINavigationControllerDelegate
{
    @IBOutlet var imageView: UIImageView!
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
