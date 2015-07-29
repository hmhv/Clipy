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
                
                self.resetButtonImages()
                self.selectButton(button.tag)
                
                
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
    
    // MARK: - Private Methods
    private func resetButtonImages() {
        self.generalButton.image    = NSImage(named: "pref_general")
        self.menuButton.image       = NSImage(named: "pref_menu")
        self.typeButton.image       = NSImage(named: "pref_type")
        self.shortcutButton.image   = NSImage(named: "pref_shortcut")
        self.updateButton.image     = NSImage(named: "pref_update")
        
        self.generalLabel.textColor     = NSColor(red: 0.2666, green: 0.2666, blue: 0.2666, alpha: 1)
        self.menuLabel.textColor        = NSColor(red: 0.2666, green: 0.2666, blue: 0.2666, alpha: 1)
        self.typeLabel.textColor        = NSColor(red: 0.2666, green: 0.2666, blue: 0.2666, alpha: 1)
        self.shortcutLabel.textColor    = NSColor(red: 0.2666, green: 0.2666, blue: 0.2666, alpha: 1)
        self.updateLabel.textColor      = NSColor(red: 0.2666, green: 0.2666, blue: 0.2666, alpha: 1)
    }
    
    private func selectButton(tag: Int) {
        var selectButton: NSButton?
        var selectLabel: NSTextField?
        var selectImage: NSImage?
        
        switch tag{
        case 0:
            selectButton = self.generalButton
            selectLabel  = self.generalLabel
            selectImage  = NSImage(named: "pref_general_on")
        case 1:
            selectButton = self.menuButton
            selectLabel  = self.menuLabel
            selectImage  = NSImage(named: "pref_menu_on")
        case 2:
            selectButton = self.typeButton
            selectLabel  = self.typeLabel
            selectImage  = NSImage(named: "pref_type_on")
        case 3:
            selectButton = self.shortcutButton
            selectLabel  = self.shortcutLabel
            selectImage  = NSImage(named: "pref_shortcut_on")
        case 4:
            selectButton = self.updateButton
            selectLabel  = self.updateLabel
            selectImage  = NSImage(named: "pref_update_on")
        default:
            break
        }
        
        selectButton?.image = selectImage
        selectLabel?.textColor = NSColor(red: 0.164, green: 0.517, blue: 0.823, alpha: 1)
    }
    
}
