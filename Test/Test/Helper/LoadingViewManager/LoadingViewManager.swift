//
//  LoadingViewManager.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

import UIKit
import SnapKit

protocol LoadingViewDelegate: AnyObject {
    func didTapTryAgain()
}


final class LoadingViewManager: NSObject {
    private var loadingView = LoadingView()
    private weak var delegate: LoadingViewDelegate?

    init(delegate: LoadingViewDelegate?) {
        self.delegate = delegate
    }

    func showLoading(in superView: UIView) {
        setupView(inSuperview: superView)
        loadingView.configureLoadingState()
    }

    func showError(in superView: UIView, message: String) {
        setupView(inSuperview: superView)
        loadingView.configureErrorState(withMessage: message)
    }

    private func setupView(inSuperview superView: UIView) {
        removeLoading()
        
        superView.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.setTryAgainTarget(target: self, action: #selector(didTapTryAgain))
    }

    @objc private func didTapTryAgain() {
        delegate?.didTapTryAgain()
    }

    func removeLoading() {
        loadingView.removeFromSuperview()
    }
}
