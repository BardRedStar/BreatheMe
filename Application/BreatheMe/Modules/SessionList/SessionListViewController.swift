//
//  SessionListViewController.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import UIKit

class SessionListViewController: UIViewController {

    // MARK: - UI Controls

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(SessionListCell.self, forCellReuseIdentifier: SessionListCell.Constants.reuseIdentifier)
        tableView.register(<#T##aClass: AnyClass?##AnyClass?#>, forHeaderFooterViewReuseIdentifier: <#T##String#>)

        return tableView
    }()

    // MARK: - Properties

    private var viewModel: SessionListControllerViewModel!

    // MARK: - Initialization

    class func instantiate(viewModel: SessionListControllerViewModel) -> SessionListViewController {
        let controller = SessionListViewController()
        controller.viewModel = viewModel
        return controller
    }

    // MARK: - UI Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModelActions()
    }

    // MARK: - UI Methods

    private func configureUI() {
        tableView.backgroundColor = .clear
        view.backgroundColor = .clear

        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 0, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 0, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 0, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 0, constant: 0),
        ])
    }

    private func bindViewModelActions() {
        viewModel.didDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SessionListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfSessionsFor(section: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SessionListCell.Constants.reuseIdentifier, for: indexPath) as! SessionListCell
        cell.configureWith(model: viewModel.sessionViewModelAt(position: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SessionListTableHeaderView.Constants.reuseIdentifier) as! SessionListTableHeaderView
        view.configureWith(date: viewModel.dateForSection(section))
    }
}
