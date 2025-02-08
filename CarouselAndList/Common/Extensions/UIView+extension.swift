//
//  UIView+extension.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit

extension UIView {
    func withInsets(_ insets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)) -> UIView {
        let containerView = UIView()
        containerView.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -insets.bottom)
        ])

        return containerView
    }
}

extension UIView {
    func encapsulate(backgroundColor: UIColor = .clear) -> UIView {
        let containerView = UIView()
        
        containerView.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        
        containerView.backgroundColor = backgroundColor
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        
        return containerView
    }
}
