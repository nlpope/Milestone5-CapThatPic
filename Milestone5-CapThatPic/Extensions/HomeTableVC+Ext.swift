//
//  HomeTableVC+Ext.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 3/4/25.
//

import UIKit

extension UIAlertController
{
    func addActionz(_ actions: UIAlertAction...)
    {
        for action in actions {
            self.addAction(action)
        }
    }
}
