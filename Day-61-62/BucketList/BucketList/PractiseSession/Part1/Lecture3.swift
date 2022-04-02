//
//  Lecture3.swift
//  BucketList
//
//  Created by harsh Khandelwal on 26/11/21.
//

//MARK:                             Switching view states with enums

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct Lecture3: View {
    
    enum LoadingState {
        case loading, success, failed
    }
    
    var loadingState = LoadingState.success

    
    var body: some View {
        
        VStack {
            //conditional views are particularly useful is when we want to show one of several different states, and if we plan it correctly we can keep our view code small and also easy to maintain – it’s a great way to start training your brain to think about SwiftUI architecture.
            Group {
                if Bool.random() {
                    Rectangle()
                } else {
                    Circle().frame(width: 100, height: 100, alignment: .center)
                }
            }
            Group {
                if loadingState == .loading {
                    LoadingView()
                } else if loadingState == .success {
                    SuccessView()
                } else if loadingState == .failed {
                    FailedView()
                }
            }
        }
        
        
    }
}

struct Lecture3_Previews: PreviewProvider {
    static var previews: some View {
        Lecture3()
    }
}
