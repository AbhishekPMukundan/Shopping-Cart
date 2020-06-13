//
//  CartView.swift
//  Shopping Cart
//
//  Created by Abhishek on 12/06/2020.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

class CartView: UIView {
    //MARK: - Properties
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.alpha = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper
}
