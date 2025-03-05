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
        setUpNavigation()
    }


    func setUpNavigation()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCaptionedImage))
    }
    
    
    @objc func addNewCaptionedImage()
    {
        let picker          = UIImagePickerController()
        let ac0             = UIAlertController(title: Titles.sourcePrompt,
                                                message: Messages.sourcePrompt ,
                                                preferredStyle: .alert )
        
        let cameraAction    = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera)
            else { print(Messages.noCamera); return }
            picker.sourceType       = .camera
            picker.allowsEditing    = true
            picker.delegate         = self
            self?.present(picker, animated: true)
        }
        
        let libraryAction   = UIAlertAction(title: "Library", style: .default) { [weak self] _ in
            picker.sourceType       = .photoLibrary
            picker.allowsEditing    = true
            picker.delegate         = self
            self?.present(picker, animated: true)
        }
        
        ac0.addActionz(cameraAction, libraryAction)
        present(ac0, animated: true)
    }
    
    
    func displayCellOptionsAC(forImage img: CaptionedImage, atIndex index: IndexPath) {
        let ac  = UIAlertController(title: "Please choose", message: Messages.deleteOrEdit, preferredStyle: .alert)
        
        let editAction      = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            self?.displayCaptionerAC(for: img)
        }
        
        let deleteAction    = UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            self?.photoArray.remove(at: index.item)
            self?.tableView.reloadData()
            PersistenceManager.save(self?.photoArray ?? [CaptionedImage]())
        }
        
        ac.addActionz(editAction, deleteAction)
        present(ac, animated: true)
    }
    
    
    func displayCaptionerAC(for imageToCaption: CaptionedImage)
    {
        let ac             = UIAlertController(title: Titles.createACaption, message: Messages.createACaption, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].placeholder = "Enter your caption"
        ac.addAction(UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            guard let newCaption    = ac.textFields?[0].text else { return }
            imageToCaption.caption  = newCaption
            self?.tableView.reloadData()
        })
        
        present(ac, animated: true)
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
        let imageToCap    = photoArray[indexPath.row]
        displayCellOptionsAC(forImage: imageToCap, atIndex: indexPath)
    }
    
    //-------------------------------------//
    // MARK: IMAGE PICKER CONTROLLER DELEGATE METHODS
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image     = info[.editedImage] as? UIImage else { return }
        
        let imageName       = UUID().uuidString
        let imagePath       = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData     = image.jpegData(compressionQuality: 0.8) { try? jpegData.write(to: imagePath) }
        
        let imageToCap      = CaptionedImage(caption: "no cap", image: imageName)
        photoArray.append(imageToCap)
        dismiss(animated: true)
    }
    
    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
