//
//  EmployeesViewModel.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import Foundation

class EmployeesViewModel: NSObject {
    private var employeeService: EmployeesServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var employees = Employees()
    
    var employeeCellViewModels = [EmployeeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(employeeService: EmployeesServiceProtocol = EmployeesService()) {
        self.employeeService = employeeService
    }
    
    func getEmployees() {
        employeeService.getEmployees { success, model, error in
            if success, let employees = model {
                self.fetchData(employees: employees)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(employees: Employees) {
        self.employees = employees // Cache
        var vms = [EmployeeCellViewModel]()
        for employee in employees {
            vms.append(createCellModel(employee: employee))
        }
        employeeCellViewModels = vms
    }
    
    func createCellModel(employee: Employee) -> EmployeeCellViewModel {
        let Fname = employee.firstName
        let Lname = employee.lastName
        let title = employee.jobtitle
        let favColor = employee.favouriteColor
        let avatar = employee.avatar
        let mail = employee.email

        
        return EmployeeCellViewModel(FName: Fname, LName: Lname, email: mail, jobTitle: title, favColor: favColor, image: avatar)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> EmployeeCellViewModel {
        return employeeCellViewModels[indexPath.row]
    }
}
