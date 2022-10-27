//
//  EmployeeModel.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import Foundation

typealias Employees = [Employee]

// MARK: - Employee
struct Employee: Codable {
    let firstName: String
    let lastName: String
    let avatar: String
    let jobtitle: String
    let favouriteColor: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case avatar //
        case jobtitle //= "jobtitle"
        case favouriteColor
        case email
    }
}
