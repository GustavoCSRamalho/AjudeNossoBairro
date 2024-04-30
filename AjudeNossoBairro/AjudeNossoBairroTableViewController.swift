import UIKit
import CoreData

class AjudeNossoBairroTableViewController: UITableViewController {
    
    var fetchResultsController: NSFetchedResultsController<News>!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
    }
    
    func loadNews(){
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController.delegate = self
        
        try? fetchResultsController.performFetch()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let movie = fetchResultsController.object(at: indexPath)
        cell.configureWith(movie)
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let newsViewController = segue.destination as? NewsViewController, let indexPath = tableView.indexPathForSelectedRow {
            newsViewController.news = fetchResultsController.object(at: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let news = fetchResultsController.object(at: indexPath)
            context.delete(news)
            try? context.save()
        }
    }

}

extension AjudeNossoBairroTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        tableView.reloadData()
    }
}
