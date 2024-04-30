import UIKit

class NewsViewController: UIViewController {
    
    var news: News?
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelReport: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    func prepareScreen(){
        if let news = news {
            if let image = news.image {
                imageViewPoster.image = UIImage(data: image)
            }
            labelName.text = news.name
            labelAddress.text = news.address
            labelReport.text = news.report
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newsFormViewController = segue.destination as? NewsFormViewController {
            newsFormViewController.news = news
        }
    }
}

