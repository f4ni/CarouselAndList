//
//  UILabel+extension.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.invalidateIntrinsicContentSize()
        self.lineBreakMode = .byTruncatingTail
        self.numberOfLines = 0
        self.text = text
        self.textColor = .label
        self.font = .systemFont(ofSize: 17, weight: .regular)
    }
}
