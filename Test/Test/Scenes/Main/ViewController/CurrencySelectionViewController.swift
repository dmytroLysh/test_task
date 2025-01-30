import UIKit
import SnapKit

protocol CurrencySelectionDelegate: AnyObject {
    func didSelectCurrencies(_ selectedCurrencies: [String])
}

final class CurrencySelectionViewController: UIViewController {
    
    private let availableCurrencies: [String]
    private var selectedCurrencies: Set<String>
    weak var delegate: CurrencySelectionDelegate?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let containerView = UIView()
    private let doneButton = UIButton()
    
    init(availableCurrencies: [String], selectedCurrencies: [String]) {
        self.availableCurrencies = availableCurrencies
        self.selectedCurrencies = Set(selectedCurrencies)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        containerView.backgroundColor = .baseLight
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.systemBlue, for: .normal)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        
        view.addSubview(containerView)
        containerView.addSubview(tableView)
        containerView.addSubview(doneButton)
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        tableView.register(CurrencySelectionCell.self, forCellReuseIdentifier: CurrencySelectionCell.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(doneButton.snp.top).offset(-10)
        }
        
        doneButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func doneTapped() {
        delegate?.didSelectCurrencies(Array(selectedCurrencies))
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !containerView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension CurrencySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectionCell.cellIdentifier, for: indexPath) as? CurrencySelectionCell else {
            return UITableViewCell()
        }
        
        let currency = availableCurrencies[indexPath.row]
        let isSelected = selectedCurrencies.contains(currency)
        cell.configure(with: currency, isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = availableCurrencies[indexPath.row]
        
        if selectedCurrencies.contains(currency) {
            selectedCurrencies.remove(currency)
        } else {
            selectedCurrencies.insert(currency)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

final class CurrencySelectionCell: UITableViewCell {
    static let cellIdentifier = "CurrencySelectionCell"
    
    private let titleLabel = UILabel()
    private let checkmarkImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = .systemBlue
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkmarkImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        checkmarkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with currency: String, isSelected: Bool) {
        titleLabel.text = currency
        checkmarkImageView.isHidden = !isSelected
    }
}
