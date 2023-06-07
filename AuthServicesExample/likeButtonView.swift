//
//  likeButtonView.swift
//  AuthServicesExample
//
//  Created by Tom Wu on 2023-06-07.
//

import SwiftUI

struct likeButtonView: View {
    @State private var isLiked = false
    var body: some View {
        Button(action: {
                    self.isLiked.toggle()
                }){Image(systemName: isLiked ? "heart.fill" : "heart")
                Text(isLiked ? "Liked" : "Like")
            }
    }
}

struct likeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        likeButtonView()
    }
}
