//
//  TaskTableViewCell
//  ToDoList
//
//  Created by Ling He on 1/31/17.
//  Copyright © 2017 Ling He. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    var title: String = "Title not set" {
        willSet {
            titleLabel.text = newValue
        }
    }
    var detail = "Detail not set" {
        willSet {
            detailLabel.text = newValue
        }
    }
    var deadline = Date() {
        willSet {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: newValue)
            var str = String(describing: components.year!)
            str += "-\(components.month!)-\(components.day!)"
            deadlineLabel.text = str
        }
    }
    var group = 0 {
        willSet {
            groupLabel.textColor = groupColor[newValue] ?? UIColor.black
        }
    }
    var importLevel = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    
    let groupColor = [0: UIColor.red, 1: UIColor.yellow, 2: UIColor.green, 3: UIColor.blue]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let circleCoor = CGPoint(x: self.bounds.size.width - 10, y: self.bounds.size.height - 10)
//        print("width = \(self.bounds.size.width), height = \(self.bounds.size.height)")
//        let circleView = ColoredCircle.getCircleView(coor: circleCoor, len: 10, color: UIColor.red)
//        self.contentView.addSubview(circleView)
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
