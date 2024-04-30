import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelReport: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ news: News) {
        labelName.text = news.name
        labelAddress.text = news.address
        labelReport.text = news.report
        if let image = news.image {
            imageViewPoster.image = UIImage(data: image)
        }
        
    }

}
