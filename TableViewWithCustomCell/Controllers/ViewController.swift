//
//  ViewController.swift
//  TableViewAssignment
//
//  Created by Arunesh Gupta on 07/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    let dataResource: DataResource = DataResource()
    var result = [String: Page]()
    var resultArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        textField.placeholder = "Search from Wikipedia"
                
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 48))
        let label = UILabel(frame: header.bounds)
        label.text = "Results"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textAlignment = .center
        header.addSubview(label)
        tableView.tableHeaderView = header
    }

}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        if result.count > 0{
            let key = self.resultArray[indexPath.row]
            cell.configure(with: result[key]!.title, subtitle: result[key]!.extract, imageName: result[key]?.thumbnail?.source)
        }
        return cell
    }
}

extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text =  textField.text{
            getData(query: text + string)
        }
        
        return true
    }
    
}

extension ViewController{
    func getData(query: String){
        dataResource.getData(with: query) {[weak self] data, error in
            guard let self = self else{ return }
            self.result.removeAll()
            if let data = data{
                self.result = data.query.pages
                self.resultArray = Array(self.result.keys)
                self.resultArray.sort()
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
