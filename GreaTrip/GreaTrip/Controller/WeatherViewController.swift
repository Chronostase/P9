//
//  ViewController.swift
//  GreaTrip
//
//  Created by Thomas on 31/03/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var weather: WeatherArray?
    var requests: [RequestStatement]?
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getWeather()
    }
    
    //MARK: - Call API
    
    private func getWeather() {
        WeatherService().getWeather { [weak self] result in
            switch result {
                
            case .success(let weather) :
                guard let weather = weather else {
                    return
                }
                self?.weather = weather
                self?.fillRequestsQueue()
                self?.getImage()
                DispatchQueue.main.async {
                    return self?.tableView.reloadData()
                }
                
            case .failure(let error) :
                print(error.localizedDescription)
                self?.displayAlert(Constants.Error.wifiError)
                return
            }
        }
    }
    
    private func getImage(atIndex index: Int = 0) {
        
        requests?[index] = .inProgress
        
        guard let nameArray = self.weather?.list?.map({ $0.weather.first?.icon }) else {
            return
            //Ne peut pas recevoir les noms d'images
        }
        
        WeatherService().getImage(named: nameArray[index] ?? "") { [weak self] result in
            self?.requests?[index] = .finished
            switch result {
                
            case .success(let image):
                self?.weather?.list?[index].imageData = image
                guard self?.isAllImageFetched() == true else {
                    self?.getImage(atIndex: index + 1)
                    return
                }
                DispatchQueue.main.async {
                    return  self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                self?.requests?[index] = .failed
                // Doit relancer la requête fail, attention boucle infinie
                self?.getImage(atIndex: index)
            }
        }
    }
    
    
    //MARK: - Setup
    
    private func isAllImageFetched() -> Bool {
        return requests?.filter { $0 == .finished }.count == requests?.count
    }
    
    private func fillRequestsQueue() {
        guard let weatherArray = self.weather?.list else {
            return
            // Ne peut pas récupérer la list des temps
        }
        for _ in weatherArray {
            if requests == nil {
                requests = [.waiting]
            } else {
                requests?.append(.waiting)
            }
        }
    }
    
    private func setup() {
        setupCustomCell()
        setTableViewDataSource()
        setupNavigationBarButton()
    }
    
    private func setupNavigationBarButton() {
        let button = UIButton(type: .custom)
        guard let image = UIImage(named: Constants.Button.name) else {
            return
        }
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.addTarget(self, action: #selector(pushCitiesTableView), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: button)
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setTableViewDataSource() {
        tableView.dataSource = self
    }
    
    private func setupCustomCell() {
        let nib = UINib(nibName: Constants.Cell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.Cell.identifier)
        
        
    }
    
    @objc func pushCitiesTableView() {
        let storyBoard = UIStoryboard(name: Constants.Storyboard.name, bundle: nil)
        guard let citiesTableViewController = storyBoard.instantiateInitialViewController() as? CitiesTableViewController else {
            return
        }
        citiesTableViewController.delegate = self
        push(citiesTableViewController)
    }
    
    private func displayAlert(_ message: String) {
        
        let alertVC = UIAlertController(title: Constants.Error.errorTitle, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: Constants.Error.actionTitle, style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weather?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.identifier, for: indexPath) as? CustomTableViewCell,
            let weather = weather?.list?[indexPath.row],
            let data = weather.imageData else {
                return UITableViewCell()
        }
        cell.isUserInteractionEnabled = false
        cell.configureAllCell(name: weather.name, temperature: Int(weather.main.temp), image: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("enter in did select")
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
