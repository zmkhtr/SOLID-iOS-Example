//
//  CatFactListViewController.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 12/11/22.
//

import UIKit

class CatFactListViewController: UITableViewController {
    
    private var tableData: [CatFactItem] = []
    private let loader = CatFactLoader(
        url: URL(string: "https://catfact.ninja/facts")!,
        client: URLSession.init(configuration: .ephemeral)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loader.load { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(catfacts):
                self.updateTableData(catfacts: catfacts)
            case .failure(_):
                print("Handle error")
            }
        }
    }
    
    private func updateTableData(catfacts: [CatFactItem]) {
        self.tableData.append(contentsOf: catfacts)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatFactCell", for: indexPath) as! CatFactCell
        
        let catFact = tableData[indexPath.row]
        cell.titleLabel.text = "Cat fact number \(indexPath.row + 1)"
        cell.descriptionLabel.text = catFact.fact
        
        return cell
    }
    
}

