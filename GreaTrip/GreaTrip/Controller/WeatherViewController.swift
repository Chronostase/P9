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
    
    //MARK: - Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        setup()
        getWeather()
        
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Func Weather
    @IBAction func AddButton(_ sender: UIButton) {
        pushCitiesTableView()
    }
    
    private func getWeather() {
        WeatherService().getWeather { [weak self] result in
            switch result {
                
            case .success(let weather) :
                guard let weather = weather else {
                    return
                }
                self?.weather = weather
                self?.fillRequestsQueu()
                self?.getImage()
                DispatchQueue.main.async {
                    return self?.tableView.reloadData()
                }
                
            case .failure(let error) :
                print(error.localizedDescription)
                self?.displayAlert("Can't get weather, please check your connection and retry")
                
            }
        }
    }
    
    //MARK: - Func Image
    private func isAllImageFetched() -> Bool {
        return requests?.filter { $0 == .finished }.count == requests?.count
    }
    
    private func getImage(atIndex index: Int = 0) {
        
        requests?[index] = .inProgress
        
        guard let nameArray = self.weather?.list?.map({ $0.weather.first?.icon }) else {
            return
            //Ne peut pas recevoir les noms d'images
        }
        
        WeatherService().getImage(named: nameArray[index] ?? "") { (success, data) in
            self.requests?[index] = .finished
            if success, let image = data {
                // Append or do somethinf with image received
                self.weather?.list?[index].imageData = image
                if self.isAllImageFetched() {
                    DispatchQueue.main.async {
                      return  self.tableView.reloadData()
                    }
                } else {
                    self.getImage(atIndex: index + 1)
                }
            } else {
                self.requests?[index] = .failed
                // Doit relancer la requête fail, attention boucle infinie
                self.getImage(atIndex: index)
            }
        }
    }
    
    //MARK: - Setup
    
    private func fillRequestsQueu() {
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
    
//    func setup() {
//        let button = UIButton(type: .custom)
//        if let image = UIImage(named: "Group") {
//            button.setImage(image, for: .normal)
//            button.tintColor = .white
//        } else {
//            button.setTitle("Add city", for: .normal)
//        }
//        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//        button.addTarget(self, action: #selector(pushCitiesTableView), for: .touchUpInside)
//        let rightButton = UIBarButtonItem(customView: button)
//
//        navigationItem.rightBarButtonItem = rightButton
//    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    @objc func pushCitiesTableView() {
        let storyBoard = UIStoryboard(name: "CitiesTableView", bundle: nil)
        guard let citiesTableViewController = storyBoard.instantiateInitialViewController() as? CitiesTableViewController else {
            return
        }
        citiesTableViewController.delegate = self
        push(citiesTableViewController)
    }
    
    private func displayAlert(_ message: String) {
        
        let alertVC = UIAlertController(title: "Error !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weather?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell,
            let weather = weather?.list?[indexPath.row],
            let data = weather.imageData else {
                return UITableViewCell()
        }
        
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
