//
//  MainViewController.swift
//  Favorite Films
//
//  Created by Alex Provarenko on 31.08.2022.
//


import UIKit
import OrderedCollections

class MainViewController: UIViewController, UITextViewDelegate{
    
    var addedMovies: OrderedSet<Movie> = []
    
    let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 15
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let movieTitleTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.tintColor.cgColor
        tf.layer.masksToBounds = true
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.backgroundColor = .clear
        tf.layer.cornerRadius = 4.0
        tf.keyboardAppearance = .dark
        tf.attributedPlaceholder = NSAttributedString(string: "Movie title", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return tf
    }()
    
    private let movieRelaseYearTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.tintColor.cgColor
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.backgroundColor = .clear
        tf.layer.cornerRadius = 4.0
        tf.keyboardType = .decimalPad
        tf.keyboardAppearance = .dark
        tf.attributedPlaceholder = NSAttributedString(string: "Release year", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return tf
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add film", for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let gradienLayer: CAGradientLayer = {
        let gradienLayer = CAGradientLayer()
        gradienLayer.colors = [UIColor.systemPink.cgColor,UIColor.systemBlue.cgColor]
        return gradienLayer
    }()
    
    
    func confifureTapGesture() {
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(MainViewController.battonTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureButton() {
        addButton.addTarget(self, action: #selector(battonTap), for: .touchUpInside)
    }
    
    @objc func battonTap () {
        guard let movie = movieTitleTextField.text, !movie.isEmpty,
              let releaseYear = movieRelaseYearTextField.text, !releaseYear.isEmpty else {return}
        
        if addedMovies.contains(where: { $0.title == movie }) {
            return
        }
        
        addedMovies.append(Movie(title: movie, year: Int(releaseYear) ?? 0))
        
        self.movieTableView.insertRows(at: [IndexPath(row: self.addedMovies.count - 1,
                                                      section: 0)], with: .automatic)
        
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(gradienLayer)
        gradienLayer.frame = view.bounds
        view.addSubview(movieTitleTextField)
        view.addSubview(movieRelaseYearTextField)
        view.addSubview(addButton)
        view.addSubview(movieTableView)
   
        title = "Add movies"
        configureConstraints()
        configureButton()
             
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieRelaseYearTextField.delegate = self
        
    }
      
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            movieTitleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            movieTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            movieTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            movieTitleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            movieRelaseYearTextField.topAnchor.constraint(equalTo: movieTitleTextField.bottomAnchor, constant: 15),
            movieRelaseYearTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            movieRelaseYearTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            movieRelaseYearTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addButton.topAnchor.constraint(equalTo: movieRelaseYearTextField.bottomAnchor, constant: 30),
            addButton.centerXAnchor.constraint(equalTo: movieRelaseYearTextField.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 300),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            
            movieTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 40),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        
        let model = addedMovies[indexPath.row]
        
        cell.movieTitleLabel.text = model.title
        cell.moiveRelaseYearLabel.text = String(model.year)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieTableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            movieRelaseYearTextField.text = ""
            return false
        }
        return true
    }
    
}
