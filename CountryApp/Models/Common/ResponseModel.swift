//
//  ResponseModel.swift
//  CountryApp
//
//  Created by Fagan Aslanli on 05.01.23.
//

struct ResponseModel<T: Decodable>: Decodable {
    var status: Int?
    var message: String?
    var description: String?
    var data: T?
}
