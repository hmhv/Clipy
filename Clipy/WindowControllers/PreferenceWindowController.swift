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
    // toolbar
    @IBOutlet weak var toolbarView: NSView!
    // toolbar item
    @IBOutlet weak var generalButton: NSButton!
    @IBOutlet weak var menuButton: NSButton!
    @IBOutlet weak var typeButton: NSButton!
    @IBOutlet weak var shortcutButton: NSButton!
    @IBOutlet weak var updateButton: NSButton!
    // toolbar title
    @IBOutlet weak var generalLabel: NSTextField!
    @IBOutlet weak var menuLabel: NSTextField!
    @IBOutlet weak var typeLabel: NSTextField!
    @IBOutlet weak var shortcutLabel: NSTextField!
    @IBOutlet weak var updateLabel: NSTextField!
    
    // MARK: - Window Life Cycle
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.backgroundColor = NSColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        self.window?.titlebarAppearsTransparent = true
        self.switchView(self.generalButton)
    }
    
    // MARK: - IBActions
    @IBAction func switchView(sender: AnyObject) {
        if let button = sender as? NSButton {
            if let newView = self.viewControllers[button.tag]?.view {
                for view in self.window!.contentView.subviews {
                    if let view = view as? NSView where view != self.toolbarView {
                        view.removeFromSuperview()
                    }
                }
                
                let frame = self.window!.frame
                var newFrame = self.window!.frameRectForContentRect(newView.frame)
                newFrame.origin = frame.origin
                newFrame.origin.y += NSHeight(frame) - NSHeight(newFrame) - NSHeight(self.toolbarView.frame)
                newFrame.size.height += NSHeight(self.toolbarView.frame)
                self.window!.setFrame(newFrame, display: true)
                
                self.window!.contentView.addSubview(newView)
            }
        }
    }
    
}
