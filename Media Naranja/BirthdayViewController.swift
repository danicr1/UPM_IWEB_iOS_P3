//
//  BirthdayViewController.swift
//  Media Naranja
//
//  Created by Daniel  on 22/10/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {

    var birthday: Date = Date()
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Persistencia: si existen, cargamos las preferencias de usuario
        let defaults = UserDefaults.standard
        if let defaultBirthday = defaults.object(forKey: "birthday") as? Date {
            birthdayPicker.date = defaultBirthday
        } else {
            birthdayPicker.date = Date()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Birthday OK" {
            birthday = birthdayPicker.date
        } else if segue.identifier == "Birthday Cancel" {
            // Si le damos a cancel no hay nada que preparar
        }
        
    }
    
    // Esta función cancela el segue si devuelve False
    // Validamos la fecha introducidas y cancelamos el segue si es necesario
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Birthday OK" {
            if birthdayPicker.date > Date() { // Si naces en el futuro
                let alert = UIAlertController(title: "Error", message: "No puedes nacer en el futuro", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true) // Mostramos una alerta para informar al usuario
                return false // Y cancelamos el segue
            } else if let loveDate = UserDefaults.standard.object(forKey: "loveDate") as? Date { // Si hay loveDate guardado
                if birthdayPicker.date > loveDate { //Si naces despúes de enamorarte
                    let alert = UIAlertController(title: "Error", message: "No puedes nacer después de enamorarte", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: true)
                    return false
                } else { // Si 1)Anterior a hoy 2)Hay enamoramiento guardado 3)Nacimiento anterior a enamoramiento
                    return true
                }
            } else { // Si 1)Anterior a hoy 2)No hay enamoramiento guardado
                return true
            }
        } else { // Si le damos a cancelar no hay nada que validar
            return true 
        }
    }
    

}
