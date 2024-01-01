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
        tv.register(DashboardTableViewCell.self, forCellReuseIdentifier: DashboardTableViewCell.identifier)
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
        
        self.loadWeatherData()
        self.displayErrorMessage()
        
    }
    
    // MARK: - Data binding
    private func loadWeatherData() {
        self.viewModel.onCityUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func displayErrorMessage() {
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                switch error {
                case .serverError:
                    alert.title = "Server Error "
                    alert.message = "server error"
                case .unknown(let string):
                    alert.title = "Error Fetching Data"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
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
        searchController.searchResultsUpdater = self
        
    }
}

// MARK: - Search Controller Functions
extension DashboardViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.viewModel.fetchWeatherDataViewedByUser()
        }
    }
}

// MARK: - TableView Functions
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func displayTenRecentCities() -> Int {
        let recentMaxCount = 10
        
        if self.viewModel.citiesViewedByUser.count > recentMaxCount {
            return recentMaxCount
        } else {
            return self.viewModel.citiesViewedByUser.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredCities.count : displayTenRecentCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardTableViewCell.identifier, for: indexPath) as? DashboardTableViewCell else {
            fatalError("Unable to dequeue DashboardCell in Dashboard")
        }
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        
        let city = inSearchMode ? self.viewModel.filteredCities[indexPath.row] : self.viewModel.citiesViewedByUser[indexPath.row]
        
        cell.configure(with: city)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let inSearchMode = self.viewModel.inSearchMode(searchController)
        let city = inSearchMode ? self.viewModel.filteredCities[indexPath.row] : self.viewModel.citiesViewedByUser[indexPath.row]
        
        let viewModel = CityDetailsViewModel(city)
        let vc = CityDetailsViewController(viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
