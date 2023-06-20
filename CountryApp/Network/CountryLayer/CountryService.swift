//
//  CountryService.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit

class CountryService: APIService {
    
    static let instance = CountryService()

    func getCountryList(completion : @escaping ResponseResult<Country?>) {
        request(to: CountryManager.getCountryList,responseType: .simple, completion: completion)
    }
}
