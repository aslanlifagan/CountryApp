//
//  NetworkManager.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import Foundation
import Alamofire

protocol NetworkManager: URLRequestConvertible {
    var mainPath: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var parameters: Parameters? { get }
    var body: String? { get }
}
struct MainUrlConfiguration {
    static let baseUrl = APIDomain.prod.rawValue
    static var photoBaseUrl = "\(MainUrlConfiguration.baseUrl)/.." // its equal to main base url but with one go back action
}


extension NetworkManager {
    
    var baseURL: String {
        return MainUrlConfiguration.baseUrl
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlPath = path.contains("https") ? path: baseURL + mainPath + path
        guard let url = URL(string: urlPath) else { throw ErrorService(code: .inCorrectUrl) }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 90)
            
        // HTTP Method
        request.httpMethod = method.rawValue
        
        //Headers
        let sendHeader = header
        
//        if !AuthService.getToken().isEmpty && sendHeader[HTTPHeaderField.authentication.rawValue]?.isEmpty ?? true {
//            sendHeader[HTTPHeaderField.authentication.rawValue] = AuthService.getToken()
//        }
//        sendHeader[HTTPHeaderField.contentLanguage.rawValue] = Localize.currentLanguage()
//        sendHeader[HTTPHeaderField.xAppMobilerequest.rawValue] = "1" -- removed temporary
        
        request.allHTTPHeaderFields = sendHeader
        
        //Body
        request.httpBody = body?.data(using: .utf8, allowLossyConversion: false)
        
        // Parameters
        if let parameters = parameters {
            do{
                request = try URLEncoding.default.encode(request, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return request
    }
}

enum APIDomain: String {
    case prod = "https://restcountries.com/v3.1/"
}

enum HTTPHeaderField: String {
    case authentication = "token"
    case contentLanguage = "Accept-language"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case deviceToken = "Device-Token"
}


enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}
