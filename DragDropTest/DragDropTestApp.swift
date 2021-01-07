import SwiftUI
import GoogleMobileAds

@main
struct DragDropTestApp: App {
  
    var body: some Scene {
        WindowGroup {
            GameView()
                .onAppear {
                    GADMobileAds.sharedInstance().start(completionHandler: nil)
                }
        }
    }
}
