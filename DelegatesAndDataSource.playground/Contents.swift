import UIKit
import PlaygroundSupport

//MARK: protocols

protocol ColorChangeDelegate {
    func colorChanged(index: Int)
}

protocol ColorChangeDataSource {
    func numberOfColors() -> Int
    func colorName(for index: Int) -> String
    func colorObject(for index: Int) -> UIColor
}

//MARK: Model

class Color {
    var colorIndex = 0
    var delegate: ColorChangeDataSource?
    
    func name(_ index: Int) -> String {
        //return colorName[index%colorName.count]
        colorIndex = index%delegate!.numberOfColors()
        return delegate!.colorName(for: colorIndex)
    }
    
    func color(_ index: Int) -> UIColor {
        //return color[index%color.count]
        colorIndex = index%delegate!.numberOfColors()
        return delegate!.colorObject(for: colorIndex)
    }
}

//MARK: View+Controllers

class DestinationViewController: UIViewController, ColorChangeDataSource {
    
    let colors = Color()
    var currentColor = 0
    let colorName = ["red", "green", "blue", "purple"]
    private let color = [UIColor.red, UIColor.green, UIColor.blue, UIColor.purple]

    var delegate: ColorChangeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colors.delegate = self
        let segmentedControl = UISegmentedControl(items: colorName)
        segmentedControl.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        view.backgroundColor = colors.color(currentColor)
        segmentedControl.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        segmentedControl.tintColor = UIColor.black
        view.addSubview(segmentedControl)
    }
    
    @IBAction func changeColor(sender: UISegmentedControl) {
        currentColor = sender.selectedSegmentIndex
        view.backgroundColor = colors.color(currentColor)
        delegate?.colorChanged(index: currentColor)
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: data source
    func numberOfColors() -> Int {
        return colorName.count
    }
    
    func colorName(for index: Int) -> String {
        return colorName[index]
    }
    
    func colorObject(for index: Int) -> UIColor {
        return color[index]
    }

}

class ViewController: UIViewController, ColorChangeDelegate, ColorChangeDataSource {
    let colors = Color()
    let colorName = ["red", "green", "blue", "purple"]
    private let color = [UIColor.red, UIColor.green, UIColor.blue, UIColor.purple]

    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colors.delegate = self
        view.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        button.setTitle("Choose Color", for: .normal)
        button.backgroundColor = UIColor.darkGray
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
       
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        //count += 1
        //view.backgroundColor = colors.color(count)
        let destinationVC = DestinationViewController()
        destinationVC.delegate = self
        destinationVC.currentColor = count
        present(destinationVC, animated: true, completion: nil)
    }
    
    func colorChanged(index: Int) {
        count = index
        view.backgroundColor = colors.color(count)
    }
    
    //MARK: data source
    func numberOfColors() -> Int {
        return colorName.count
    }
    
    func colorName(for index: Int) -> String {
        return colorName[index]
    }
    
    func colorObject(for index: Int) -> UIColor {
        return color[index]
    }
}

PlaygroundPage.current.liveView = ViewController()
