//
//  ViewController.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import UIKit

class MovieListViewController: UITableViewController {
    
    private var tableData: [RemoteMovie] = []
    private let loader: MovieLoader = MovieLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loader.getMovieList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(movies):
                self.updateTableData(movies: movies)
            case .failure(_):
                print("Handle error")
            }
        }
    }
    
    private func updateTableData(movies: [RemoteMovie]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableData.append(contentsOf: movies)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = tableData[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.descriptionLabel.text = movie.description
        
        return cell
    }
    
}

