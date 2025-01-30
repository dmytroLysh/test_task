//
//  LoadingView.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

import UIKit
import SnapKit

final class LoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private let labelLoading: UILabel = {
        let label = UILabel()
        label.text = "Loading"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        return label
    }()

    private let buttonTryAgain: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Try again", for: .normal)
        button.isHidden = true
        button.isUserInteractionEnabled = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .baseLight.withAlphaComponent(0.7)

        addSubview(activityIndicator)
        addSubview(labelLoading)
        addSubview(buttonTryAgain)

        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }

        labelLoading.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(activityIndicator.snp.bottom).offset(10)
        }

        buttonTryAgain.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelLoading.snp.bottom).offset(10)
        }
    }

    func configureLoadingState() {
        labelLoading.text = "Loading"
        buttonTryAgain.isHidden = true
        activityIndicator.startAnimating()
    }

    func configureErrorState(withMessage message: String) {
        labelLoading.text = message
        activityIndicator.stopAnimating()
        buttonTryAgain.isHidden = false
    }

    func setTryAgainTarget(target: Any?, action: Selector) {
        buttonTryAgain.addTarget(target, action: action, for: .touchUpInside)
    }

    var isTryAgainVisible: Bool {
        !buttonTryAgain.isHidden
    }

    var isLoadingActive: Bool {
        activityIndicator.isAnimating
    }
}


