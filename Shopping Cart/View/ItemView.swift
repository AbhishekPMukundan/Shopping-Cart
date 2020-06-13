//
//  ItemView.swift
//  Shopping Cart
//
//  Created by Abhishek on 12/06/2020.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit

class ItemView: UIView  {
    //MARK: - Properties
    private let itemImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.setDimensions(width: 100, height: 100)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let itemName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Item name"
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    private let itemPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "£100.0"
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "1"
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setDimensions(width: 40, height: 40)
        button.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setDimensions(width: 40, height: 40)
        button.addTarget(self, action: #selector(increment), for: .touchUpInside)
        return button
    }()
    
    private let addToButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.setDimensions(width: 150, height: 50)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.setTitle("Add to cart", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(increment), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.purple .withAlphaComponent(0.5)
        self.layer.cornerRadius = 10
        
        let quantityStack = UIStackView(arrangedSubviews: [minusButton, quantityLabel, plusButton])
        quantityStack.axis = .horizontal
        quantityStack.distribution = .fill
        quantityStack.alignment = .center
        quantityStack.spacing = 20
        
        let mainStack = UIStackView(arrangedSubviews: [itemImage, quantityStack, itemName, itemPrice, addToButton])
        mainStack.axis = .vertical
        mainStack.distribution = .fill
        mainStack.alignment = .center
        mainStack.spacing = 16
        self.addSubview(mainStack)
        
        mainStack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helper
    @objc
    func decrement() {
        print("decrement")
    }
    
    @objc
    func increment() {
        print("increment")
    }
    
    func getItem(item: Item) {
        switch item.name {
        case Category.Cocacola.rawValue:
            let itemDetails = ItemDetails(name: "Coca-cola Zero sugar", price: "£0.79", image: item.image)
            showItem(itemDetails: itemDetails)
            break
        case Category.Wine.rawValue:
            let itemDetails = ItemDetails(name: "BAREFOOT 750ml", price: "£10.99", image: item.image)
            showItem(itemDetails: itemDetails)
            break
        case Category.Maggi.rawValue:
            let itemDetails = ItemDetails(name: "Maggi Instant Noodles", price: "£ 0.49", image: item.image)
            showItem(itemDetails: itemDetails)
            break
        case Category.Jam.rawValue:
            let itemDetails = ItemDetails(name: "Strawberry Jam", price: "£3.49", image: item.image)
            showItem(itemDetails: itemDetails)
            break
        case Category.Ketchup.rawValue:
            let itemDetails = ItemDetails(name: "HEINZ Tomato Ketchup", price: "£3.00", image: item.image)
            showItem(itemDetails: itemDetails)
            break
        default:
            break
        }
        
    }
    
    func showItem(itemDetails: ItemDetails) {
        itemName.text = itemDetails.name
        itemPrice.text = itemDetails.price
        itemImage.image = UIImage(ciImage: itemDetails.image)
    }
    
}
