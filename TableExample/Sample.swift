//
//  Sample.swift
//  TableExample
//
//  Created by 조경식 on 2020/10/19.
//

import UIKit

struct Sample {
    let name: String
    let description: String
    let imageName: String
    
    var senderImage: UIImage? {
        return UIImage(named: "\(imageName).jpg")
    }
    
    static var sampleList: [Sample] {
        return [
            Sample(name: "tomato pasta1", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta1"),
            Sample(name: "tomato pasta2", description: "토마토소스를 버물려...", imageName: "pasta2"),
            Sample(name: "tomato pasta3", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta3"),
            Sample(name: "tomato pasta4", description: "토마토소스를 버물려...", imageName: "pasta4"),
            Sample(name: "tomato pasta5", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta5"),
            Sample(name: "tomato pasta6", description: "토마토소스를 버물려...", imageName: "pasta6"),
            Sample(name: "tomato pasta7", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta7"),
            Sample(name: "tomato pasta8", description: "토마토소스를 버물려...", imageName: "pasta8"),
            Sample(name: "tomato pasta9", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta9"),
            Sample(name: "tomato pasta10", description: "토마토소스를 버물려...", imageName: "pasta10"),
            Sample(name: "tomato pasta11", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta11")
        ]
    }
}
