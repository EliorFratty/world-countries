//
//  WorldCountriesTVC.swift
//  world countries
//
//  Created by User on 01/09/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class WorldCountriesTVC: UITableViewController {

    let cellID = "CountryCell"
    var countries = [Country]()
    var borderingCountriesDict = [String: Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        makeNavBar()
        getCountries()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CountryCell
        cell.country = countries[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let borderingCountriesVC = BorderingCountriesVC()
        let country = countries[indexPath.row]
        borderingCountriesVC.borderingCountries = getAllborderingCountries(country: country)
        
        navigationController?.pushViewController(borderingCountriesVC, animated: true)
    }
    
    func setupTableView(){
        tableView.backgroundColor = .white
        tableView.register(CountryCell.self, forCellReuseIdentifier: cellID)
    }
    
    func getCountries () {
        ApiService.shared.fetchCountries { [self](countries, borderingCountriesDict) in
            self.countries = countries
            self.borderingCountriesDict = borderingCountriesDict
            self.tableView.reloadData()
        }
    }

    
    func makeNavBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        navigationController?.navigationBar.barStyle = .blackTranslucent
        self.title = "Countries"
        
        let sortContriesByNameButton =  UIBarButtonItem(title: "Sort by Name", style: .plain, target: self, action: #selector(sortContriesByName))
        sortContriesByNameButton.tintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        navigationItem.leftBarButtonItem = sortContriesByNameButton
        
        let sortContriesByAreaButton = UIBarButtonItem(title: "Sort by Area", style: .plain, target: self, action: #selector(sortContriesByArea))
        sortContriesByAreaButton.tintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        navigationItem.rightBarButtonItem = sortContriesByAreaButton
        
    }
    
    
    var sortContriesUpDownByName = true
    var sortContriesUpDownByArea = true
    
    @objc func sortContriesByName(){
        if sortContriesUpDownByName {
            countries.sort { $0.englishName > $1.englishName }
        } else {
            countries.sort {$0.englishName < $1.englishName}
        }
        
        tableView.reloadData()
        sortContriesUpDownByName.toggle()
    }
    
    @objc func sortContriesByArea(){
        if sortContriesUpDownByArea {
            countries.sort { $0.area > $1.area }
        } else {
            countries.sort { $0.area < $1.area }
        }
        
        tableView.reloadData()
        sortContriesUpDownByArea.toggle()
    }
    
    func getAllborderingCountries(country: Country) -> [Country]{
        
        var borderCountry = [Country]()
        
        for borderedCountry in country.borderingCountries {
            if let country = borderingCountriesDict[borderedCountry] {
                borderCountry.append(country)
            }
        }
    
        return borderCountry
    }
}
