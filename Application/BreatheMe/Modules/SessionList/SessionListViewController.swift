//
//  SessionListViewController.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 14.10.2021.
//

import UIKit

class SessionListViewController: UIViewController {

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

        tableView.register(SessionListCell.self, forCellReuseIdentifier: SessionListCell.Constants.reuseIdentifier)
        tableView.register(SessionListTableHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: SessionListTableHeaderView.Constants.reuseIdentifier)

        return tableView
    }()

    // MARK: - Output

    var didSelectSession: ((Session) -> Void)?

    // MARK: - Properties

    private var viewModel: SessionListControllerViewModel!
    private lazy var mailComposerPresenter: MailComposerPresenter = MailComposerPresenter()

    // MARK: - Initialization

    class func instantiate(viewModel: SessionListControllerViewModel) -> SessionListViewController {
        let controller = SessionListViewController()
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
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)

        navigationItem.title = "Your breathe sessions"
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
        viewModel.didUpdateData = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.didError = { [weak self] error in
            guard let self = self else { return }

            AlertHelper.showErrorAlertWith(message: error.localizedDescription, target: self)
        }

        viewModel.didExportSessions = { [weak self] fileUrl in
            guard let self = self else { return }
            self.mailComposerPresenter.present(on: self, attachFile: fileUrl)
        }
    }

    // MARK: - UI Callbacks

    @objc private func shareAction() {
        if !mailComposerPresenter.canSendEmail {
            AlertHelper.showErrorAlertWith(message: "Sorry, your device doesn't support email sending", target: self)
        }
        viewModel.prepareSessionsForShare()
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SessionListCell.Constants.reuseIdentifier, for: indexPath) as! SessionListCell
        if let model = viewModel.sessionViewModelFor(section: indexPath.section, position: indexPath.row) {
            cell.configureWith(model: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SessionListTableHeaderView.Constants.reuseIdentifier) as! SessionListTableHeaderView
        view.configureWith(date: viewModel.dateForSection(section))
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let session = viewModel.sessionFor(section: indexPath.section, position: indexPath.row) {
            didSelectSession?(session)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.isReadyForLoading, scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < 300.0  {
            viewModel.loadData()
        }
    }
}
