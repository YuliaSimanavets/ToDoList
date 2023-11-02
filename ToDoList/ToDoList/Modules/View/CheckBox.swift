//
//  CheckBox.swift
//  ToDoList
//
//  Created by Yuliya on 31/10/2023.
//

import UIKit

class Checkbox: UIControl {
    
    private weak var imageView: UIImageView!
    
    private var image: UIImage {
        return checked ? UIImage(systemName: "checkmark.circle.fill")! : UIImage(systemName: "circle")!
    }
    
    public var checked: Bool = false {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        self.imageView = imageView
        
        backgroundColor = UIColor.clear
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }
    
    @objc func touchUpInside() {
        checked = !checked
        sendActions(for: .valueChanged)
    }
}
