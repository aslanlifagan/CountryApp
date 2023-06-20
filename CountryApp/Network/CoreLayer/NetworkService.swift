//
//  NetworkService.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

import UIKit
import Alamofire
import Reachability

class APIService {
    var reach = try! Reachability()
    
    typealias ResponseResult<T: Decodable> = (Swift.Result<T, ErrorService>) -> Void
    
    private var Manager : Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 90
        return Alamofire.Session(configuration: configuration)
    }()
    
    func request<T: Decodable>(to route: NetworkManager, responseType: ResponseType = .structurized, type: RequestType = .raw, isOnlyData: Bool = false, completion: @escaping (Swift.Result<T?, ErrorService>) -> Void) {
        reach = try! Reachability()
        if reach.connection == .unavailable {
            completion(.failure(ErrorService(code: .noInternet)))
            return
        }
        if type == .raw {
            Manager.request(route).validate().responseJSON(emptyResponseCodes: [200, 201, 202, 204], completionHandler: { response in
                let decoder = JSONDecoder()
                let baseResponse = decoder.decodeResponse(T.self, response: response, responseType: responseType, isOnlyData: isOnlyData, requestPath: route.baseURL + route.mainPath + route.path)
                completion(baseResponse)
            })
            return
        }
        let HEADER = route.header
//        let token = AuthService.getToken()
//        if !token.isEmpty && HEADER[HTTPHeaderField.authentication.rawValue]?.isEmpty ?? true {
//            HEADER[HTTPHeaderField.authentication.rawValue] = "\(token)"
//        }
        // Multipart type
        sendMultiPartRequest(url: route.baseURL + route.mainPath + route.path, params: route.parameters, headersDict: HEADER, completion: completion)
    }
    
    //MARK: - Public Functions
    public func serializeJson(_ body: Any) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        return String(data: jsonData ?? Data(), encoding: .utf8) ?? ""
    }
    
    //MARK: - Private Functions
    private func sendMultiPartRequest<T: Decodable>(
        url: String,
        params: [String: Any]?,
        headersDict: [String: String]?,
        responseType: ResponseType = .simple,
        completion: @escaping (Swift.Result<T?, ErrorService>) -> Void
    ) {
        
        Manager.upload(multipartFormData: { multipartFormData in
            if let params = params {
                for param in params {
                    if param.value is String ||
                        param.value is Int ||
                        param.value is Double {
                        multipartFormData.append("\(param.value)".data(using: String.Encoding.utf8)!, withName: param.key as String)
                    }
                    
                    if param.value is UIImage {
                        let image = param.value as? UIImage
                        multipartFormData.append(image?.jpeg(.medium) ?? Data(), withName: param.key as String, fileName: "image.jpg", mimeType: "image/jpg")
                    }
                    if let stringArr = param.value as? [String] {
                        for item in stringArr {
                            if let stringData = item.data(using: .utf8) {
                                multipartFormData.append(stringData, withName: "\(param.key)[]")
                            }
                        }
                    }
//                    if let fileUploadModels = param.value as? [FileUploadModel] {
//                        for (index, model) in fileUploadModels.enumerated() {
//                            if let image = model.image {
//                                multipartFormData.append(image.jpeg(.medium) ?? Data(), withName: param.key as String, fileName: "image_\(index).jpg", mimeType: "image/jpg")
//                            } else if let path = model.path {
//                                let fileData = (try? Data(contentsOf: path)) ?? Data()
//                                multipartFormData.append(fileData, withName: param.key as String, fileName: "file.\(path.pathExtension)", mimeType: path.mimeType())
//                            }
//                        }
//                    }
//                    if let filePath = param.value as? URL {
//                        let fileData = (try? Data(contentsOf: filePath)) ?? Data()
//                        multipartFormData.append(fileData, withName: param.key as String, fileName: filePath.lastPathComponent, mimeType: filePath.mimeType())
//                    }
                }
            }
        }, to: url, headers: HTTPHeaders(headersDict ?? [String: String]())).validate().responseJSON(emptyResponseCodes: [200, 201, 202, 204], completionHandler: { response in
            let decoder = JSONDecoder()
            let baseResponse = decoder.decodeResponse(T.self, response: response, responseType: responseType, requestPath: url)
            completion(baseResponse)
        })
    }
}


extension JSONDecoder {
    
    func decodeResponse<T: Decodable>(_ type: T.Type, response: AFDataResponse<Any>, responseType: ResponseType = .structurized, isOnlyData: Bool = false, requestPath: String) -> Swift.Result<T?, ErrorService> {
        switch response.result {
        case .failure(let error):
            print(#function, error.localizedDescription)
            
            if response.response?.statusCode == 401 { // unauthorized response
//                TokenService.showPassCode()
                return .failure(ErrorService(code: .unAuthorized))
            }
            if error._code == NSURLErrorTimedOut {
                return .failure(ErrorService(code: .timeOut))
            }
            if error._code == NSURLErrorNotConnectedToInternet {
                return .failure(ErrorService(code: .noInternet))
            }
            do {
                if isOnlyData {
                    return .success(response.data as? T)
                }
                let error = try decode(ErrorService.self, from: response.data ?? Data())
                return .failure(error)
            }  catch _ {
                return .failure(ErrorService(code: .general))
            }
        case .success(_):
            guard let data = response.data
                else { return .success(nil) }

                nonConformingFloatDecodingStrategy = .throw
            
                do {
                    guard responseType == .structurized else {
                        let result = try decode(T.self, from: data)
                        return .success(result)
                    }
                    
                    let result = try decode(ResponseModel<T>.self, from: data)
                    guard result.status == 200 else {
                        if response.response?.statusCode == 401 {
                            return .failure(ErrorService(code: .unAuthorized))
                        }
                        return .failure(ErrorService(code: .general))
                    }
                    guard let data = result.data else { return .success(nil) }
                    
                    return .success(data)
                } catch let error {
                    print("error", error)
                    return .failure(ErrorService(code: .general))
                }
         }
        
    }
}

enum ResponseType {
    case simple
    case structurized
}
enum RequestType: String {
    case raw, multipart
}
