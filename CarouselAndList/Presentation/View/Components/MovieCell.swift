//
//  MovieCell.swift
//  CarouselAndList
//
//  Created by Furkan ic on 8.02.2025.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseIdentifier = "MovieCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = .listbackground
        contentView.layer.cornerRadius = 12

        let vStack = UIStackView(arrangedSubviews: [nameLabel, explanationLabel])
        vStack.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [imageView, vStack])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        contentView.addSubview(stackView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func configure(with movie: Movie) {
        if let imageURL = movie.imageURL {
            Task {
                await imageView.loadImage(from: imageURL)
            }
        }
        nameLabel.text = movie.name
        explanationLabel.text = movie.explanation
    }
}
