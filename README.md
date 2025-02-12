# README

* Ruby version

* System dependencies


Our project, One Word Mood, reimagines social media by focusing on simplicity and emotion. Users interact through the unique feature of sharing their feelings in a single word, creating a platform that encourages authentic and concise self-expression. Every post comes with a “Same Mood 🙂” button, allowing others to instantly connect and relate to the shared emotion. To add a visual touch, our innovative GIF feature lets users express their moods in a more dynamic and engaging way directly on their posts.

Technologies Used:

-Ruby on Rails(Used as the primary backend framework to handle server-side logic and APIs.)

-SQLite(Served as the database to store user data efficiently, given the manageable size of our project.)

-Giphy API(API feature integration)

-real-time data processing

The system’s components include:

Client:
Represents the end-user interacting with the application via a web browser.
The client sends requests and receives responses.
DNS:
Acts as a mediator between the client and the server.
Resolves the domain name to the web server’s IP address, enabling the client to connect.
Frontend:
Includes the user interface built with HTML, CSS, and JavaScript.
Responsible for collecting data from users (e.g., moods, likes) and displaying the results.
Sends user inputs as requests to the backend.
Web App (Backend):
The core of the system, built with Ruby on Rails.
Processes user requests and handles various functionalities, including:
User login (via an authentication service).
Posting moods and liking posts.
Fetching GIFs using the GIPHY API.
Integrates seamlessly with the database for CRUD (Create, Read, Update, Delete) operations.
SQL Database (SQLite3):
Stores application data, such as user information, moods, posts, and likes.
Communicates with the backend to retrieve or update data as needed.
Authentication Service (Devise):
Manages user authentication and authorization.
Ensures secure login and verifies user identity before granting access to sensitive features.
