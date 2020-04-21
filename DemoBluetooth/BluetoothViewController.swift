import UIKit

class BluetoothViewController: UIViewController {
    
    init(bluetoothManager: BluetoothManager) {
        self.bluetoothManager = bluetoothManager
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setup()
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var uuidDisplayContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var uuidDisplay: UITextView = {
        let data = UITextView()
        data.text = bluetoothManager.uuid
        data.isScrollEnabled = false // required
        data.translatesAutoresizingMaskIntoConstraints = false // required
        return data
    }()
    
    private lazy var covidStartButtonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var covidStartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Advertising", for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(covidStart(sender:)), for: .touchUpInside)

        button.layer.cornerRadius = 8

        return button
    }()
    
    private var bluetoothManager: BluetoothManager
    
    @objc private func covidStart(sender: UIButton) {
        bluetoothManager.delegate = self
        bluetoothManager.covidStart()
    }

}

extension BluetoothViewController {
    private func setup() {
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(uuidDisplayContainer)
        stackView.setCustomSpacing(16, after: uuidDisplayContainer)
        stackView.addArrangedSubview(covidStartButtonContainer)

        uuidDisplayContainer.addSubview(uuidDisplay)
        covidStartButtonContainer.addSubview(covidStartButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
              uuidDisplay.leadingAnchor.constraint(equalTo: uuidDisplayContainer.leadingAnchor, constant: 32),
              uuidDisplay.trailingAnchor.constraint(equalTo: uuidDisplayContainer.trailingAnchor, constant: -32),
              uuidDisplay.topAnchor.constraint(equalTo: uuidDisplayContainer.topAnchor),
              uuidDisplay.bottomAnchor.constraint(equalTo: uuidDisplayContainer.bottomAnchor)
          ])

        NSLayoutConstraint.activate([
            covidStartButton.leadingAnchor.constraint(equalTo: covidStartButtonContainer.leadingAnchor, constant: 32),
            covidStartButton.trailingAnchor.constraint(equalTo: covidStartButtonContainer.trailingAnchor, constant: -32),
            covidStartButton.topAnchor.constraint(equalTo: covidStartButtonContainer.topAnchor),
            covidStartButton.bottomAnchor.constraint(equalTo: covidStartButtonContainer.bottomAnchor)
        ])
        
    }
}

extension BluetoothViewController: BluetoothManagerDelegate {
    func peripheralsDidUpdate() {
        print(bluetoothManager.peripherals.mapValues{$0.name})
    }
}
