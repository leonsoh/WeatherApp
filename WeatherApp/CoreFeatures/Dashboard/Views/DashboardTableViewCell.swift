//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    static let identifier = "DashboardTableViewCell"
    
    private(set) var weather: WeatherResponse!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    public func configure(with weather: WeatherResponse) {
        self.weather = weather
        let cityName = weather.data.request[0].name
        
        self.cityLabel.text = cityName
    }
    
    private func setupUI() {
        self.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            cityLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            cityLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
    
}
