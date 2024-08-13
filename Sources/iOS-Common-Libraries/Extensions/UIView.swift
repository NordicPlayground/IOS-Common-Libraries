//
//  UIView.swift
//  iOS-Common-Libraries
//
//  Created by Dinesh Harjani on 29/7/24.
//  Copyright © 2024 Nordic Semiconductor. All rights reserved.
//

#if os(iOS) || targetEnvironment(macCatalyst)
import UIKit

// MARK: - UIView Extension

public extension UIView {
    
    // MARK: isAttachedToViewHierarchy
    
    /**
     Helper function to detect whether a `UIView` is part of a view hierarchy to prevent unneeded updates. In [nRF Connect](https://github.com/NordicSemiconductor/IOS-nRF-Connect), this is critical to ensure `UITableView`(s) do not fire data source changes when they're being swapped out, for example.
     
     - returns: True if a `UIWindow` is present upstream this view's responder chain.
     */
    func isAttachedToViewHierarchy() -> Bool {
        return firstParentWindow() != nil
    }
    
    /**
     Travels through the `UIView`'s responder chain to find its first parent `UIWindow`.
     
     - returns: First `UIWindow` present up the responder chain.
     - seealso: [Apple Developer Event Handling using the responder chain](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/using_responders_and_the_responder_chain_to_handle_events) documentation.
     */
    func firstParentWindow() -> UIWindow? {
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            guard let parentViewController = parentResponder as? UIWindow else {
                parentResponder = parentResponder?.next
                continue
            }
            return parentViewController
        }
        return nil
    }
}
#endif
