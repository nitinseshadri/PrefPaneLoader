//
//  ViewController.swift
//  PrefPaneLoader
//
//  Created by Nitin Seshadri on 2/22/22.
//

import Cocoa
import PreferencePanes

class ViewController: NSViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak var panePathTextField: NSTextField?
    
    @IBOutlet weak var paneContentView: NSView?
    
    // MARK: Instance Variables
    
    private var currentPaneBundle: Bundle? = nil
    
    private var currentPrefPane: NSPreferencePane? = nil
    
    // MARK: View Controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Prepopulate text field with sample pref pane path
        if let samplePanePath = Bundle.main.builtInPlugInsURL?.appendingPathComponent("PrefPaneLoaderPrefPane.prefPane").path {
            panePathTextField?.stringValue = samplePanePath
        } else {
            NSLog("Could not find the sample preference pane.")
        }
    }

    // MARK: IBActions
    
    @IBAction func loadPanePressed(_ sender: Any) {
        if let panePath = panePathTextField?.stringValue {
            // Step 0. Clear out the current preference pane if one is loaded.
            if let subviews = paneContentView?.subviews {
                for subview in subviews {
                    subview.removeFromSuperview()
                }
            }
            
            // Step 1. Load the preference pane bundle.
            let bundleURL = URL(fileURLWithPath: panePath)
            self.currentPaneBundle = Bundle(url: bundleURL)
            
            if let currentPaneBundle = currentPaneBundle {
                let successfulLoad = currentPaneBundle.load()
                
                if (successfulLoad) {
                    NSLog("Loaded preference pane bundle at \(bundleURL)")
                    
                    // Step 2. Initialize the bundle's principal class, which must inherit from NSPreferencePane.
                    if let prefPaneClass = currentPaneBundle.principalClass as? NSPreferencePane.Type {
                        self.currentPrefPane = prefPaneClass.init(bundle: currentPaneBundle)
                        
                        // Step 3. Load and display the main view of the preference pane.
                        if let _ = currentPrefPane?.loadMainView() {
                            
                            if let paneMainView = currentPrefPane?.mainView {
                                paneContentView?.addSubview(paneMainView)
                                
                                currentPrefPane?.willSelect()
                                
                                currentPrefPane?.didSelect()
                                
                                paneMainView.translatesAutoresizingMaskIntoConstraints = true
                                
                                currentPrefPane?.initialKeyView?.becomeFirstResponder()
                            } else {
                                NSLog("No main view was found for the preference pane")
                            }
                        } else {
                            NSLog("No main view was loaded for the preference pane")
                        }
                    } else {
                        NSLog("The bundle's principal class doesn't seem to inherit from NSPreferencePane. Are you sure that this is a preference pane bundle?")
                    }
                } else {
                    NSLog("Could not load preference pane bundle at \(bundleURL)")
                }
            }
        } else {
            NSLog("Invalid preference pane bundle path")
        }
    }
    
    

}

