//
//  MainViewController.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel
    private lazy var loadingManager = LoadingViewManager(delegate: self)
    
    private var dataSource: UITableViewDiffableDataSource<CurrencySections, CurrencyCell>!
    
    private var selectedCurrency: String = "EUR" {
        didSet {
            navigationItem.title = selectedCurrency
        }
    }
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .baseLight
        $0.delegate = self
        $0.separatorStyle = .singleLine
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderTopPadding = 0
        $0.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.cellIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        viewModel.delegate = self
        setupUI()
        configureDataSource()
        
        viewModel.fetchData()

    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .baseLight
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "EUR"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        setupLeftDateLabel()
        setupRightBarButtons()
        configureTableView()
    }
    
    private func setupRightBarButtons() {
        let dollarButton = UIBarButtonItem(
            image: UIImage(systemName: "dollarsign"),
            style: .plain,
            target: self,
            action: #selector(dollarButtonTapped)
        )
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItems = [addButton, dollarButton]
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        
        tableView.backgroundColor = UIColor.baseLight
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<CurrencySections, CurrencyCell>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.cellIdentifier, for: indexPath) as? CurrencyTableViewCell
            cell?.configure(with: item)
            return cell
        }
    }
    
    private func updateUI(cells: [CurrencyCell]) {
        var snapshot = NSDiffableDataSourceSnapshot<CurrencySections, CurrencyCell>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(cells, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    
    @objc private func addButtonTapped() {
        let selectedCurrencies = viewModel.getSelectedCurrencies()
        let currencySelectionVC = CurrencySelectionViewController(
                availableCurrencies: Countries.currencyCodes,
                selectedCurrencies: selectedCurrencies
            )
            currencySelectionVC.delegate = viewModel
            currencySelectionVC.modalPresentationStyle = .overFullScreen
            currencySelectionVC.modalTransitionStyle = .crossDissolve
            present(currencySelectionVC, animated: true)
        }
    
    @objc private func dollarButtonTapped() {
        PopUpModalViewController.present(initialView: self, delegate: viewModel)
      }
    

    private func setupLeftDateLabel() {
            let dateLabel = UILabel()
            dateLabel.text = getFormattedDate()
        dateLabel.font = SFPro.medium(size: 12)
            dateLabel.textColor = .darkGray

            let dateBarButton = UIBarButtonItem(customView: dateLabel)
            navigationItem.leftBarButtonItem = dateBarButton
        }

        private func getFormattedDate() -> String {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "uk_UA")
            formatter.dateFormat = "EEEE d MMM"
            return formatter.string(from: Date()).uppercased()
        }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        adapted(dimensionSize: 60, to: .height)
    }
}

extension MainViewController: MainViewModelDelegate {
    
    func didUpdateCurrency(value: String) {
        selectedCurrency = value
    }
    
    func didUpdateData(cells: [CurrencyCell]) {
        loadingManager.removeLoading()
        updateUI(cells: cells)
    }
    
    func didStartFetch() {
        loadingManager.showLoading(in: self.view)
    }
    
    func didFetchError(message: String) {
        loadingManager.showError(in: self.view, message: message)
    }
}

extension MainViewController: LoadingViewDelegate {
    
    func didTapTryAgain() {
        viewModel.fetchData()
    }
    
}
