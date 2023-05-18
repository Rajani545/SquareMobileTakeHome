//
//  EmployeModel.swift
//  SquareupChallengeProject
//
//  Created by admin on 5/15/23.
//

import Foundation

struct Employees: Codable {
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let uuid, fullName, phoneNumber, emailAddress: String
    let biography: String
    let photoURLSmall, photoURLLarge: String
    let team: String
    let employeeType: EmployeeType

    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}

enum EmployeeType: String, Codable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    
    var description : String {
        switch self {
        case .contractor: return "Contractor"
        case .fullTime: return "Full Time"
        case .partTime: return "Part Time"
        }
    }
}
