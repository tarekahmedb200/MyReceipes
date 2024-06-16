//
//  Receipes+Mock.swift
//  MyReceipes
//
//  Created by tarek ahmed on 12/06/2024.
//

import Foundation


extension Receipe {
    static var mockSearchedReceipes: [Receipe] {
        return [
            Receipe(id: "52959", name: "Baked salmon with fennel & tomatoes", thumbURL: "https://www.themealdb.com/images/media/meals/1548772327.jpg"),
            Receipe(id: "52819", name: "Cajun spiced fish tacos", thumbURL: "https://www.themealdb.com/images/media/meals/uvuyxu1503067369.jpg"),
            Receipe(id: "52944", name: "Escovitch Fish", thumbURL: "https://www.themealdb.com/images/media/meals/1520084413.jpg"),
            Receipe(id: "53043", name: "Fish fofos", thumbURL: "https://www.themealdb.com/images/media/meals/a15wsa1614349126.jpg")
        ]
    }
    
    static var mockReceipeDetail : Receipe {
        return Receipe(
            id: "52977",
            name: "Corba",
            thumbURL: "https://www.themealdb.com/images/media/meals/58oia61564916529.jpg",
            category: "Side",
            area: "Turkish",
            instructions: "Pick through your lentils for any foreign debris, rinse them 2 or 3 times, drain, and set aside.  Fair warning, this will probably turn your lentils into a solid block that you’ll have to",
            youtubeURL: "https://www.youtube.com/watch?v=VVnZd8A84z4",
            sourceURL: "https://findingtimeforcooking.com/main-dishes/red-lentil-soup-corba/",
            dateModified: "",
            ingredientsDictionary: [
                "Lentils": "1 cup",
                "Onion": "1 large",
                "Carrots": "1 large",
                "Tomato Puree": "1 tbs",
                "Cumin": "2 tsp",
                "Paprika": "1 tsp",
                "Mint": "1/2 tsp",
                "Thyme": "1/2 tsp",
                "Black Pepper": "1/4 tsp",
                "Red Pepper Flakes": "1/4 tsp",
                "Vegetable Stock": "4 cups",
                "Water": "1 cup",
                "Sea Salt": "Pinch"
            ]
        )
    }
    
}



