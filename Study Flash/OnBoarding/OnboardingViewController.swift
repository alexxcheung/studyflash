//
//  OnboardingViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 5/23/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class OnboardingViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CustomCollectionViewCellDelegate {
    
    let numberOfOnboardingScreen = 4
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageControl()
        setupLayout()
    }
    
    //Configuring CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfOnboardingScreen
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "page1", for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "page2", for: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "page3", for: indexPath)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "page4", for: indexPath) as! OnboardingPage4
            cell.delegate = self
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    private func setupLayout() {
        guard let collectionView = collectionView else {return}
        
        collectionView.register(OnboardingPage1.self, forCellWithReuseIdentifier: "page1")
        collectionView.register(OnboardingPage2.self, forCellWithReuseIdentifier: "page2")
        collectionView.register(OnboardingPage3.self, forCellWithReuseIdentifier: "page3")
        collectionView.register(OnboardingPage4.self, forCellWithReuseIdentifier: "page4")
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
    }
    
    //pageControl
    func configurePageControl(){
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 180 , width: UIScreen.main.bounds.width, height: 50)) //add constrain later
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .primaryThemeColor
        
        self.view.addSubview(pageControl)
    }
    
    //moving indicator
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    //MARK: - MyCustomCellDelegator Methods
    func presentNewViewController(myData dataobject: AnyObject) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
        mainViewController.modalTransitionStyle = .crossDissolve
        mainViewController.modalPresentationStyle = .fullScreen
        
        UserDefaults.standard.set(true, forKey: "isOnboardingFinish")
        UserDefaults.standard.synchronize()
        
        self.present(mainViewController, animated: true, completion: nil)
    }
}

protocol CustomCollectionViewCellDelegate {
    func presentNewViewController(myData dataobject: AnyObject)
}
