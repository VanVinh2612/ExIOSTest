//
//  ViewController.swift
//  ExIOSTest
//
//  Created by Vinh Nguyen on 29/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descreptionLabel: UILabel!
    @IBOutlet weak var seeMoreLabel: UILabel!
    @IBOutlet weak var seeMoreImageView: UIImageView!
    @IBOutlet weak var descriptionTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var anotherCollectionView: UICollectionView!
    
    private let whatIOfferItems = [
        "Etiam ultricies nisi vel augue 1",
        "Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi",
        "Etiam ultricies nisi vel augue",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        "Nullam dictum felis eu pede",
        "Aliquam lorem ante",
        "Sed consequat, leo eget bibendum sodales",
        "Curabitur ullamcorper ultricies nisi",
        "Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis"
    ]
    
    private var products: [Product] = []
    private var currentProduct: Product?
    private var isExpanded = false
    
    var currentPage = 0 {
        didSet {
            guard let currentProduct else { return }
            let totalItems = currentProduct.images.count
            if currentPage < totalItems {
                pageControl.currentPage = currentPage
                let indexPath = IndexPath(item: currentPage, section: 0)
                imageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDummyProducts()
        setupCollectionViews()
        setupTableView()
        setupLabel()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.imageCollectionView.collectionViewLayout.invalidateLayout()
            self.thumbnailCollectionView.collectionViewLayout.invalidateLayout()
            self.anotherCollectionView.collectionViewLayout.invalidateLayout()
            self.imageCollectionView.reloadData()
            self.thumbnailCollectionView.reloadData()
            self.anotherCollectionView.reloadData()
        }, completion: nil)
    }
    
    private func setupDummyProducts() {
        products = [
            Product(id: 1, name: "Product 1", description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec", whatIOfferItems: whatIOfferItems,
                    images: [Item(image: "item1", price: "15.00$"),
                             Item(image: "item2", price: "15.00$"),
                             Item(image: "item2", price: "15.00$"),
                             Item(image: "item2", price: "15.00$")],
                    thumbnailImage: "item2"),
            Product(id: 2, name: "Product 2", description: String(repeating: "This is product 1. ", count: 10), whatIOfferItems: whatIOfferItems,
                    images: [Item(image: "item2", price: "15.00$"),
                             Item(image: "item1", price: "15.00$"),
                             Item(image: "item2", price: "15.00$"),
                             Item(image: "item2", price: "15.00$")],
                    thumbnailImage: "item2"),
            Product(id: 3, name: "Product 3", description: "Description for product 3.", whatIOfferItems: whatIOfferItems,
                    images: [Item(image: "item2", price: "15.00$"),
                             Item(image: "item2", price: "15.00$"),
                             Item(image: "item1", price: "15.00$"),
                             Item(image: "item2", price: "15.00$")],
                    thumbnailImage: "item2"),
            Product(id: 4, name: "Product 4", description: "Description for product 4.", whatIOfferItems: whatIOfferItems,
                    images: [Item(image: "item2", price: "15.00$"),
                             Item(image: "item2", price: "15.00$"),
                             Item(image: "item2", price: "15.00$"),
                             Item(image: "item1", price: "15.00$")],
                    thumbnailImage: "item2"),
        ]
        
        currentProduct = products[0]
    }
    
    private func setupCollectionViews() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.register(ImageCell.nib, forCellWithReuseIdentifier: ImageCell.identifier)
        if let layout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 120
            layout.sectionInset = UIEdgeInsets(top: 18, left: 60, bottom: 18, right: 60)
        }
        imageCollectionView.isPagingEnabled = true
        
        thumbnailCollectionView.dataSource = self
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.register(ThumbCell.nib, forCellWithReuseIdentifier: ThumbCell.identifier)
        
        anotherCollectionView.dataSource = self
        anotherCollectionView.delegate = self
        anotherCollectionView.register(AnotherProductCell.nib, forCellWithReuseIdentifier: AnotherProductCell.identifier)
        if let layout = anotherCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 18
            layout.minimumInteritemSpacing = 18
            layout.sectionInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        }
    }
    
    private func setupLabel() {
        titleLabel.text = currentProduct?.name
        seeMoreLabel.text = isExpanded ? "See Less" : "See More"
        seeMoreImageView.image = isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
    }
    
    private func setupTableView() {
        descriptionTableView.dataSource = self
        descriptionTableView.delegate = self
        descriptionTableView.register(DescriptionCell.nib, forCellReuseIdentifier: DescriptionCell.identifier)
        tableViewHeightConstraint.constant = 0
        descriptionTableView.isScrollEnabled = false
    }
    
    //MARK: Action SeeMore/SeeLess
    @IBAction func didTapSeeMore(_ sender: UIButton) {
        isExpanded.toggle()

        let buttonTitle = isExpanded ? "See Less" : "See More"
        seeMoreLabel.text = buttonTitle
        seeMoreImageView.image = isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
       
        if isExpanded {
            descriptionTableView.reloadData()
            DispatchQueue.main.async {
                self.descriptionTableView.layoutIfNeeded()
                let height = self.descriptionTableView.contentSize.height
                self.tableViewHeightConstraint.constant = height
                self.descriptionTableView.isHidden = false
            }
        } else {
            tableViewHeightConstraint.constant = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.descriptionTableView.isHidden = true
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateProductUI() {
        titleLabel.text = currentProduct?.name
        
        isExpanded = false
        seeMoreLabel.text = "See More"
        seeMoreImageView.image = UIImage(systemName: "chevron.down")
        tableViewHeightConstraint.constant = 0
        descriptionTableView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let currentProduct else { return 0}
        if collectionView == imageCollectionView || collectionView == thumbnailCollectionView {
            return currentProduct.images.count
        } else if collectionView == anotherCollectionView {
            return products.filter { $0.id != currentProduct.id }.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentProduct else { return UICollectionViewCell() }
        switch collectionView {
        case imageCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
                return UICollectionViewCell()
            }
            let image = currentProduct.images[indexPath.item]
            cell.configCell(image)
            return cell
        case thumbnailCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbCell.identifier, for: indexPath) as? ThumbCell else {
                return UICollectionViewCell()
            }
            let image = currentProduct.images[indexPath.item]
            let isSelected = indexPath.item == currentPage
            cell.configCell(image, isSelected: isSelected)
            return cell
        case anotherCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnotherProductCell.identifier, for: indexPath) as? AnotherProductCell else {
                return UICollectionViewCell()
            }
            let otherProducts = products.filter { $0.id != currentProduct.id }
            let product = otherProducts[indexPath.item]
            cell.configCell(product)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == thumbnailCollectionView {
            currentPage = indexPath.item
            let imageIndexPath = IndexPath(item: indexPath.item, section: 0)
            imageCollectionView.scrollToItem(at: imageIndexPath, at: .centeredHorizontally, animated: true)
            thumbnailCollectionView.reloadData()
        } else if collectionView == anotherCollectionView {
            let otherProducts = products.filter { $0.id != currentProduct?.id }
            let selectedProduct = otherProducts[indexPath.item]
            
            currentProduct = selectedProduct
            currentPage = 0
            imageCollectionView.reloadData()
            thumbnailCollectionView.reloadData()
            anotherCollectionView.reloadData()
            let imageIndexPath = IndexPath(item: 0, section: 0)
            imageCollectionView.scrollToItem(at: imageIndexPath, at: .centeredHorizontally, animated: true)
            thumbnailCollectionView.scrollToItem(at: imageIndexPath, at: .centeredHorizontally, animated: false)
            updateProductUI()
            scrollView.setContentOffset(.zero, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case imageCollectionView:
            let interItemSpacing: CGFloat = 120
            let cellWidth = collectionView.bounds.width - interItemSpacing
            let aspectRatio: CGFloat = 182.0 / 252.0
            let cellHeight = cellWidth * aspectRatio
            return CGSize(width: cellWidth, height: cellHeight)
        case thumbnailCollectionView:
            let itemsInRow: CGFloat = 4
            let interItemSpacing: CGFloat = 2
            let sidePadding: CGFloat = 14
            let totalSpacing = (itemsInRow - 1) * interItemSpacing + 2 * sidePadding
            let availableWidth = collectionView.bounds.width - totalSpacing
            let cellWidth = availableWidth / itemsInRow
            let aspectRatio: CGFloat = 50.0 / 74.0
            let cellHeight = cellWidth * aspectRatio
            return CGSize(width: cellWidth, height: cellHeight)
        case anotherCollectionView:
            let sidePadding: CGFloat = 18
            let aspectRatio: CGFloat = 174.0 / 220.0
            let availableWidth = collectionView.bounds.width - (2 * sidePadding)
            let cellWidth = availableWidth * 0.6
            let cellHeight = cellWidth * aspectRatio
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return .zero
        }
    }
}

//MARK: UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == imageCollectionView {
            let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            currentPage = page
            let indexPath = IndexPath(item: currentPage, section: 0)
            thumbnailCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            thumbnailCollectionView.reloadData()
        }
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
//                                    withVelocity velocity: CGPoint,
//                                    targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        guard scrollView == imageCollectionView,
//              let layout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
//        let cellWidth = layout.itemSize.width
//        let offsetX = scrollView.contentOffset.x
//        let collectionViewWidth = scrollView.bounds.width
//
//        // Tính index gần nhất dựa vào vị trí trung tâm màn hình
//        let index = round((offsetX + collectionViewWidth / 2) / cellWidth)
//
//        // Clamp index để không vượt ngoài giới hạn
//        let maxIndex = CGFloat(imageCollectionView.numberOfItems(inSection: 0) - 1)
//        let clampedIndex = max(0, min(index, maxIndex))
//
//        // Gán lại target offset
//        targetContentOffset.pointee = CGPoint(x: clampedIndex * cellWidth, y: 0)
//    }
}

//MARK: TableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentProduct?.whatIOfferItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentProduct,
              let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as? DescriptionCell else { return UITableViewCell()}
        cell.configCell(currentProduct.whatIOfferItems[indexPath.row])
        return cell
    }
}
