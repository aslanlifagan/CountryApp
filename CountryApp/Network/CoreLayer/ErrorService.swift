//
//  ErrorService.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import Foundation

struct ErrorService: Error, Decodable {
    let errors: [ErrorModel]?
    var errorCode: ErrorCode {
        return ErrorCode.getCode(by: errors?.first?.errorParam)
    }
    var main: StatusCode {
        let error = errors?.first
        if error?.error == "general" {
            return .general
        }
        return StatusCode.getCode(by: errors?.first?.error)
    }
    
    init(code: StatusCode?) {
        errors = [ErrorModel(error: code?.getCode(), errorParam: code?.getMessage())]
    }
}
struct ErrorModel: Codable {
    let error, errorParam: String?
    
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorParam = "error_param"
    }
}
enum StatusCode: Equatable {
    case general, required, noInternet, timeOut, unAuthorized, inCorrectUrl, invalid, notFound
    
    func getCode() -> String {
        switch self {
        case .required: return "required"
        case .noInternet: return "noInternet"
        case .timeOut: return "timeOut"
        case .unAuthorized: return "unAuthorized"
        case .inCorrectUrl: return "inCorrectUrl"
        case .invalid: return "invalid"
        case .notFound: return "notFound"
        default: return "general"
        }
    }
    func getMessage() -> String {
        switch self {
        case .required: return "Field is required"
        case .general: return "General error"
        case .noInternet: return "No internet"
        case .timeOut: return "Time out"
        case .unAuthorized: return ""
        case .inCorrectUrl: return "Incorrect url"
        case .invalid: return "Invalid Value"
        case .notFound: return "Not found"
        }
    }
    static func getCode(by string: String?) -> StatusCode {
        switch string {
        case "required": return .required
        case "noInternet": return .noInternet
        case "timeOut": return .timeOut
        case "unAuthorized": return .unAuthorized
        case "inCorrectUrl": return .inCorrectUrl
        case "invalid": return .invalid
        case "notFound": return .notFound
        default: return .general
        }
    }
    
}
enum ErrorCode: String {
    case unProcessible, smsCode, passCode, pin, authenticatorCode
    
    static func getCode(by string: String?) -> ErrorCode {
        switch string {
        case "smsCode": return .smsCode
        case "passCode": return .passCode
        case "pin": return .pin
        case "authenticatorCode": return .authenticatorCode
        default: return .unProcessible
        }
    }
}

