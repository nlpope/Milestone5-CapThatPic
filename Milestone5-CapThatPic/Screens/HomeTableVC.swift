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
        let ac0             = UIAlertController(title: Titles.sourcePrompt, message: Messages.sourcePrompt , preferredStyle: .alert )
        
        let cameraAction    = UIAlertAction(title: Titles.cameraBtn, style: .default) { [weak self] _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera)
            else { print(Messages.noCamera); return }
            picker.sourceType       = .camera
            picker.allowsEditing    = true
            picker.delegate         = self
            self?.present(picker, animated: true)
        }
        let libraryAction   = UIAlertAction(title: Titles.libraryBtn, style: .default) { [weak self] _ in
            picker.sourceType       = .photoLibrary
            picker.allowsEditing    = true
            picker.delegate         = self
            self?.present(picker, animated: true)
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
        guard let cell          = tableView.dequeueReusableCell(withIdentifier: "CapCell") as? CaptionedImageCell
        else { fatalError(Error.dequeueCellFailure) }
        
        let photo               = photoArray[indexPath.row]
        cell.caption.text       = photo.caption
        
        let path                = getDocumentsDirectory().appendingPathComponent(photo.image)
        cell.imageView?.image   = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("row selected")
    }
    
    //-------------------------------------//
    // MARK: IMAGE PICKER CONTROLLER DELEGATE METHODS
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName   = UUID().uuidString
        let imagePath   = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) { try? jpegData.write(to: imagePath) }
        let ac0         = UIAlertController(title: Titles.createACaption, message: Messages.createACaption, preferredStyle: .alert)
        ac0.addTextField()
        ac0.textFields?[0].placeholder = "enter a caption"
        
        let pic         = CaptionedImage(caption: "", image: imageName)
        photoArray.append(pic)
        
        tableView.reloadData()
        dismiss(animated: true)
    }
    
    
    func getDocumentsDirectory() -> URL
    {
        let paths       = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return  paths[0]
    }
}
