//
//  CurrencyTableViewCell.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "currencyCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.selectionStyle = .none
        backgroundColor = .baseLight
    }
    
    private lazy var countryImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = SFPro.regular(size: 18)
        $0.textColor = .baseDark
    }
    
    private lazy var amountLabel = UILabel().then {
        $0.font = SFPro.bold(size: 18)
        $0.textColor = .baseDark
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        countryImage.layer.cornerRadius = countryImage.frame.width / 2
    }
    
    private func setupView() {
        self.contentView.addSubview(countryImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(amountLabel)
        
        countryImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(adapted(dimensionSize: 16, to: .height))
            make.width.height.equalTo(adapted(dimensionSize: 40, to: .height))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(countryImage.snp.trailing).offset(adapted(dimensionSize: 16, to: .height))
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(adapted(dimensionSize: 16, to: .height))
        }
    }
    
    func configure(with: CurrencyCell) {
        titleLabel.text = with.code.uppercased()
        amountLabel.text = with.amount
        countryImage.image = UIImage(named: with.code.lowercased())
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countryImage.image = nil
        titleLabel.text = nil
        amountLabel.text = nil
    }
}
