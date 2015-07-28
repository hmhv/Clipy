//
//  PreferenceWindowController.swift
//  Clipy
//
//  Created by 古林俊佑 on 2015/07/29.
//  Copyright (c) 2015年 Shunsuke Furubayashi. All rights reserved.
//

import Cocoa

class PreferenceWindowController: NSWindowController {

    // MARK: - Properties
    private lazy var viewControllers = [NSViewController(nibName: "CPYGeneralViewController", bundle: nil),
                                        NSViewController(nibName: "CPYMenuViewController", bundle: nil),
                                        NSViewController(nibName: "CPYTypeViewController", bundle: nil),
                                        NSViewController(nibName: "CPYShortcutViewController", bundle: nil),
                                        NSViewController(nibName: "CPYUpdateViewController", bundle: nil)]
    
    // MARK: - Window Life Cycle
    override func windowDidLoad() {
        super.windowDidLoad()
        self.initToolbar()
        self.window?.backgroundColor = NSColor.whiteColor()
        self.window?.titlebarAppearsTransparent = true
    }
    
    // MARK: - Private Methods
    private func initToolbar() {
        let toolBar = NSToolbar(identifier: "toolBar")
        toolBar.allowsUserCustomization = true
        toolBar.autosavesConfiguration = true
        self.window?.toolbar = toolBar
    }
    
}

extension PreferenceWindowController: NSToolbarDelegate {
    /*
    func toolbarAllowedItemIdentifiers(toolbar: NSToolbar) -> [AnyObject] {
        return [kAddSnippetIdentifier, kAddFolderIdentifier, kDeleteIdentifier, kEnableIdentifier, kSettingIdentifier]
    }
    
    func toolbarDefaultItemIdentifiers(toolbar: NSToolbar) -> [AnyObject] {
        return [kAddSnippetIdentifier, kAddFolderIdentifier, kDeleteIdentifier, kEnableIdentifier, kSettingIdentifier]
    }
    
    func toolbar(toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        var image: NSImage?
        var title  = ""
        var action = ""
        
        if itemIdentifier == kAddSnippetIdentifier {
            image = NSImage(named: "add_snippet")
            title = "追加"
            action = ""
        } else if itemIdentifier == kAddFolderIdentifier {
            image = NSImage(named: "add_folder")
            title = "追加"
            action = ""
        } else if itemIdentifier == kDeleteIdentifier {
            image = NSImage(named: "delete_snippet")
            title = "削除"
            action = ""
        } else if itemIdentifier == kEnableIdentifier {
            image = NSImage(named: "enable_snippet")
            title = "オン/オフ"
            action = ""
        } else if itemIdentifier == kSettingIdentifier {
            image = NSImage(named: "setting_snippet")
            title = "編集"
            action = ""
        }
        
        let imageView = NSImageView(frame: NSMakeRect(0, 0, 36, 24))
        imageView.image = image
        
        let item = NSToolbarItem(itemIdentifier: itemIdentifier)
        item.label = title
        item.target = self
        item.view = imageView
        
        return item
    }
    */
}

