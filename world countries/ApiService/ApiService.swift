//
//  RESTApi.swift
//  world countries
//
//  Created by User on 02/09/2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class ApiService: NSObject {
    static let shared = ApiService()
    
    func fetchCountries(complition: @escaping ([Country], [String: Country]) -> ()){
       
        let restApiURL = "https://restcountries.eu/rest/v2/all"
        
        guard let url = URL(string: restApiURL) else {return}
        var countries = [Country]()
        var borderingCountriesDict = [String: Country]()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:dataResponse, options: [])
                
                guard let jsonArray = jsonResponse as? NSArray else {
                    print("error getting json array")
                    return
                }
                
                for jsonDict in jsonArray {
                    guard let jsonDict = jsonDict as? NSDictionary else {
                        print("error getting json dictionary")
                        return
                    }
                    
                    let country = Country(jsonDict: jsonDict)
                    countries.append(country)
                    borderingCountriesDict[country.alpha3Code] = country
                }
                
                DispatchQueue.main.async {
                    complition(countries, borderingCountriesDict)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }.resume()
    }
}
