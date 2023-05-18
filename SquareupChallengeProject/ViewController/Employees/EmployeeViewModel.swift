//
//  EmployeeViewModel.swift
//  SquareupChallengeProject
//
//  Created by rajani on 5/15/23.
//

import Foundation

class EmployeeViewModel {
    var employees: [Employee]?
    var responseEmployees: [Employee]?
    
    let employeesURL = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    let malformedEmployeesURL = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    let emptyEmployeURL = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
    
    
    func getEmployees(baseUrl:String, _ completion: @escaping(_ isSuccess: Bool, _ errorMessage: String?) -> Void) {
        guard let url: URL = URL(string: baseUrl) else {
            print("invalid login URL")
            return
        }
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
                guard let data = data else { return }
                
                if let err = err {
                    print("Failed", err)
                    completion(false, err.localizedDescription)
                } else {
                    do {
                        let result = try JSONDecoder().decode(Employees.self, from: data)
                        self.employees = result.employees
                        self.sortedEmployeeBasedOnNames()
                        completion(true, nil)
                        
                    } catch let error {
                        print(error)
                        completion(false, "Employee data is Malformed")
                    }
                }
              
            }.resume()
            
        }
    }
    
    var isEmptyEmployees: Bool {
        guard let employee = employees, (employee.count == 0) else { return false }
        return true
    }
    
    func sortedEmployeeBasedOnNames() {
        employees = employees?.sorted { $0.fullName.lowercased() < $1.fullName.lowercased() }
    }
}
