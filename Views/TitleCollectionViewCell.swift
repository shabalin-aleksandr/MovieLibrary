//
//  TitleCollectionViewCell.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 11.12.2023.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func confiure(with model: String) {
        guard let url = URL(string : "\(Configuration.imageURL)/\(model)") else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}
