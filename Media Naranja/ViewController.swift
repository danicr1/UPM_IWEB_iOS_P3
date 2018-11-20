//
//  ViewController.swift
//  Media Naranja
//
//  Created by Daniel  on 18/10/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myBirthday: Date? {
        didSet{
            updatePartyLabel()
        }
    }
    var myLoveDate: Date? {
        didSet{
            updatePartyLabel()
        }
    }

    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var loveDateLabel: UILabel!
    @IBOutlet weak var partyDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBirthdayLabel()
        updateLoveDateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Usando el UserDefaults no es necesario pasarle nada a los VC destino
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Select Birthday" {
            if let bvc = segue.destination as? BirthdayViewController {
                if let b = myBirthday {
                    bvc.birthday = b
                }
            }
            
        } else if segue.identifier == "Select Love" {
            if let lvc = segue.destination as? LoveViewController {
                if let l = myLoveDate {
                    lvc.loveDate = l
                }
            }
        }
    }
    */
 
    // MARK: - Funciones para unwinds
    // Estas funciones se ejecutan cuando se realiza el segue unwind
    // después del prepare(for segue:) en el ViewController de origen
    
    // Segue unwind desde BirthdayViewController
    @IBAction func backFromBirthday (_ segue: UIStoryboardSegue) {
        if segue.identifier == "Birthday OK" {
            if let bvc = segue.source as? BirthdayViewController {
                myBirthday = bvc.birthday
                saveBirthday()
                updateBirthdayLabel()
            }
        } else if segue.identifier == "Birthday Cancel" {
            // Si se cancela la seleccion no hay que hacer nada
        }
    }
    
    // Segue unwind desde LoveViewController
    @IBAction func backFromLove (_ segue: UIStoryboardSegue) {
        if segue.identifier == "Love OK" {
            if let lvc = segue.source as? LoveViewController {
                myLoveDate = lvc.loveDate
                saveLoveDate()
                updateLoveDateLabel()
            }
            
        } else if segue.identifier == "Love Cancel" {
            // Si se cancela la seleccion no hay que hacer nada
        }
    }
    
    // MARK: - Funciones auxiliares
    
    // Guarda la fecha de nacimiento introducida en UserDefaults
    func saveBirthday() {
        let defaults = UserDefaults.standard
        defaults.set(myBirthday, forKey: "birthday")
        defaults.synchronize()
    }
    
    // Actualiza el texto de birthdayLabel
    func updateBirthdayLabel() {
        let defaults = UserDefaults.standard
        if let defaultBirthday = defaults.object(forKey: "birthday") as? Date {
            myBirthday = defaultBirthday // Cargamos el valor guardado
            let dateString: String = formatDate(myBirthday!)
            birthdayLabel.text = dateString // Y actualizamos el texto
            
        } else { // Si no hay un valor guardado en UserDefaults
            birthdayLabel.text = "No hay fecha"
        }
    }
    
    // Guarda la fecha de enamoramiento introducida en UserDefaults
    func saveLoveDate() {
        let defaults = UserDefaults.standard
        defaults.set(myLoveDate, forKey: "loveDate")
        defaults.synchronize()
    }
    
    // Actualiza el texto de loveDateLabel
    func updateLoveDateLabel() {
        let defaults = UserDefaults.standard
        if let defaultLoveDate = defaults.object(forKey: "loveDate") as? Date {
            myLoveDate = defaultLoveDate
            let dateString: String = formatDate(myLoveDate!)
            loveDateLabel.text = dateString
            
        } else {
            loveDateLabel.text = "No hay fecha"
        }
    }
    
    // Calcula la fecha de la fiesta y actualiza su label
    func updatePartyLabel() {
        if let bday = myBirthday {
            if let love = myLoveDate {
                let halfLife: TimeInterval = love.timeIntervalSince(bday)
                let partyDate = love + halfLife
                let partyString = formatDate(partyDate)
                partyDateLabel.text = partyString
            } else {
                partyDateLabel.text = "Falta fecha de enamoramiento"
            }
        } else {
            partyDateLabel.text = "Falta fecha de nacimiento"
        }
    }
    
    // Devuelve un string con la fecha pasada como parametro
    // en formato tipo "10 de octubre de 2018"
    func formatDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale(identifier: "es_ES")
            
            let texto = dateFormatter.string(from: date)
            return texto
    }

}

