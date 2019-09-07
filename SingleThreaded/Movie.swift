//
//  Movie.swift
//  SingleThreaded
//
//  Created by Rodney Cocker on 07/09/19.
//  Copyright © 2019 RMIT. All rights reserved.
//

import Foundation

class Movie
{
    var title:String = ""
    var actor:String = ""
    
    init(){}
    
    init(title:String, actor:String)
    {
        self.title = title
        self.actor = actor
    }
}
