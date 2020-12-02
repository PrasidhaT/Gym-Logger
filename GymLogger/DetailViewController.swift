//
//  DetailViewController.swift
//  GymLogger
//
//  Created by Prasidha Timsina on 11/12/20.
//

import UIKit



class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var liftingDayField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    
    @IBAction func deleteItem(_ sender: UIBarButtonItem) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = scene.delegate as? SceneDelegate
        else {
            return
        }
        let itemStore = sceneDelegate.itemStore
        itemStore.removeItem(item)
        self.navigationController?.popViewController(animated: true)
    }

    
    
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        weightField.text = item.liftingDay
        liftingDayField.text = numberFormatter.string(from: NSNumber(value: item.weight))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.liftingDay = weightField.text
        if let valueText = liftingDayField.text,
           let value = numberFormatter.number(from: valueText) {
            item.weight = value.intValue
        } else {
        item.weight = 0 }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
}
