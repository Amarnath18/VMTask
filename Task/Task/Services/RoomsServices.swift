//
//  RoomServices.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import Foundation

protocol RoomsServiceProtocol {
    func getRooms(completion: @escaping (_ success: Bool, _ results: Rooms?, _ error: String?) -> ())
}

class RoomsService: RoomsServiceProtocol {
    func getRooms(completion: @escaping (Bool, Rooms?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Rooms.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: GET Request failed")
            }
        }
    }
}
