//
//  RoomModel.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import Foundation
typealias Rooms = [Room]

// MARK: - Employee
struct Room: Codable {
    let isOccupied: Bool
    let maxOccupancy: Int
    let id: String


    enum CodingKeys: String, CodingKey {
        case id
        case isOccupied
        case maxOccupancy
     }
}
