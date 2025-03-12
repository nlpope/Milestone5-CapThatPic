//
//  HomeTableVC.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 2/25/25.
//

import UIKit

class HomeTableVC: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    var photoArray          = [CaptionedImage]()
    var editModeOn: Bool    = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
        loadSavedPhotos()
    }


    func configureNavigation()
    {
        let additionItem    = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCaptionedImage))
        let editItem        = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditMode))
        navigationItem.leftBarButtonItems = [additionItem, editItem]
    }
    
    
    func configureTableView() { self.clearsSelectionOnViewWillAppear = true }
    
    
    func loadSavedPhotos()
    {
        photoArray = PersistenceManager.load(forArray: photoArray)
    }
    
    

    
    
    func displayEditOrDeleteAC(forIndex indexPath: IndexPath)
    {
        let ac  = UIAlertController(title: "Please choose", message: Messages.deleteOrEdit, preferredStyle: .alert)
        
        let editAction      = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            self?.displayCaptionerAC(forIndex: indexPath)
        }
        
        let deleteAction    = UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.photoArray.remove(at: indexPath.row)
            self.tableView.reloadData()
            PersistenceManager.save(self.photoArray)
        }
        
        ac.addActionz(editAction, deleteAction)
        present(ac, animated: true)
    }
    
    
    func displayCaptionerAC(forIndex indexPath: IndexPath)
    {
        let imageToCaption              = photoArray[indexPath.row]
        let ac                          = UIAlertController(title: Titles.createACaption,
                                               message: Messages.createACaption,
                                               preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].placeholder   = "Enter your caption"
        ac.addAction(UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            guard let self          = self else { return }
            guard let newCaption    = ac.textFields?[0].text else { return }
            imageToCaption.caption  = newCaption
            self.tableView.reloadData()
            PersistenceManager.save(self.photoArray)
        })
        
        present(ac, animated: true)
    }
    
    
    func pushDetailVC(forIndexPath indexPath: IndexPath)
    {
        let photo   = photoArray[indexPath.row]
        
        if let vc   = storyboard?.instantiateViewController(withIdentifier: Identifiers.detailz) as? DetailVC {
            vc.selectedPhoto        = photo.imageName
            vc.caption              = photo.caption
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //-------------------------------------//
    // MARK: OBJ-C SELECTOR FUNCS
    
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
    
    
    @objc func toggleEditMode() { editModeOn.toggle() }
    
    //-------------------------------------//
    // MARK: IMAGE PICKER CONTROLLER DELEGATE METHODS
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image     = info[.editedImage] as? UIImage else { return }
        
        let imageName       = UUID().uuidString
        let imagePath       = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData     = image.jpegData(compressionQuality: 0.8) { try? jpegData.write(to: imagePath) }
        
        let imageToCap      = CaptionedImage(imageName: imageName, caption: "")
        photoArray.append(imageToCap)
        
        tableView.reloadData()
        PersistenceManager.save(photoArray)
        dismiss(animated: true)
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
        
        let path                = getDocumentsDirectory().appendingPathComponent(photo.imageName)
        
        /**I wasn't calling ImageViewz but ImageView (no z), hence the layout not responding**/
        cell.imageViewz?.image  = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        editModeOn ? displayEditOrDeleteAC(forIndex: indexPath) : pushDetailVC(forIndexPath: indexPath)
        
    }
}

