//
//  HomeTableVC.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 2/25/25.
//

import UIKit

class HomeTableVC: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    var photoArray = [CaptionedImage]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("heyz")
        setUpNavigation()
    }


    func setUpNavigation()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCaptionedImage))
    }
    
    
    @objc func addNewCaptionedImage()
    {
        let picker          = UIImagePickerController()
        let ac0             = UIAlertController(title: "Please Choose", message: Messages.sourcePrompt , preferredStyle: .alert )
        
        let cameraAction    = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera)
            else { print(Messages.noCamera); return }
            picker.sourceType       = .camera
            picker.allowsEditing    = true
            picker.delegate         = self
        }
        let libraryAction   = UIAlertAction(title: "Library", style: .default) { [weak self] _ in
            picker.allowsEditing    = true
            picker.delegate         = self
        }
        
        ac0.addActionz(cameraAction, libraryAction)
    }
    //-------------------------------------//
    // MARK: TABLEVIEW DELEGATE & DATASOURCE METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return photoArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("row selected")
    }
}
