//
//  CountryVM.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import Foundation
class CountryVM {
    var countryList = Country()
    var successCallback: (()->())?
    var failureCallback: ((ErrorService)->())?
    
    func getAllCountriesList() {
        CountryService.instance.getCountryList { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let list):
                var sortedList  =  list?.sorted(by: { $0.area ?? 0.0 > $1.area ?? 0.0 })
                self.countryList = list ?? Country()
                self.successCallback?()
                break
            case .failure(let error):
                self.failureCallback?(error)
                break
            }
        }
    }
}
