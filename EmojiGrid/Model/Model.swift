//
//  SFItems.swift
//  SFGrid
//
//  Created by Makwan BK on 2021-01-11.
//

import Foundation

struct ReactionItem: Hashable {
    var id = UUID()
    let icon : String
    
    static var laugh : [ReactionItem] = [
        ReactionItem(icon: "😃"),
        ReactionItem(icon: "😄"),
        ReactionItem(icon: "😁"),
        ReactionItem(icon: "😆"),
        ReactionItem(icon: "😂"),
        ReactionItem(icon: "🤣"),
    ]
    
    static var cry : [ReactionItem] = [
        ReactionItem(icon: "😕"),
        ReactionItem(icon: "😟"),
        ReactionItem(icon: "😔"),
        ReactionItem(icon: "😞"),
        ReactionItem(icon: "😢"),
        ReactionItem(icon: "😭"),
    ]
    
    static var love : [ReactionItem] = [
        ReactionItem(icon: "❤️"),
        ReactionItem(icon: "😘"),
        ReactionItem(icon: "😍"),
        ReactionItem(icon: "🥰"),
        ReactionItem(icon: "😻"),
        ReactionItem(icon: "💕"),
        ReactionItem(icon: "💞"),
        ReactionItem(icon: "❣️"),
    ]
    
}


