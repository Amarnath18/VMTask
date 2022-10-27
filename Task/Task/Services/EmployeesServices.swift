//
//  EmployeeServices.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import Foundation

protocol EmployeesServiceProtocol {
    func getEmployees(completion: @escaping (_ success: Bool, _ results: Employees?, _ error: String?) -> ())
}

class EmployeesService: EmployeesServiceProtocol {
    func getEmployees(completion: @escaping (Bool, Employees?, String?) -> ()) {
        
       
        HttpRequestHelper().GET(url: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people", params: ["": ""], httpHeader: .application_json) { success, data in
 
            if success {
                do {
                    let model = try JSONDecoder().decode(Employees.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}
