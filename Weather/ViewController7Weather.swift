//
//  ViewController7Weather.swift
//  Weather
//
//  Created by Дмитрий Цветков on 04.11.2021.
//

import UIKit
import Foundation
import CoreLocation
import Kingfisher
import Alamofire
import AlamofireImage
class ViewController7Weather: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var TextOutlet: UITextField! //Поле ввода города
    @IBOutlet weak var cityOutlet: UILabel! // Label с названием города
    @IBOutlet weak var tempOutlet: UILabel! // Температура сейчас
    @IBOutlet weak var feelsOutlet: UILabel!
    @IBOutlet weak var feelsOfTemp: UILabel! //Температура, которая ощущается сейчас
    @IBOutlet weak var sinriseOutlet: UILabel! //Время восхода солнца
    @IBOutlet weak var sunsetOutlet: UILabel! //Время захода солнца
    @IBOutlet weak var iconOutlet: UIImageView! // Значок погоды
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var FeelLabel: UILabel!
    @IBOutlet weak var ButtonOutl: UIButton! // Кнопка узнать прогноз
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) { //Функция которая по названию города, возвращает координаты
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        TextOutlet.delegate = self
        sunriseLabel.isHidden = true //Скрываем вначале
        sunsetLabel.isHidden = true
        FeelLabel.isHidden = true
        ButtonOutl.isHidden = true
        self.view.addBackground()
        
    }
    var days7: [Int] = [] //Из api получаем дату в unix, которую потом преобразуем в нормальный вид
    var days7String:[String] = []//Массив дат, отправляем в другой ViewController
    var daysTemp:[String] = [] //Массив температур, отправляем в другой ViewController
    var windSpeed:[Int] = [] // Порыв ветра
    var temps7:[Int] = [] // Массив дневных температур, для совета как одеться
    // MARK: - парсинг
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TextOutlet.resignFirstResponder() //Чтобы убиралась клавиатура после ввода
        let city = TextOutlet.text! //Название города записалось
        var temperatureC: Double? //
        var weatherAPI: Array<Any>?
        var feels: AnyObject?
        var feels2: String? //Описание погоды
        var lon: Double = 0 //Долгота
        var lat: Double = 0 //Широта
        var day: NSMutableDictionary?
        var speed: Double? // скорость ветра
        var tempMas: NSMutableDictionary?
        var feelTemp: NSMutableDictionary?
        var tempMin: Double? //Минимальная температура в этот день
        var tempMax: Double? //Максимальная температура в этот день
        var tempDay: Double? //Температура днем
        var feelsLike: Double? //Ощущается температура
        var sunrise: Int? //Время восхода в Unix
        var sunset: Int? //Время захода в Unix
        var sunriseString: String? //Время восхода
        var sunsetString: String? //Время восхода
        var iconCode: String? //Код значка погоды
        var iconurl: String?
        let address1 = city
        self.getCoordinateFrom(address: address1) { coordinate, error in
        guard let coordinate = coordinate, error == nil else { return }
            lon=coordinate.longitude //Нашли долготу города
            lat=coordinate.latitude //Нашли широту города
            let url2 = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,alerts&appid=936da458c98be7b6cba01046fb772f93&units=metric&lang=ru"
            let URL2 = Foundation.URL(string: "\(url2)")
            URLSession.shared.dataTask(with: URL2!) { data, response, error in
                if let error = error{
                    print(error)
                    return
                }
                guard let data = data else {
                    return}
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                    if let daily = json["daily"] as? Array<Any>{
                        self.daysTemp = [] // обнуляем массив, чтобы менялись значения
                        for i in 0...7{
                            day = daily[i] as? NSMutableDictionary
                            tempMas = day!["temp"] as? NSMutableDictionary
                            speed = day!["wind_speed"] as? Double
                            feelTemp = day!["feels_like"] as? NSMutableDictionary // какая температура в этот день ощущается днем
                            tempMin = tempMas!["min"] as? Double
                            tempMax = tempMas!["max"] as? Double
                            tempDay = feelTemp!["day"] as? Double
                            self.days7.append((day!["dt"] as? Int)!) //Добавляем Unix значение даты в массив
                            let date = NSDate(timeIntervalSince1970: TimeInterval(self.days7[i]))// Переводим в нормальную дату
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "EEEE dd MMM" //Формат даты
                            let dateString = dayTimePeriodFormatter.string(from: date as Date)
                            self.days7String.append(dateString) //Добавляем нормальную дату в массив
                            if self.defaults.value(forKey: "onOffKey3") != nil{
                                let switchON: Bool = self.defaults.value(forKey: "onOffKey3")  as! Bool
                                if switchON == true{
                                    self.windSpeed.append(lroundf(Float(speed!))) //В м/с
                                            }
                                            else if switchON == false{
                                                self.windSpeed.append(lroundf(Float(speed!*3.6))) // В км/ч
                                            }
                            }

                            self.temps7.append(lroundf(Float(tempDay!))) //Добавляем в массив дневных температур
                            if self.defaults.value(forKey: "onOffKey1") != nil{
                                let switchON: Bool = self.defaults.value(forKey: "onOffKey1")  as! Bool
                                if switchON == true{
                                    self.daysTemp.append("Min: \(lroundf(Float(tempMin!)))°C, Max: \(lroundf(Float(tempMax!)))°C") //Для цельсия
                                            }
                                            else if switchON == false{
                                                self.daysTemp.append("Min: \(lroundf(Float(tempMin!*1.8+32)))°F, Max: \(lroundf(Float(tempMax!*1.8+32)))°F") // Для Фаренгейта
                                            }
                            }
                        }
                    }
                    if let current = json["current"] as? NSMutableDictionary{
                        temperatureC = current["temp"] as? Double
                        weatherAPI = current["weather"] as? Array<Any>
                        feels = weatherAPI![0] as AnyObject
                        feels2 = feels!["description"] as? String
                        feelsLike = current["feels_like"] as? Double
                        sunrise = current["sunrise"] as? Int
                        sunset = current["sunset"] as? Int
                        let date = NSDate(timeIntervalSince1970: TimeInterval(sunrise!)) //Время для восхода
                        let date2 = NSDate(timeIntervalSince1970: TimeInterval(sunset!)) //Время для захода
                        let dayTimePeriodFormatter = DateFormatter()
                        if self.defaults.value(forKey: "onOffKey2") != nil{
                            let switchON: Bool = self.defaults.value(forKey: "onOffKey2")  as! Bool
                            if switchON == true{
                                dayTimePeriodFormatter.dateFormat = "hh:mm a"
                                        }
                                        else if switchON == false{
                                            dayTimePeriodFormatter.dateFormat = "HH:mm"
                                        }
                        }
                        sunriseString = dayTimePeriodFormatter.string(from: date as Date)
                        sunsetString = dayTimePeriodFormatter.string(from: date2 as Date)
                        iconCode = feels!["icon"] as? String
                        iconurl = "https://openweathermap.org/img/wn/" + iconCode! + ".png"
                        
                    }
                    Dispatch.DispatchQueue.main.async {
                        let url = URL(string: iconurl!)
                        _ = self.iconOutlet.kf.setImage(with: url!) //Kingfisher для загрузки изображения по Api
                        if sunriseString != nil{
                            self.sinriseOutlet.adjustsFontSizeToFitWidth = true;
                            self.sinriseOutlet.numberOfLines = 1
                            self.sunsetOutlet.adjustsFontSizeToFitWidth = true;
                            self.sunsetOutlet.numberOfLines = 1
                            self.sinriseOutlet.text = "\(sunriseString!)"
                            self.sunsetOutlet.text = "\(sunsetString!)"
                            self.sunriseLabel.isHidden = false //Показываем
                            self.sunsetLabel.isHidden = false
                        }
                        if feelsLike != nil {
                            if self.defaults.value(forKey: "onOffKey1") != nil{
                                let switchON: Bool = self.defaults.value(forKey: "onOffKey1")  as! Bool
                                if switchON == true{
                                    self.feelsOfTemp.text = "\(lroundf(Float(feelsLike!)))°C" //Чувствуется температура в цельсиях
                                            }
                                            else if switchON == false{
                                                self.feelsOfTemp.text = "\(lroundf(Float((feelsLike!*1.8)+32)))°F" //Чувствуется температура в фаренгейтах
                                            }
                            }
                            self.FeelLabel.isHidden = false
                        }else{
                            self.feelsOfTemp.text = "error"
                        }
                        if feels != nil{
                                            self.feelsOutlet.text = "\(feels2!)"
                                        }else{
                                            self.feelsOutlet.text = "error"
                                        }
                        if city == city {
                                            self.cityOutlet.text = city
                            self.ButtonOutl.isHidden = false
                                        }else{
                                            self.cityOutlet.text = "error"
                                        }
                                        if let temperatureC = temperatureC{
                                            self.tempOutlet.adjustsFontSizeToFitWidth = true;
                                            self.tempOutlet.numberOfLines = 1
                                            if self.defaults.value(forKey: "onOffKey1") != nil{
                                                let switchON: Bool = self.defaults.value(forKey: "onOffKey1")  as! Bool
                                                if switchON == true{
                                                    self.tempOutlet.text = "\(lroundf(Float(temperatureC)))°C" //Температура в цельсиях
                                                            }
                                                            else if switchON == false{
                                                                self.tempOutlet.text = "\(lroundf(Float(temperatureC*1.8+32)))°F" //Температура в фаренгейтах
                                                            }
                                            }
                                        }
                                        else {
                                            self.tempOutlet.text = "error"
                                        }
                                    }
                    
            }
                catch let errorOfJson{
                    Swift.print(errorOfJson)
                }
            }.resume()
            
        }
        return true
            
    }
    //MARK: - Передача данных 8-ому контроллеру
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard segue.identifier == "mySegue" else { return }
        guard let destinationVC: ViewController8Forecast = segue.destination as? ViewController8Forecast else { return }
        destinationVC.days = self.days7String
        destinationVC.temps = self.daysTemp
        destinationVC.tempsss7 = self.temps7
        destinationVC.windSpeeds = self.windSpeed
   }
}

