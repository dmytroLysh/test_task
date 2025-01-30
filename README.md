# test_task

Setup

1. Download the Repository

[git clone https://github.com/your-repository.git
cd your-repository](https://github.com/dmytroLysh/test_task)

2. Configure API Key

For Xcode Users:
Open Xcode.

Navigate to Product → Scheme → Edit Scheme...

Under Run → Arguments → Environment Variables, add:

Key: API_KEY

Value: your-api-key-here

(You need to receive key https://fixer.io/)

Click Close and run the project.

Technologies Used:

Architecture: MVVM-C (Model-View-ViewModel-Coordinator) for better modularity and separation of concerns.

Networking: REST API integration using Alamofire for efficient and robust HTTP requests.

Data Persistence: Realm database for storing previously fetched exchange rates, ensuring offline access and efficient data handling.

UI Layout: SnapKit for programmatic Auto Layout, making the UI flexible and adaptable to different screen sizes.
