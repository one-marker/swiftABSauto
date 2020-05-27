//
//  PageViewController2.swift
//  ACSprojects
//
//  Created by Максим Евлентьев on 25.02.17.
//  Copyright © 2017 Максим Евлентьев. All rights reserved.
//

import UIKit

class PageViewController2: UIPageViewController

{
    // Some hard-coded data for our walkthrough screens
    var pageHeaders = ["Первый шаг", "Второй шаг", "Третий шаг","Начните прямо сейчас"]
    var pageImages = ["pictureOnePas-1", "pictureTwoPas3", "pictureThreePas-2","camera1"]
    var pageDescriptions = ["Сделайте фото техпаспорта(сторона VIN)", "Отправьте фото техпаспорта. Сторона с данными VIN. Укажите какие детали автомобиля Вам нужны.", "Мы предоставим Вам лучшую цену и лучший срок поставки необходимой запчасти",""]
    
    // make the status bar white (light content)
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this class is the page view controller's data source itself
        self.dataSource = self
        
        // create the first walkthrough vc
        if let startWalkthroughVC = self.viewControllerAtIndex(0) {
            setViewControllers([startWalkthroughVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Navigate
    
    func nextPageWithIndex(_ index: Int)
    {
        if let nextWalkthroughVC = self.viewControllerAtIndex(index+1) {
            setViewControllers([nextWalkthroughVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(_ index: Int) -> WalkthroughViewController2?
    {
        if index == NSNotFound || index < 0 || index >= self.pageDescriptions.count {
            return nil
        }
        
        // create a new walkthrough view controller and assing appropriate date
        if let walkthroughViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughViewController2") as? WalkthroughViewController2 {
            walkthroughViewController.imageName = pageImages[index]
            walkthroughViewController.headerText = pageHeaders[index]
            walkthroughViewController.descriptionText = pageDescriptions[index]
            walkthroughViewController.index = index
            
            return walkthroughViewController
        }
        
        return nil
    }
}

extension PageViewController2 : UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! WalkthroughViewController2).index
        index += 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughViewController2).index
        index -= 1
        return self.viewControllerAtIndex(index)
    }
}
