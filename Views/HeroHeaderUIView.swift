//
//  HeroHeaderUIView.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 11.12.2023.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    var onPreviewButtonTapped: (() -> Void)?
    var onDownloadButtonTapped: (() -> Void)?
    
    private let previewButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Preview", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(previewButton)
        addSubview(downloadButton)
        
        previewButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        
        applyConstraints()
    }
    
    @objc private func playButtonTapped() {
        animateButtonTap(previewButton)
        onPreviewButtonTapped?()
    }

    @objc private func downloadButtonTapped() {
        animateButtonTap(downloadButton)
        onDownloadButtonTapped?()
    }
    
    private func animateButtonTap(_ button: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                         button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                         UIView.animate(withDuration: 0.1) {
                             button.transform = CGAffineTransform.identity
                         }
                       })
    }

    
    private func applyConstraints() {
        
        let playButtonConstrains = [
            previewButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            previewButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            previewButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let downloadButtonConstrains = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(playButtonConstrains)
        NSLayoutConstraint.activate(downloadButtonConstrains)
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string : "\(Configuration.imageURL)/\(model.posterURL)") else {
            return
        }
        
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
