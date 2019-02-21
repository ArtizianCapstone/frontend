//
//  PaymentViewController.swift
//  Frontend
//
//  Created by Rebecca Krieger on 2/20/19.
//  Copyright © 2019 Artizian. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    enum TabIndex : Int {
        case current = 0
        case past = 1
    }

    
    
    @IBOutlet weak var segmentedController: TabySegmentedControl!

    var activeViewController: UIViewController?

    @IBOutlet weak var activeView: UIView!
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "currentPaymentsID")
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "pastPaymentsID")
        
        return secondChildTabVC
    }()
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedController.initUI()
        segmentedController.selectedSegmentIndex = TabIndex.current.rawValue
        displayCurrentTab(TabIndex.current.rawValue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let activeViewController = activeViewController {
            activeViewController.viewWillDisappear(animated)
        }
    }
    
    // MARK: - Switching Tabs Functions

    @IBAction func switchTabs(_ sender: TabySegmentedControl) {
        self.activeViewController!.view.removeFromSuperview()
        self.activeViewController!.removeFromParent()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChild(vc)
            vc.didMove(toParent: self)
            
            vc.view.frame = self.activeView.bounds
            self.activeView.addSubview(vc.view)
            self.activeViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.current.rawValue :
            vc = firstChildTabVC
        case TabIndex.past.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }
}
