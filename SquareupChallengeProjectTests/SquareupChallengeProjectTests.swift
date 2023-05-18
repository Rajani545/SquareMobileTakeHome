//
//  SquareupChallengeProjectTests.swift
//  SquareupChallengeProjectTests
//
//  Created by admin on 5/15/23.
//

import XCTest
@testable import SquareupChallengeProject

final class SquareupChallengeProjectTests: XCTestCase {

    let viewModel = EmployeeViewModel()
    
    /// Test cases for get all employees
    ///
    func testForReturnEmployeeWhenEmployeeApi() {
        let expectation = self.expectation(description: "Returns_ListOfEmployeesResponse")
        
        viewModel.getEmployees(baseUrl: viewModel.employeesURL) { isSuccess, errorMessage in
            
            let employees = self.viewModel.employees
            
            XCTAssertNotNil(employees)
            XCTAssertNil(errorMessage)
            XCTAssertNotNil(employees?.count)
            
            expectation.fulfill()
        }
        
        waitingLoadingTime()
    }
    /// Test cases for get Malformed employees
    ///
    func testForMalformedEmployeeWhenUrlHaveMalformedEmployeesList() {
        let expectation = self.expectation(description: "Returns_ListOfMalformedEmployeesResponse")
        
        viewModel.getEmployees(baseUrl: viewModel.malformedEmployeesURL) { isSuccess, errorMessage in
            
            let employees = self.viewModel.employees
            
            XCTAssertNotNil(errorMessage)
            XCTAssertNil(employees)
            XCTAssertNil(employees?.count)
            XCTAssertEqual(errorMessage, "You have Malformed Empployee")
            
            expectation.fulfill()
        }
        
        waitingLoadingTime()
    }
    
    /// This test case fill fail when you changed the employe data in backend
    ///
    func testForReturnEmptyEMployeWhenYouNoEmployeesInList() {
        let expectation = self.expectation(description: "Returns_EmptyEmployeesResponse")
        
        viewModel.getEmployees(baseUrl: viewModel.emptyEmployeURL) { isSuccess, errorMessage in
            
            let employees = self.viewModel.employees
            
            XCTAssertNotNil(employees)
            XCTAssertNil(errorMessage)
            XCTAssertEqual(employees?.count, 0)
            
            expectation.fulfill()
        }
        
        waitingLoadingTime()
    }

    /// Test cases for get Empty employees
    ///
    func testForIsEmptyEmployeeReturnFalseWhenYouHaveEmployees() {
        let expectation = self.expectation(description: "Returns_ListOfEmployeesResponse")
        viewModel.getEmployees(baseUrl: viewModel.employeesURL) { isSuccess, errorMessage in
            expectation.fulfill()
        }
        waitingLoadingTime()
        
        XCTAssertEqual(viewModel.isEmptyEmployees, false)
    }
    
    func testForIsEmptyEmployeeReturnTrueWhenYouHaveEmployees() {
        let expectation = self.expectation(description: "Returns_ListOfEmployeesResponse")
        viewModel.getEmployees(baseUrl: viewModel.emptyEmployeURL) { isSuccess, errorMessage in
            expectation.fulfill()
        }
        waitingLoadingTime()
        
        XCTAssertEqual(viewModel.isEmptyEmployees, true)
    }
    
    func testForSortedEmployeesBasedOnName() {
        let expectation = self.expectation(description: "Returns_ListOfEmployeesResponse")
        viewModel.getEmployees(baseUrl: viewModel.employeesURL) { isSuccess, errorMessage in
            expectation.fulfill()
        }
        waitingLoadingTime()
        
        viewModel.sortedEmployeeBasedOnNames()
        
        let firstEmployee = viewModel.employees?.first
        
        XCTAssertEqual(firstEmployee?.fullName, "Alaina Daly")
        XCTAssertEqual(firstEmployee?.phoneNumber, "5555442937")
        XCTAssertEqual(firstEmployee?.emailAddress, "adaly.demo@squareup.com")
        XCTAssertEqual(firstEmployee?.team, "Retail")
        XCTAssertEqual(firstEmployee?.employeeType.description, "Full Time")
        
    }
    
    //MARK:- Private methods
    
    private func waitingLoadingTime() {
        waitForExpectations(timeout: 5, handler: nil) //MARK:- For api call waiting time
    }
}
