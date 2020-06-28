//
//  WeatherServiceTest.swift
//  GreaTripTests
//
//  Created by Thomas on 16/06/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

@testable import GreaTrip
import XCTest

class WeatherServiceTest: XCTestCase {
    private let weatherFakeResponseData = WeatherFakeResponseData()
    private let expectation = XCTestExpectation(description: "Wait for queue change.")
    
    //MARK: - Methods GetWeather
    
    func testGetWeatherShouldGetFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: nil, error: weatherFakeResponseData.error), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeather { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldGetFailedCallbackIfNoResponseAndData() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: nil, error: nil), baseUrl: Constants.Network.Weather.baseUrl)
        weatherService.getWeather { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)

            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }

        //Then
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldGetFailedCallbackIfResponseNotHTTP() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherCorrectData, response: weatherFakeResponseData.responseNotHTTP, error: nil), baseUrl: Constants.Network.Weather.baseUrl)

        weatherService.getWeather { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)

            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }

        //Then
        wait(for: [expectation], timeout: 0.1)
        // (...)
    }

    func testGetWeatherShouldGetFailedCallbackIfIncorrectResponseStatusCode() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherCorrectData, response: weatherFakeResponseData.responseKo, error: nil), baseUrl: Constants.Network.Weather.baseUrl)

        weatherService.getWeather { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)

            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }

        //Then
        wait(for: [expectation], timeout: 0.1)
        // (...)
    }

    func testGetWeatherShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherIncorrectData, response: weatherFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Weather.baseUrl)

        weatherService.getWeather { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)

            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }

        //Then
        wait(for: [expectation], timeout: 0.01)
        // (...)
    }
    
    func testGetWeatherShouldGetFailedCallbackIfResponseOkAndNoData() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: weatherFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Weather.baseUrl)

        weatherService.getWeather { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)

            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }

        //Then
        wait(for: [expectation], timeout: 0.01)
        // (...)
    }

    func testGetWeatherShouldGetSuccessCallbackIfNoErrorCorrectData() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherCorrectData, response: weatherFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Weather.baseUrl)

        weatherService.getWeather { result in
            switch result {
            case .success(let weather):
                XCTAssertNotNil(weather)
                let name = "Reims"
                let temp = 19
                let icon = "04d"
                
                XCTAssertEqual(name, weather?.list?.first?.name)
                XCTAssertEqual(temp, Int((weather?.list?.first?.main.temp)!))
                XCTAssertEqual(icon, weather?.list?.first?.weather.first?.icon)

            case .failure(let error) :
                XCTAssertNil(error)
            }
            self.expectation.fulfill()
        }

        //Then
        wait(for: [expectation], timeout: 0.01)
        // (...)
    }
    
    func testGetWeatherShouldGetFailedCallbackIfIncorrectRequest() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: weatherFakeResponseData.responseKo, error: nil))

        weatherService.getWeather { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)

            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }

        //Then
        wait(for: [expectation], timeout: 0.01)
        // (...)
    }
    
    
    
    //MARK: - Method GetWeatherByName
    
    func testGetWeatherByNameShouldGetFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: nil, error: weatherFakeResponseData.error), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeatherByName(cityName: "Lyon") { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherByNameShouldGetFailedCallbackIfInccorectResponse() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherByNameCorrectData, response: weatherFakeResponseData.responseKo, error: nil), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeatherByName(cityName: "Lyon") { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherByNameShouldGetFailedCallbackIfNotHTTPResponse() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherByNameCorrectData, response: weatherFakeResponseData.responseNotHTTP, error: nil), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeatherByName(cityName: "Lyon") { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherByNameShouldGetFailedCallbackIfNoDataAndResponse() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: nil, error: nil), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeatherByName(cityName: "Lyon") { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherByNameShouldGetFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.imageCorrectData, response: weatherFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeatherByName(cityName: "Lyon") { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherByNameShouldGetSuccedCallbackIfNoErrorCorrectData() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherByNameCorrectData, response: weatherFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeatherByName(cityName: "Lyon") { result in
            switch result {
            case .success(let weather):
                XCTAssertNotNil(weather)
                let name = "Arrondissement de Lyon"
                let temp = 27.79
                let iconName = "01d"
                
                XCTAssertEqual(weather?.name, name)
                XCTAssertEqual(weather?.weather.first?.icon, iconName)
                XCTAssertEqual(weather?.main.temp, temp)
                
            case .failure(let error) :
                XCTAssertNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherByNameShouldGetSuccedCallbackIfWhiteSpace() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherByNameCorrectData, response: weatherFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeatherByName(cityName: "    Lyon   ".formattedToRequest) { result in
            switch result {
            case .success(let weather):
                XCTAssertNotNil(weather)
                let name = "Arrondissement de Lyon"
                let temp = 27.79
                let iconName = "01d"
                
                XCTAssertEqual(weather?.name, name)
                XCTAssertEqual(weather?.weather.first?.icon, iconName)
                XCTAssertEqual(weather?.main.temp, temp)
                
            case .failure(let error) :
                XCTAssertNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherByNameShouldGetSuccedCallbackIfDote() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherByNameCorrectData, response: weatherFakeResponseData.responseOk, error: nil), baseUrl: Constants.Network.Weather.baseUrl)
        
        //When
        weatherService.getWeatherByName(cityName: "Lyon.".formattedToRequest) { result in
            switch result {
            case .success(let weather):
                XCTAssertNotNil(weather)
                let name = "Arrondissement de Lyon"
                let temp = 27.79
                let iconName = "01d"
                
                XCTAssertEqual(weather?.name, name)
                XCTAssertEqual(weather?.weather.first?.icon, iconName)
                XCTAssertEqual(weather?.main.temp, temp)
                
            case .failure(let error) :
                XCTAssertNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherByNameShouldGetFailedCallbackIfIncorrectRequest() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: weatherFakeResponseData.responseKo, error: nil))

        weatherService.getWeatherByName(cityName: "Lyon") { result in
            switch result {
            case .success(let weather):
                XCTAssertNil(weather)

            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }

        //Then
        wait(for: [expectation], timeout: 0.01)
        // (...)
    }
    
    
    //MARK: - Method GetImage
    
    func testGetImageShouldGetFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: nil, error: weatherFakeResponseData.error))
        
        //When
        weatherService.getImage(named: "image") { result in
            switch result {
            case .success(let image):
                XCTAssertNil(image)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetImageShouldGetFailedCallbackIfNoResponse() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: nil, error: nil))
        
        //When
        weatherService.getImage(named: "image") { result in
            switch result {
            case .success(let image):
                XCTAssertNil(image)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetImageShouldGetFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherCorrectData, response: weatherFakeResponseData.responseNotHTTP, error: nil))
        
        //When
        weatherService.getImage(named: "image") { result in
            switch result {
            case .success(let image):
                XCTAssertNil(image)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetImageShouldGetFailedCallbackIfResponseKo() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.weatherCorrectData, response: weatherFakeResponseData.responseKo, error: nil))
        
        //When
        weatherService.getImage(named: "image") { result in
            switch result {
            case .success(let image):
                XCTAssertNil(image)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetImageShouldGetFailedCallbackIfEmptyData() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: nil, response: weatherFakeResponseData.responseOk, error: nil))
        
        //When
        weatherService.getImage(named: "image") { result in
            switch result {
            case .success(let image):
                XCTAssertNil(image)
                
            case .failure(let error) :
                XCTAssertNotNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetImageShouldSuccessCallbackNoErrorCorrectData() {
        // Given
        let weatherService = WeatherService(session: UrlSessionFake(data: weatherFakeResponseData.imageCorrectData, response: weatherFakeResponseData.responseOk, error: nil))
        
        //When
        weatherService.getImage(named: "image") { result in
            switch result {
            case .success(let image):
                guard let image = image else {
                    return
                }
//                guard let icon = UIImage(data: image) else {
//                    return
//                }
                XCTAssertNotNil(UIImage(data: image))
            case .failure(let error) :
                XCTAssertNil(error)
            }
            self.expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.01)
    }
}
