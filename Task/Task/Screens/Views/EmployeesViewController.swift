//
//  EmployeesViewController.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var roomsBtn: UIButton!

    @IBOutlet var tableView: UITableView!
    lazy var employeeViewModel = {
        EmployeesViewModel()
    }()
    lazy var roomViewModel = {
        RoomsViewModel()
    }()
    var selectedBtn = 1
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var navView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       startLoading()
        
        initView()
        initViewModel()
        navView.dropShadow()
        footerView.dropShadow()
        roomsBtn.tintColor = UIColor.gray
        contactBtn.tintColor = UIColor.red

    }

    func initView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView.register(EmployeeCell.nib, forCellReuseIdentifier: EmployeeCell.identifier)
        tableView.register(RoomCell.nib, forCellReuseIdentifier: RoomCell.identifier)
    }

    func initViewModel() {
        employeeViewModel.getEmployees()
//       stopLoading()
        employeeViewModel.reloadTableView = { [weak self] in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopLoading()
            }
           
        }
    }
    
    @IBAction func contactsBtn(_ sender:UIButton){
        selectedBtn = 1
        startLoading()
        roomsBtn.tintColor = UIColor.gray
        contactBtn.tintColor = UIColor.red
        employeeViewModel.getEmployees()
        employeeViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopLoading()
            }
        }
    }
    
    @IBAction func roomsBtn(_ sender:UIButton){
        selectedBtn = 2
        startLoading()
        contactBtn.tintColor = UIColor.gray
        roomsBtn.tintColor = UIColor.red
        roomViewModel.getRooms()
        roomViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopLoading()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension EmployeesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedBtn == 1{
            return employeeViewModel.employeeCellViewModels.count
        }else{
            return roomViewModel.roomCellViewModels.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedBtn == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as? EmployeeCell else { fatalError("xib does not exists") }
            let cellVM = employeeViewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomCell.identifier, for: indexPath) as? RoomCell else { fatalError("xib does not exists") }
            let cellVM = roomViewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedBtn == 1{
            let cellVM = employeeViewModel.getCellViewModel(at: indexPath)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailViewController")as! EmployeeDetailViewController
            vc.employeeDetails = cellVM
            self.present(vc, animated: true)
        }
    }
}
