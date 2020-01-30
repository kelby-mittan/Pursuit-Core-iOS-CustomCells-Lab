import UIKit

class RanUserController: UIViewController {
    
    private let userView = UserView()
    
    private var users = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.userView.collectionView.reloadData()
            }
        }
    }
    
    
    override func loadView() {
        view = userView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Contacts"
        
        userView.collectionView.dataSource = self
        userView.collectionView.delegate = self
        
        userView.collectionView.register(UINib(nibName: "RanUserCell", bundle: nil), forCellWithReuseIdentifier: "ranUserCell")
        
        loadUsers()
    }
    
    private func loadUsers() {
        guard let file = Bundle.main.url(forResource: "randomUserSampleResponse", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
            let data = try Data(contentsOf: file)
            users = User.getUsers(from: data)
        } catch {
            fatalError("contents failed to load \(error)")
        }
    }
}

extension RanUserController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ranUserCell", for: indexPath) as? RanUserCell else {
            fatalError("could not downcast to RanUserCell")
        }
        let user = users[indexPath.row]
        cell.configureCell(user: user)
        cell.backgroundColor = .white
        return cell
    }
}

extension RanUserController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.9
        
        return CGSize(width: itemWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        print(user.name.first)
        
        let userDetailStoryboard = UIStoryboard(name: "UserDetail", bundle: nil)
        guard let userDetailController = userDetailStoryboard.instantiateViewController(withIdentifier: "UserDetailController") as? UserDetailController else {
            fatalError("could not downcast")
        }
        
        
        navigationController?.pushViewController(userDetailController, animated: true)
    }
}

