//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by harsh Khandelwal on 29/10/21.
//

import SwiftUI

struct EmojiRatingView: View {
    
    let rating: Int16

    var body: some View {
        switch rating {
            case 1:
                return Text("đ´")
            case 2:
                return Text("âšī¸")
            case 3:
                return Text("đ")
            case 4:
                return Text("đ")
            default:
                return Text("đ")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
