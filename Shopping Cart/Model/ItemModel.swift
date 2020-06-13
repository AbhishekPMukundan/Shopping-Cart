//
//  ItemModel.swift
//  Shopping Cart
//
//  Created by Abhishek on 13/06/2020.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit
import Foundation

struct Item {
    let name: String
    let image: CIImage
}

struct ItemDetails {
    let name: String
    let price: String
    let image: CIImage
}

enum Category: String {
    case Wine = "Wine"
    case Maggi = "Maggi"
    case Jam = "Jam"
    case Ketchup = "Ketchup"
    case Cocacola = "Coca-cola"
}
