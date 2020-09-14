import UIKit
import PlaygroundSupport

protocol ColorChangeDelegate {
    func colorChanged(index: Int)
}

// model
class Color {
    var colorIndex = 0
    let colorName = ["red", "green", "blue", "purple"]
    private let color = [UIColor.red, UIColor.green, UIColor.blue, UIColor.purple]
    
    func name(_ index: Int) -> String {
        return colorName[index%colorName.count]
    }
    
    func color(_ index: Int) -> UIColor {
        return color[index%color.count]
    }
}

// above an example of encapsulation..

// destination view controller
class DestinationViewController: UIViewController {
    let colors = Color()
    var currentColor = 0
    var delegate: ColorChangeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentedControl = UISegmentedControl(items: colors.colorName)
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
}

// ViewController
class ViewController: UIViewController, ColorChangeDelegate {
    let colors = Color()
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

// View


PlaygroundPage.current.liveView = ViewController()
