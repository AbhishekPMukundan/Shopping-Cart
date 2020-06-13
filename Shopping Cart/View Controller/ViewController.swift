//
//  ViewController.swift
//  Shopping Cart
//
//  Created by Abhishek on 12/06/2020.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    //MARK: - Properties
    private let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        button.setImage(UIImage(systemName: "arrow.down.right.circle.fill"), for: .selected)
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 25
        button.setDimensions(width: 50, height: 50)
        button.addTarget(self, action: #selector(viewCart(sender:)), for: .touchUpInside)
        return button
    }()
    
    private let shutterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 25
        button.setDimensions(width: 50, height: 50)
        button.addTarget(self, action: #selector(captureItem), for: .touchUpInside)
        return button
    }()
    
    
    lazy var cartView = CartView(frame: CGRect(x: cartButton.frame.origin.x, y: cartButton.frame.origin.y, width: 50, height: 50))
    let itemView = ItemView()
    
    let imagePicker: UIImagePickerController = {
       let ip = UIImagePickerController()
        ip.sourceType = .camera
        ip.allowsEditing = false
        return ip
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addCartButton()
        addShutterButton()
        imagePicker.delegate = self
    }
    
    //MARK: - Helper
    func addCartButton() {
        view.addSubview(cartButton)
        cartButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,
                          paddingBottom: 20,
                          paddingRight: 20)
    }
    
    func addShutterButton() {
        view.addSubview(shutterButton)
        shutterButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: cartButton.leftAnchor,
                          paddingBottom: 20,
                          paddingRight: 20)
    }
    
    func showItem(identifier: String, image: CIImage) {
        view.addSubview(itemView)
        itemView.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 20, paddingRight: 20)
        itemView.centerX(inView: self.view)
        itemView.centerY(inView: self.view)
        itemView.getItem(item: Item(name: identifier, image: image))
    }
    
    @objc
    func viewCart(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            showCart()
        }else{
            hideCart()
        }
    }
    
    @objc
    func captureItem() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showCart() {
        itemView.removeFromSuperview()
        
        cartView.layer.cornerRadius = 25
        self.view.addSubview(cartView)
        self.view.bringSubviewToFront(cartButton)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.5) {
                self.cartView.frame.origin.x = 20
                self.cartView.frame.origin.y = 80
                self.cartView.frame.size.height = (self.view.frame.size.height - 100)
                self.cartView.frame.size.width = (self.view.frame.size.width - 40)
                self.cartView.layoutIfNeeded()
            }
        }
        
    }
    
    func hideCart() {
        UIView.animate(withDuration: 1.0) {
            self.cartView.frame.origin.x = self.cartButton.frame.origin.x
            self.cartView.frame.origin.y = self.cartButton.frame.origin.y
            self.cartView.frame.size.height = 50
            self.cartView.frame.size.width = 50
            self.cartView.layoutIfNeeded()
        }
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Items().model) else {fatalError("Load failed")}
        
        let request  = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {fatalError("request failed")}
            if let firstResult = result.first {
                self.showItem(identifier: firstResult.identifier, image: image)
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage{
            //imageViewOfItem.image = userPickedImage
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("no no")
            }
            detect(image: ciImage)
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
