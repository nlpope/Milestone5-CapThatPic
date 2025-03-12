//
//  UIViewController+Ext.swift
//  Milestone5-CapThatPic
//
//  Created by Noah Pope on 3/11/25.
//

import UIKit

func getDocumentsDirectory() -> URL
{
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
