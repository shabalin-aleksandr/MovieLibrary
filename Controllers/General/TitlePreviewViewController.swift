//
//  TitlePreviewViewController.swift
//  MovieLibrary
//
//  Created by Aleksandr Shabalin on 12.12.2023.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private var titleToDownload: Title?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        downloadButton.addTarget(self, action: #selector(downloadTitle), for: .touchUpInside)
        configureConstraints()
    }
    
    @objc private func downloadTitle() {
        guard let titleToDownload = titleToDownload, downloadButton.isEnabled else {
            print("Title is already downloaded or no title to download")
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            self.downloadButton.backgroundColor = .gray
            self.downloadButton.setTitle("Downloading...", for: .normal)
        }
        
        DataPersistenceManager.shared.downloadTitleWith(model: titleToDownload) { [weak self] result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                UIView.animate(withDuration: 0.2) {
                    self?.downloadButton.backgroundColor = .gray
                    self?.downloadButton.setTitle("In Library", for: .normal)
                    self?.downloadButton.isEnabled = false
                }
            case .failure(let error):
                print("Failed to download: \(error.localizedDescription)")
                UIView.animate(withDuration: 0.2) {
                    self?.downloadButton.backgroundColor = .red
                    self?.downloadButton.setTitle("Failed", for: .normal)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    UIView.animate(withDuration: 0.2) {
                        self?.downloadButton.backgroundColor = .red
                        self?.downloadButton.setTitle("Download", for: .normal)
                        self?.downloadButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    func configureConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    func configure(with model: TitlePreviewViewModel, title: Title) {
        self.titleToDownload = title
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        guard let url = URL(string: "\(Configuration.YouTubeBaseURL)/\(model.youTubeView.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
        downloadButton.addTarget(self, action: #selector(downloadTitle), for: .touchUpInside)
        if DataPersistenceManager.shared.isTitleDownloaded(with: title.id) {
            downloadButton.backgroundColor = .gray
            downloadButton.setTitle("In Library", for: .normal)
            downloadButton.isEnabled = false
        } else {
            downloadButton.backgroundColor = .red
            downloadButton.setTitle("Download", for: .normal)
            downloadButton.isEnabled = true
        }
    }
}
