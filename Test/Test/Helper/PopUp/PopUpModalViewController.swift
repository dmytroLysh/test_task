//
//  PopUpModalViewController.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import UIKit
import SnapKit

protocol PopUpModalDelegate: AnyObject {
    func didTapCancel()
    func didTapAccept(selectedValue: String?)
}

final class PopUpModalViewController: UIViewController {

    
     weak var delegate: PopUpModalDelegate?
    
    private lazy var filterPicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var canvas: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()

    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(didTapOK), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Set Currency"
        label.textColor = .baseDark
        label.font = SFPro.medium(size: 20)
        return label
    }()
    
    public var modalTitle: String? {
        didSet {
            titleLabel.text = modalTitle
        }
    }

    
    public init(delegate: PopUpModalDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        filterPicker.delegate = self
        filterPicker.dataSource = self
        setupViews()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
    }

    
    public static func present(initialView: UIViewController, delegate: PopUpModalDelegate) -> PopUpModalViewController {
        let view = PopUpModalViewController(delegate: delegate)
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .coverVertical
        initialView.present(view, animated: true)
        return view
    }
    
    @objc private func didTapCancel() {
        delegate?.didTapCancel()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapOK() {
        let selectedValue = Countries.currencyCodes[filterPicker.selectedRow(inComponent: 0)].uppercased()
        delegate?.didTapAccept(selectedValue: selectedValue)
        dismiss(animated: true, completion: nil)
    }

    
    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.addSubview(canvas)
        
        canvas.addSubview(cancelButton)
        canvas.addSubview(applyButton)
        canvas.addSubview(titleLabel)
        canvas.addSubview(filterPicker)
        
        canvas.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.bounds.height * 0.35)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.size.equalTo(44)
        }
        
        applyButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.size.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.centerX.equalToSuperview()
        }
        
        filterPicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}


extension PopUpModalViewController: UIPickerViewDelegate {}

extension PopUpModalViewController: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Countries.currencyCodes.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Countries.currencyCodes[row].uppercased()
    }
}
