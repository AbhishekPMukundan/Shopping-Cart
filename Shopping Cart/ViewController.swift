//
//  ViewController.swift
//  Shopping Cart
//
//  Created by Abhishek on 12/06/2020.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    private let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 25
        button.setDimensions(width: 50, height: 50)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(cartButton)
        cartButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,
                          paddingBottom: 20,
                          paddingRight: 20)
    }


}

