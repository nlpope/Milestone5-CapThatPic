//
//  HomeTableVC.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 2/25/25.
//

import UIKit

class HomeTableVC: UITableViewController, UIImagePickerControllerDelegate
{
    var photoArray = [CaptionedImage]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("heyz")
    }


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
