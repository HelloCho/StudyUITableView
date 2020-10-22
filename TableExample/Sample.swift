import UIKit

struct Sample {
    var name: String
    var description: String
    var imageName: String
    var imgUrl: URL?
    
    var senderImage: UIImage? {
        if imageName != "" {
            return UIImage(named: "\(imageName).jpg")
        } else {
            return nil
        }
    }
    
    static var sampleList: [Sample] {
        return [
            Sample(name: "tomato pasta1", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta1", imgUrl: nil),
            Sample(name: "tomato pasta2", description: "토마토소스를 버물려...", imageName: "pasta2", imgUrl: nil),
            Sample(name: "tomato pasta3", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta3", imgUrl: nil),
            Sample(name: "tomato pasta4", description: "토마토소스를 버물려...", imageName: "pasta4", imgUrl: nil),
            Sample(name: "tomato pasta5", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta5", imgUrl: nil),
            Sample(name: "tomato pasta6", description: "토마토소스를 버물려...", imageName: "pasta6", imgUrl: nil),
            Sample(name: "tomato pasta7", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta7", imgUrl: nil),
            Sample(name: "tomato pasta8", description: "토마토소스를 버물려...", imageName: "pasta8", imgUrl: nil),
            Sample(name: "tomato pasta9", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta9", imgUrl: nil),
            Sample(name: "tomato pasta10", description: "토마토소스를 버물려...", imageName: "pasta10", imgUrl: nil),
            Sample(name: "tomato pasta11", description: "토마토소스에 적절하게 버무려 먹는 앙주아중자우ㅏ주아주앚우ㅏㅈ우ㅏ주ㅏㅇ주 맛있는", imageName: "pasta11", imgUrl: nil)
        ]
    }
}
