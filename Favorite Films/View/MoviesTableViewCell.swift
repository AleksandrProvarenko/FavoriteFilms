//
//  FilmsTableViewCell.swift
//  Favorite Films
//
//  Created by Alex Provarenko on 31.08.2022.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    static let identifier = "MoviesTableViewCell"
    
    let movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel()
        movieTitleLabel.text = ""
        movieTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.tintColor = .black
        return movieTitleLabel
    }()
    
    let moiveRelaseYearLabel: UILabel = {
        let movieRelaseLabel = UILabel()
        movieRelaseLabel.text = ""
        movieRelaseLabel.font = .systemFont(ofSize: 25, weight: .medium)
        movieRelaseLabel.translatesAutoresizingMaskIntoConstraints = false
        movieRelaseLabel.tintColor = .black
        return movieRelaseLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(moiveRelaseYearLabel)
        
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            moiveRelaseYearLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor, constant: 20),
            moiveRelaseYearLabel.centerYAnchor.constraint(equalTo: movieTitleLabel.centerYAnchor)
            
        ])
    }
}


