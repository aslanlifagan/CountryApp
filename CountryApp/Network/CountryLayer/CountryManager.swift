//
//  CountryManager.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import Alamofire

enum CountryManager: NetworkManager {
    
    case getCountryList
    
    var mainPath: String {
        return "all/"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getCountryList: return ""
        }
    }
    
    var header: [String: String] {
        return [HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue]
    }
    
    var parameters: Parameters? {
        switch self {
        default: return nil
        }
    }
    
    var body: String? {
        switch self {
        default: return nil
        }
    }
}
