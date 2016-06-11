//
//  TechCompanyDetailViewController.swift
//  TechCompanies
//
//  Created by Alexandro on 6/9/16.
//  Copyright © 2016 Holberton School. All rights reserved.
//

import UIKit

class TechCompanyDetailViewController: UIViewController {

    var entity:Entity!
    
    @IBOutlet weak var label_entity: UILabel!
    @IBOutlet weak var image_entity: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.entity != nil {
            self.title = entity.name
            self.label_entity.text = entity.town
            self.image_entity.image = UIImage(imageLiteral: entity.imageName)
            self.image_entity.contentMode = .ScaleAspectFit
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
