//
//  CPYShortcutViewController.swift
//  Clipy
//
//  Created by 古林俊佑 on 2015/07/30.
//  Copyright (c) 2015年 Shunsuke Furubayashi. All rights reserved.
//

import Cocoa

class CPYShortcutViewController: NSViewController {

    // MARK: - Properties
    @IBOutlet weak var mainShortcutRecorder: SRRecorderControl!
    @IBOutlet weak var historyShortcutRecorder: SRRecorderControl!
    @IBOutlet weak var snippetsShortcutRecorder: SRRecorderControl!
    private var shortcutRecorders = [SRRecorderControl]()
    
    // MARK: - Window Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareHotKeys()
    }
    
    // MARK: - Private Methods
    private func prepareHotKeys() {
        self.shortcutRecorders = [self.mainShortcutRecorder, self.historyShortcutRecorder, self.snippetsShortcutRecorder]
        
        let hotKeyMap = CPYHotKeyManager.sharedManager.hotkeyMap
        let hotKeyCombos = NSUserDefaults.standardUserDefaults().objectForKey(kCPYPrefHotKeysKey) as! [String: AnyObject]
        for identifier in hotKeyCombos.keys {
            
            let keyComboPlist = hotKeyCombos[identifier] as! [String: AnyObject]
            let keyCode = Int(keyComboPlist["keyCode"]! as! NSNumber)
            let modifiers = UInt(keyComboPlist["modifiers"]! as! NSNumber)
            
            if let keys = hotKeyMap[identifier] as? [String: AnyObject] {
                let index = keys[kIndex] as! Int
                let recorder = self.shortcutRecorders[index]
                let keyCombo = KeyCombo(flags: recorder.carbonToCocoaFlags(modifiers), code: keyCode)
                recorder.keyCombo = keyCombo
                recorder.animates = true
            }
        }
    }
    
    private func changeHotKeyByShortcutRecorder(aRecorder: SRRecorderControl!, keyCombo: KeyCombo) {
        let newKeyCombo = PTKeyCombo(keyCode: keyCombo.code, modifiers: aRecorder.cocoaToCarbonFlags(keyCombo.flags))
        
        var identifier = ""
        if aRecorder == self.mainShortcutRecorder {
            identifier = kClipMenuIdentifier
        } else if aRecorder == self.historyShortcutRecorder {
            identifier = kHistoryMenuIdentifier
        } else if aRecorder == self.snippetsShortcutRecorder {
            identifier = kSnippetsMenuIdentifier
        }
        
        let hotKeyCenter = PTHotKeyCenter.sharedCenter()
        let oldHotKey = hotKeyCenter.hotKeyWithIdentifier(identifier)
        hotKeyCenter.unregisterHotKey(oldHotKey)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var hotKeyPrefs = defaults.objectForKey(kCPYPrefHotKeysKey) as! [String: AnyObject]
        hotKeyPrefs.updateValue(newKeyCombo.plistRepresentation(), forKey: identifier)
        defaults.setObject(hotKeyPrefs, forKey: kCPYPrefHotKeysKey)
        defaults.synchronize()
    }
    
    // MARK: - SRRecoederControl Delegate
    func shortcutRecorder(aRecorder: SRRecorderControl!, keyComboDidChange newKeyCombo: KeyCombo) {
        if contains(self.shortcutRecorders, aRecorder) {
            self.changeHotKeyByShortcutRecorder(aRecorder, keyCombo: newKeyCombo)
        }
    }

    
}
