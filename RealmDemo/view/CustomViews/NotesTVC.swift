//
//  NotesTVC.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit

class NotesTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    var data : Note?
    func setUI(){
        self.backView.layer.cornerRadius = 10
        self.backView.layer.borderWidth = 1
        self.backView.layer.borderColor = UIColor.gray.cgColor
        self.titleLabel.text = ""
        self.contentLabel.text = ""
        self.dateLabel.text = ""
    }
    
    func setData(note : Note?){
        if let data = note {
            self.data = data
            self.titleLabel.text = data.title
            if data.title.count > 15 {
                let index = data.content.index(data.content.startIndex, offsetBy: 15)
                self.contentLabel.text = String(data.content[..<index]) + "..."
            }else{
                self.contentLabel.text = data.content+"..."
            }
            self.dateLabel.text = "Last Modified : " + "\(data.dateModified!.getFormattedDate())"
        }
    }
}

extension Date {
    func getFormattedDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy, hh:mm a"
        return formatter.string(from: self)
    }
}
