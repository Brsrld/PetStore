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
    //    private lazy var petsCollectionView: UICollectionView = {
    //        let layout = UICollectionViewFlowLayout()
    //        layout.scrollDirection = .vertical
    //        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    //        collectionView.translatesAutoresizingMaskIntoConstraints = false
    //        collectionView.backgroundColor = .clear
    //        collectionView.register(
    //            PetsCollectionViewCell.self,
    //            forCellWithReuseIdentifier: String(describing: PetsCollectionViewCell.self)
    //        )
    //        return collectionView
    //    }()
    
    var petsCollectionView:UICollectionView?
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
                    self?.petsCollectionView?.reloadData()
                case .ready:
                    //self?.setUpConstraint()
                    self?.setUpDelegates()
                    self?.viewModel.serviceInitialize()
                    self?.view.backgroundColor = .white
                }
            }.store(in: &cancellables)
    }
    
    private func setUpDelegates() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        petsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        petsCollectionView?.register(PetsCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        petsCollectionView?.backgroundColor = UIColor.white
        
        view.addSubview(petsCollectionView ?? UICollectionView())
        petsCollectionView?.delegate = self
        petsCollectionView?.dataSource = self
        petsCollectionView?.backgroundColor = .green
    }
    
    private func setUpConstraint() {
        view.addSubview(petsCollectionView!)
        petsCollectionView?.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.petsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PetsCollectionViewCell else { return UICollectionViewCell() }
        
        guard let title =   viewModel.petsData[indexPath.row].name,
              let image =   viewModel.petsData[indexPath.row].photoUrls?.last else { return UICollectionViewCell()}
        
        cell.setUpContent(item: PetsCollectionViewCellItems(title: title,
                                                            image: image,
                                                            delegate: self))
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Go to detail")
    }
}

extension HomeViewController: PetsCollectionViewCellOutputProtocol {
    func onTappedButton() {
        print("Tapped")
    }
}

//// MARK: - UICollectionViewDelegateFlowLayout
//extension HomeViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let colums: CGFloat = 2
//        let collectioViewWith = collectionView.bounds.width
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
//        let adjustedWith = collectioViewWith - spaceBetweenCells
//        let width: CGFloat = floor(adjustedWith / colums)
//        let height: CGFloat = view.bounds.height / 3
//        return CGSize(width: width, height: height)
//    }
//}
