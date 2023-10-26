//
//  MatiView.swift
//  TestMati
//
//  Created by Anantachai Kulson on 10/10/2566 BE.
//

import Foundation
import SwiftUI
import UIKit
import MetaMapSDK
//import UIK

struct MatiView: View {
    var body: some View {
        VStack {
            ZStack {
                MetaMapDelegateObserver { identityId, verificationId in
                    print("IdentityID----> \(identityId), \(verificationId)")
                } cancelled: {
                    print("cancelled")
                }
                HStack {
                    Button(action: {
                        MetaMap.shared.showMetaMapFlow(clientId: "603cfa75cda794001b20f88c", flowId: "603cfa75cda794001b20f88b", metadata: nil)
                    }) {
                        Text("Press me!")
                        .font(.system(size: 44, weight: .bold))
                    }
                }
            }
        }
    }
}

struct MetaMapDelegateObserver: UIViewControllerRepresentable {
    let vc = MetaMapViewController()
    public func makeUIViewController(context: Context) -> MetaMapViewController {
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: MetaMapViewController, context: Context) {}
    
    var success: (_ identityId: String?, _ verificationId: String?) -> Void
    var cancelled: () -> Void
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(success: success, cancelled: cancelled)
    }
    
    public  class Coordinator: NSObject, MetaMapButtonResultDelegate {
        public  func verificationSuccess(identityId: String?, verificationID: String?) {
            success(identityId, verificationID)
        }
        
        public  func verificationCancelled() {
            cancelled()
        }
        
        var success: (_ identityId: String?, _ verificationId: String?) -> Void
        var cancelled: () -> Void
        
        init(success: @escaping (_ identityId: String?, _ verificationId: String?) -> Void, cancelled: @escaping () -> Void) {
            self.success = success
            self.cancelled = cancelled
            super.init()
            MetaMapButtonResult.shared.delegate = self
        }
    }
}

class MetaMapViewController: UIViewController {}
