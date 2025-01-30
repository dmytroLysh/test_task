//
//  PreloaderViewController.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

import UIKit
import Then
import SnapKit

final class PreloaderViewController: UIViewController {
    
    private var viewModel: PreloaderViewModel
    
    private lazy var logoView = UIView().then {
        $0.backgroundColor = .accentPrimary
        $0.layer.cornerRadius = adapted(dimensionSize: 20, to: .height)
    }
    
    init(viewModel: PreloaderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .baseLight
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLogoView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.determineInitialScreen()
    }
    
    private func setupLogoView() {
        self.view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.width.height.equalTo(adapted(dimensionSize: 123, to: .height))
            make.center.equalToSuperview()
        }
    }
}
