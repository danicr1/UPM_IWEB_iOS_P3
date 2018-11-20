//
//  LoveViewController.swift
//  Media Naranja
//
//  Created by Daniel  on 22/10/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class LoveViewController: UIViewController {

    var loveDate: Date = Date()
    
    @IBOutlet weak var loveDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Persistencia: si existen, cargamos las preferencias de usuario
        let defaults = UserDefaults.standard
        if let defaultLoveDate = defaults.object(forKey: "loveDate") as? Date {
            loveDatePicker.date = defaultLoveDate
        } else {
            loveDatePicker.date = Date()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Love OK" {
            loveDate = loveDatePicker.date
        } else if segue.identifier == "Love Cancel" {
            // Si le damos a cancel no hay nada que preparar
        }
        
    }
    
    // Esta función cancela el segue si devuelve False
    // Validamos la fecha introducidas y cancelamos el segue si es necesario
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Love OK" {
            if loveDatePicker.date > Date() { // Si la fecha es posterior a hoy
                let alert = UIAlertController(title: "Error", message: "No puedes haberte enamorado en el futuro", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return false 
            } else if let birthday = UserDefaults.standard.object(forKey: "birthday") as? Date { // Si hay birthday guardado
                if loveDatePicker.date < birthday { // Si te enamoras antes de nacer
                    let alert = UIAlertController(title: "Error", message: "No puedes enamorarte antes de nacer", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: true)
                    return false
                } else { // 1)Anterior a hoy 2)Hay birthday guardado 3)Enamorado despues de birthday
                    return true
                }
            } else { // Si 1)Anterior a hoy 2)No hay un birthday guardado
                return true // Fecha válida, procede el segue
            }
        } else { // Si le damos a cancelar
            return true //No hay nada que validar, procede el segue
        }
    }
    
}
