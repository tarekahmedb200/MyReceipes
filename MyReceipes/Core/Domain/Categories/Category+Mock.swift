//
//  Category+Mock.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation


extension Category {
    static var mockCategories: [Category] {
        var array =
        [Category(id: "1", name: "Beef", thumbURL: "https://www.themealdb.com/images/category/beef.png"),
        Category(id: "2", name: "Chicken", thumbURL: "https://www.themealdb.com/images/category/chicken.png"),
        Category(id: "3", name: "Dessert", thumbURL: "https://www.themealdb.com/images/category/dessert.png"),
        Category(id: "4", name: "Lamb", thumbURL: "https://www.themealdb.com/images/category/lamb.png")]
        return array
    }
}
