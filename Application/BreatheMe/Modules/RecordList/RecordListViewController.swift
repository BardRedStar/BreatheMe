//
//  RecordListViewController.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 18.10.2021.
//

import UIKit

class RecordListViewController: UIViewController {

    // MARK: - UI Controls
    private lazy var backgroundImageView: BlurredImageView = {
        let view = BlurredImageView()
        view.image = UIImage(named: "background")
        view.blurAlpha = 0.75
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(RecordListCell.self, forCellReuseIdentifier: RecordListCell.Constants.reuseIdentifier)

        return tableView
    }()

    // MARK: - Properties

    private var viewModel: RecordListControllerViewModel!

    // MARK: - Initialization

    class func instantiate(viewModel: RecordListControllerViewModel) -> RecordListViewController {
        let controller = RecordListViewController()
        controller.viewModel = viewModel
        return controller
    }

    // MARK: - UI Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        configureUI()
        bindViewModelActions()

        viewModel.loadData()
    }

    // MARK: - UI Methods

    private func configureNavBar() {
        navigationItem.title = "Detailed Statistics"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }

    private func configureUI() {

        view.addSubview(backgroundImageView)
        view.addSubview(tableView)

        tableView.backgroundColor = .clear

        tableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    private func bindViewModelActions() {
        viewModel.didDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.didError = { [weak self] error in
            guard let self = self else { return }

            AlertHelper.showErrorAlertWith(message: error.localizedDescription, target: self)
        }
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension RecordListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRecords
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordListCell.Constants.reuseIdentifier, for: indexPath) as! RecordListCell
        if let model = viewModel.recordViewModelFor(position: indexPath.row) {
            cell.configureWith(model: model)
        }
        return cell
    }
}
