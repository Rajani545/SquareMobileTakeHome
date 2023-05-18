//
//  ViewController.swift
//  SquareupChallengeProject
//
//  Created by admin on 5/15/23.
//

import UIKit

class EmployeViewController: UIViewController {
    
    @IBOutlet weak var employeeCollectionView: UICollectionView!
    @IBOutlet weak var errorPlaceholderLbl: UILabel!
    @IBOutlet weak var errorPlaceholderView: UIView!
    
    var viewModel = EmployeeViewModel()
    var refresher:UIRefreshControl!
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIAndData()
    }
    
    //MARK:- Private Methods
    
    private func updateUIAndData() {
        addLoaderToView()
        fetchEmployees()
        addRefreshThePage()
    }
    
    private func addLoaderToView() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.tintColor = UIColor(red: 233.0/255.0, green: 154/255, blue: 154/255, alpha: 1.0)
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func fetchEmployees() {
        viewModel.getEmployees(baseUrl: viewModel.employeesURL) { isSuccess, message in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.stopRefresher()
                if message != nil {
                    self.errorPlaceholderLbl.text = message
                    self.updateTheViewBasedOnResponse()
                } else {
                    self.employeeCollectionView?.reloadData()
                    self.updateUIOnEmptyEmployee()
                }
            }
        }
    }
    
    private func updateTheViewBasedOnResponse() {
        errorPlaceholderView.isHidden = false
        employeeCollectionView?.isHidden = !errorPlaceholderView.isHidden
    }
    
    private func updateUIOnEmptyEmployee() {
        errorPlaceholderView.isHidden = !viewModel.isEmptyEmployees
        employeeCollectionView?.isHidden = !errorPlaceholderView.isHidden
    }
    
    private func addRefreshThePage() {
        refresher = UIRefreshControl()
        employeeCollectionView.alwaysBounceVertical = true
        refresher.tintColor = UIColor.red
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        employeeCollectionView.addSubview(refresher)
    }
    
    @objc private func loadData() {
        fetchEmployees()
    }
    
    private func stopRefresher() {
        self.refresher.endRefreshing()
    }
}

extension EmployeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.employees?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployeeCell.identifier, for: indexPath as IndexPath) as! EmployeeCell
        cell.configureCell(with: viewModel.employees?[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:230)
    }
}
