import UIKit
import Lottie

class ViewController: UIViewController {
    
    private struct Constants {
        static let speedDictionary = [0: 0.5, 1: 1.0, 2:2.0]
        static let colorDictionary = [0: UIColor.black, 1: UIColor.gray, 2: UIColor.white]
        static let titleFontSize: CGFloat = 30
        static let buttonCornerRandiuse: CGFloat = 10
        static let buttonFontSize: CGFloat = 20
        static let labelFontSize: CGFloat = 25
        static let showButtonFontSize: CGFloat = 20
        static let colorAnimationDuration: CGFloat = 4
    }
    private var choosenAnimNumber = 0
    private let animationView = LottieAnimationView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите анимацию"
        label.font = .systemFont(ofSize: Constants.titleFontSize)
        label.textColor = UIColor.black.withAlphaComponent(0)
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = Constants.buttonCornerRandiuse
        button.backgroundColor = .white
        return button
    }()
    
    
    //Можно просто эти три кнопочки циклом сдлеать в функции, код свободнее сделать
    private let button1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("animation 1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        button.tag = 1
        return button
    }()
    
    private let button2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("animation 2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize)
        button.tag = 2
        return button
    }()
    
    private let button3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("animation 3", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        button.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize)
        button.tag = 3
        return button
    }()
    
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.labelFontSize)
        label.text = "Speed"
        return label
    }()
    
    private let segment1: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["0.5x", "1.0x", "2.0x"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.tintColor = .black
        segmentControl.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return segmentControl
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.labelFontSize)
        label.text = "Color"
        return label
    }()
    
    private let segment2: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Black", "Gray", "White"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.tintColor = .black
        segmentControl.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return segmentControl
    }()
    
    private let showButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        button.titleLabel?.font = .systemFont(ofSize: Constants.showButtonFontSize)
        return button
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Запустить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        return activityIndicator
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor]
        view.layer.addSublayer(gradientLayer)
        
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = gradientLayer.colors
        colorAnimation.toValue = [UIColor.blue.cgColor, UIColor.purple.cgColor, UIColor.purple.cgColor]
        colorAnimation.duration = Constants.colorAnimationDuration
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.fillMode = CAMediaTimingFillMode.forwards
        colorAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = .infinity
        gradientLayer.add(colorAnimation, forKey: nil)
        
        addStartSubViews()
        setupStartConstraints()
        button.addTarget(self, action: #selector(animateLabel), for: .touchUpInside)
        animationButtonsControl()
        
        view.addSubview(loader)
        loader.center = view.center
    }

}

private extension ViewController {
    private func addStartSubViews() {
        [
            titleLabel,
            button
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupStartConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func animateLabel() {
        
        UIView.transition(with: titleLabel, duration: 0.4, options: [.transitionCrossDissolve]) {
            self.titleLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
        UIView.animate(withDuration: 0.5) {
            self.button.backgroundColor = UIColor.white.withAlphaComponent(0)
        }
        
        addMainSubviews()
        setupMainConstraints()
        
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(callback), userInfo: nil, repeats: false)
    }
    
    @objc func callback() {
        button.removeFromSuperview()
        UIView.transition(with: titleLabel, duration: 1, options: [.transitionCrossDissolve, .autoreverse, .repeat]) {
            self.titleLabel.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
    
    @objc func animationButtonsTapped(sender: UIButton) {
        [
            button1,
            button2,
            button3
        ].forEach() {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        }
        
        sender.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        choosenAnimNumber = sender.tag
    }
    
    private func animationButtonsControl() {
        [
            button1,
            button2,
            button3
        ].forEach() {
            $0.addTarget(self, action: #selector(animationButtonsTapped), for: .touchUpInside)
        }
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
    }
    
    @objc func mainButtonTapped() {
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(callbackMainButton), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mainReverseAnim), userInfo: nil, repeats: false)
        UIView.animate(withDuration: 1) {
            self.mainButton.transform = .init(scaleX: 1.2, y: 1.2)
        }
    }
    
    @objc func mainReverseAnim() {
        UIView.animate(withDuration: 1) {
            self.mainButton.transform = .identity
        }
    }
    
    @objc func callbackMainButton() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(animate), userInfo: nil, repeats: false)
        loader.isHidden = false
    }
    
    @objc func animate() {
        loader.isHidden = true
        lottieAnimate(speed: Constants.speedDictionary[segment1.selectedSegmentIndex] ?? 0, backgroundColor: Constants.colorDictionary[segment2.selectedSegmentIndex] ?? .white, animationName: "animation" + String(choosenAnimNumber))
    }
    
    private func lottieAnimate(speed: CGFloat, backgroundColor: UIColor, animationName: String) {
        animationView.animation = LottieAnimation.named(animationName)
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = speed
        animationView.backgroundColor = backgroundColor
        view.addSubview(animationView)
        animationView.play()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: false)
    }
    
    @objc func timerUpdate(sender: Timer) {
        if !animationView.isAnimationPlaying {
            animationView.removeFromSuperview()
        } else {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: false)
        }
    }
    
    private func addMainSubviews() {
        [
            button1,
            button2,
            button3,
            segment1,
            segment2,
            speedLabel,
            colorLabel,
            mainButton
            
        ].forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupMainConstraints() {
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            button1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            button1.heightAnchor.constraint(equalToConstant: 40),
            
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            button2.widthAnchor.constraint(equalTo: button1.widthAnchor),
            button2.heightAnchor.constraint(equalTo: button1.heightAnchor),
            
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20),
            button3.widthAnchor.constraint(equalTo: button1.widthAnchor),
            button3.heightAnchor.constraint(equalTo: button1.heightAnchor),
            
            segment1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            segment1.heightAnchor.constraint(equalToConstant: 40),
            segment1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segment1.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            
            segment2.widthAnchor.constraint(equalTo: segment1.widthAnchor),
            segment2.heightAnchor.constraint(equalTo: segment1.heightAnchor),
            segment2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segment2.topAnchor.constraint(equalTo: segment1.bottomAnchor, constant: 60),
            
            speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedLabel.centerYAnchor.constraint(equalTo: segment1.topAnchor, constant: -20),
            
            colorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorLabel.centerYAnchor.constraint(equalTo: segment2.topAnchor, constant: -20),
            
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            mainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            mainButton.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
}
