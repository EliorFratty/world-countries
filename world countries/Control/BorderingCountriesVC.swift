//
//  BorderingCountriesVC.swift
//  world countries
//
//  Created by User on 01/09/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class BorderingCountriesVC: UIViewController {

    let cellID = "BorderingCountriesCell"
    var borderingCountries = [Country]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupAnchors()
        makeNavBar()
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CountryCell.self, forCellReuseIdentifier: cellID)

        return tv
    }()
    
    
    func setupAnchors() {
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func makeNavBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        navigationController?.navigationBar.barStyle = .blackTranslucent
        self.title = "Bordering Countries"
        
        let goBackToWorldCountriesButton =  UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackToWorldCountries))
        goBackToWorldCountriesButton.tintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        navigationItem.leftBarButtonItem = goBackToWorldCountriesButton

    }
    
    @objc func goBackToWorldCountries(){
        navigationController?.popToRootViewController(animated: true)
    }
}


extension BorderingCountriesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return borderingCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath ) as! CountryCell
        cell.country = borderingCountries[indexPath.row]
        return cell
    }
    
    
}
