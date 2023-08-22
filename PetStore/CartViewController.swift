//
//  CartViewController.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import UIKit
import Combine
import SnapKit

final class CartViewController: UIViewController {
    
    // MARK: - Properties
    lazy var cartTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var coordinator: Coordinator
    private var viewModel: CartViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Base Functions
    init(coordinator: Coordinator,
         viewModel: CartViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        states()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.readData()
        cartTableView.reloadData()
    }
    
    // MARK: - Custom Functions
    private func states() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (state) in
                switch state {
                case .empty:
                    print("Empty")
                case .error(error: let error):
                    print(error)
                case .loading:
                    self?.view.activityStartAnimating()
                case .finished:
                    self?.view.activityStopAnimating()
                    self?.cartTableView.reloadData()
                case .ready:
                    self?.viewModel.readData()
                    self?.prepareTableView()
                    self?.view.backgroundColor = .white
                case .success:
                    self?.toastMessage("Pet has been ordered successfully")
                    self?.viewModel.readData()
                    self?.cartTableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
    private func prepareTableView() {
        view.addSubview(cartTableView)
       
        cartTableView.register(CartTableViewCell.self,
                               forCellReuseIdentifier: String(describing: CartTableViewCell.self))
        cartTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        cartTableView.dataSource = self
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cartPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  String(describing: CartTableViewCell.self),
                                                       for: indexPath) as? CartTableViewCell
        else { return UITableViewCell() }
        
        cell.setUpContent(item: CarTableViewCellItem(title: viewModel.cartPets[indexPath.row].name,
                                                            image: viewModel.cartPets[indexPath.row].photoUrls?.last,
                                                            indexPath: indexPath.row,
                                                            delegate: self))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension CartViewController: CartTableViewCellOutputProtocol {
    func onTappedButton(indexPath: Int?) {
        guard let index = indexPath else { return }
        viewModel.petID = viewModel.cartPets[index].id
        viewModel.placeOrder()
    }
}
    
