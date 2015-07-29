//
//  CPYTypeViewController.swift
//  Clipy
//
//  Created by 古林俊佑 on 2015/07/30.
//  Copyright (c) 2015年 Shunsuke Furubayashi. All rights reserved.
//

import Cocoa

class CPYTypeViewController: NSViewController {

    // MARK: - Properties
    internal var storeTypes: NSMutableDictionary!
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let defaults = NSUserDefaults.standardUserDefaults()
        self.storeTypes = (defaults.objectForKey(kCPYPrefStoreTypesKey) as! NSMutableDictionary).mutableCopy() as! NSMutableDictionary
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public Methods
    internal func saveTypes() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.storeTypes, forKey: kCPYPrefStoreTypesKey)
        defaults.synchronize()
    }
    
}