//
//  BannerCell.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit

// MARK: - Custom Cells
class BannerCell: UICollectionViewCell {
    static let reuseIdentifier = "BannerCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        if let imageURL = movie.imageURL {
            Task {
                await imageView.loadImage(from: imageURL)
            }
        }
    }
}
