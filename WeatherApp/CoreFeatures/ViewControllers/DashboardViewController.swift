//

import UIKit

class DashboardViewController: UIViewController {
    var searchBarContainerView = UIView()
    lazy var searchBar = UISearchBar()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel: DashboardViewModel
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        return tv
    }()
    
    
    init(_ viewModel: DashboardViewModel = DashboardViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "Weather App"
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    private func setupSearchController() {
        self.navigationItem.searchController = searchController
        self.searchController.searchBar.placeholder = "Search"
    
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
}

// MARK: - Search Controller Functions
extension DashboardViewController: UISearchControllerDelegate, UISearchBarDelegate  {

}


// MARK: - TableView Functions
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell else {
            fatalError("Unable to dequeue CoinCell in HomeController")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
