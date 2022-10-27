//
//  RoomsViewModel.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import Foundation

class RoomsViewModel: NSObject {
    private var roomService: RoomsServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var rooms = Rooms()
    
    var roomCellViewModels = [RoomCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(roomService: RoomsServiceProtocol = RoomsService()) {
        self.roomService = roomService
    }
    
    func getRooms() {
        roomService.getRooms{ success, model, error in
            if success, let rooms = model {
                self.fetchData(rooms: rooms)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(rooms: Rooms) {
        self.rooms = rooms // Cache
        var vms = [RoomCellViewModel]()
        for room in rooms {
            vms.append(createCellModel(room: room))
        }
        roomCellViewModels = vms
    }
    
    func createCellModel(room: Room) -> RoomCellViewModel {
        let No = room.id
        let availability = room.isOccupied
        let occupancy = room.maxOccupancy
        
        return RoomCellViewModel(roomNo: No, availabilityStatus: availability, maxOccupancy: occupancy)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> RoomCellViewModel {
        return roomCellViewModels[indexPath.row]
    }
}
