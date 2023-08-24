//
//  HomeViewController.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import UIKit
import Combine
import SnapKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    private lazy var petsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    private lazy var petStatus: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Avaliable", "Pending", "Sold", "Placed"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .yellow
        segmentedControl.backgroundColor = .lightText
        return segmentedControl
    }()
    
    private lazy var emptySuperView: UIView = {
       let view = UIView()
        return view
    }()
    
    private var coordinator: Coordinator
    private var viewModel: HomeViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Base Functions
    init(coordinator: Coordinator,
         viewModel: HomeViewModelProtocol) {
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
    }
    
    // MARK: - Custom Functions
    private func states() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (state) in
                switch state {
                case .empty:
                    self?.prepareEmptyView(isHidden: false)
                case .error(error: let error):
                    self?.alert(message: error)
                case .loading:
                    self?.view.activityStartAnimating()
                case .finished:
                    self?.view.activityStopAnimating()
                    self?.petsCollectionView.resetScrollPositionToTop()
                    self?.petsCollectionView.reloadData()
                    self?.prepareEmptyView(isHidden: true)
                case .ready:
                    self?.prepareSegmentedControl()
                    self?.prepareCollectionView()
                    self?.viewModel.serviceInitialize()
                    self?.view.backgroundColor = .white
                case .successAddedCart:
                    self?.toastMessage("Pet has been added to cart")
                    self?.petsCollectionView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        viewModel.petsData.removeAll()
        viewModel.petStatus = PetStatus.allCases[sender.selectedSegmentIndex]
        viewModel.serviceInitialize()
    }
    
    private func prepareEmptyView(isHidden: Bool) {
        let item = EmptyViewItems(title: "There is no data",
                                  image: "cart.badge.minus",
                                  buttonName: nil,
                                  buttonType: .noButton)
        
        let emptyView = EmptyView(item: item)
        
        self.emptySuperView.addSubview(emptyView)
        view.addSubview(emptySuperView)
        
        emptySuperView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalToSuperview().dividedBy(6)
        }
        
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(emptySuperView.snp.width)
            make.height.equalTo(emptySuperView.snp.height)
        }
        
        emptySuperView.isHidden = isHidden
    }
    
    private func prepareSegmentedControl() {
        view.addSubview(petStatus)
        petStatus.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        petStatus.addTarget(self, action: #selector(self.segmentedValueChanged(_:)),
                            for: .valueChanged)
        
    }
    
    private func prepareCollectionView() {
        view.addSubview(petsCollectionView)
        petsCollectionView.register(PetsCollectionViewCell.self,
                                    forCellWithReuseIdentifier: String(describing: PetsCollectionViewCell.self))
        petsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(petStatus.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        petsCollectionView.dataSource = self
        petsCollectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.petsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  String(describing: PetsCollectionViewCell.self), for: indexPath) as? PetsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setUpContent(item: PetsCollectionViewCellItems(title: viewModel.petsData[indexPath.row].name,
                                                            image: viewModel.petsData[indexPath.row].photoUrls?.first,
                                                            status: viewModel.petStatus,
                                                            indexPath: indexPath.row,
                                                            delegate: self))
        return cell
    }
}

// MARK: - PetsCollectionViewCellOutputProtocol
extension HomeViewController: PetsCollectionViewCellOutputProtocol {
    func onTappedButton(indexPath: Int?) {
        viewModel.saveCartsData(index: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colums: CGFloat = 2
        let collectioViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
        let adjustedWith = collectioViewWith - spaceBetweenCells
        let width: CGFloat = floor(adjustedWith / colums)
        let height: CGFloat = viewModel.petStatus == .available ? view.bounds.height / 4.5 : view.bounds.height / 6
        return CGSize(width: width, height: height)
    }
}
