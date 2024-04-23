Please go under edit and edit this file as needed for your project. There is no seperate documentation needed.

# Project Name - Flashcards App

# Student Id - IT21023378

# Student Name - Jayasuriya T. D. D. H

#### 01. Brief Description of Project -

The Flashcards App is designed to enhance learning and memory retention through interactive and customizable digital flashcards. It's perfect for students, educators, and lifelong learners aiming to master new topics or languages. Users can create their own sets of flashcards, organize them into decks, and review them systematically to improve knowledge absorption and retention. With its user-friendly interface, the app makes the process of learning complex subjects more manageable and effective.

#### 02. Users of the System -

- **School Students:** Useful for elementary to high school students, the app helps in memorizing important terms, historical dates, science facts, and more, enhancing their academic performance.
  <br>

- **University Students:** Helps higher education students organize their study material across various subjects, from complex medical terms to simple definitions.
  <br>

- **Language Learners:** Ideal for people learning new languages, allowing them to practice vocabulary and phrases systematically.
  <br>

- **Professionals:** Useful for professionals preparing for certification exams, job interviews, or presentations, helping them memorize key concepts and terminologies.

#### 03. What is unique about your solution -

The Flashcards App stands out with its attractive design and useful features that make learning more engaging compared to other apps. It's not just about making flashcards; it helps you keep track of your progress with detailed stats on how much you've studied and how you're doing with each card and deck. You can easily see which decks you've used recently and keep tabs on which cards you've completed or skipped. This app makes it fun and easy to organize your studying, helping you learn more effectively.

#### 04. Briefly document the functionality of the screens you have (Include screen shots of images)

All screens in the Flashcards App support both light and dark modes, providing users with a comfortable viewing experience in any lighting condition.

##### 1. Main Interface

The main interface features the most recently used deck, the top five recently viewed decks in a horizontal collection, and options to favorite or unfavorite decks below. By long-pressing on a deck, users can also access options to edit or delete it.

<p float="left">
  <img src="/Resources/1.png" width="49%" />
  <img src="/Resources/1a.png" width="49%" /> 
</p>

##### 2. Favorite Decks Interface

The favorite decks screen displays all the decks that the user has marked as favorites. Users can easily access these decks for quick review.

<p float="left">
  <img src="/Resources/2.png" width="49%" />
  <img src="/Resources/2a.png" width="49%" />
</p>

##### 3. Flashcards list Interface

The flashcards list screen displays all cards in a deck, enabling users to browse, edit, and update their status. It also allows adding new cards and starting practice sessions. By swiping left, users can edit or delete flashcards, and swiping right allows them to change the card's status.

<p float="left">
  <img src="/Resources/3.png" width="49%" />
  <img src="/Resources/3a.png" width="49%" />
</p>

##### 4. Flashcard Practice Interface

The flashcard practice screen shows a card with a question or term on one side and the answer or definition on the other side. Users can flip the card to reveal the answer and mark it as correct or incorrect by swiping left or right.

<p float="left">
  <img src="/Resources/4.png" width="49%" />
  <img src="/Resources/4a.png" width="49%" />
</p>

##### 5. Create Deck Interface

The create deck screen allows users to create a new deck by entering a title and description. After clicking the "Next" button, users can add cards to the deck by providing questions and answers. This screen is also used for editing existing decks.

<p float="left">
  <img src="/Resources/5.png" width="49%" />
  <img src="/Resources/5a.png" width="49%" />
</p>

##### 6. Create Flashcard Interface

The create flashcard screen allows users to add new cards to a deck by entering a question and an answer. Users can quickly add multiple cards using the 'Add Another' button or save their changes and exit with the 'Save and Close' option. This screen is also used for editing existing flashcards.

<p float="left">
  <img src="/Resources/6.png" width="49%" />
  <img src="/Resources/6a.png" width="49%" />
</p>

#### 05. Give examples of best practices used when writing code

- **Use of MVC Architecture:** Organizing code into Model-View-Controller (MVC) architecture helps in separating concerns, making the code easier to manage and scale. For example, creating separate view controllers for different screens and having a dedicated service layer for database operations.
- **Use of Clean Folder Structure**: Organizing code into multiple folders like controllers, views, models, services, and utilities ensures that components are easily navigable and maintainable. This separation of concerns allows developers to quickly locate specific pieces of code and manage them efficiently.

- **Core Data Management:** Implementing Core Data for persistent storage, providing efficient data management and scalability. Using a DeckService and FlashcardsService classes to handle all data operations encapsulates Core Data handling away from view controllers.

- **Use of IBDesignable Classes:** Implementing IBDesignable classes allows for custom styling of views directly in the Interface Builder, making it easier to reuse and adjust UI components across the app. This practice enhances the consistency and visual appeal of the user interface without cluttering the code with UI customization.

- **Error Handling:** Properly handling errors during data fetches or saves, as seen with the use of try-catch blocks in Core Data fetch requests, prevents the app from crashing and allows for graceful error handling.

- **Decoupling and Reusability:** By creating extensions and separate service classes, the code becomes more modular, reusable, and easier to test. For example, separating table view data source and delegate methods into an extension improves readability and reuse.

- **Notification Center:** Using Notification Center to manage updates across different components of the application without making view controllers tightly coupled to each other.

- **Code Readability and Maintenance:** Keeping code clean, well-commented, and using meaningful variable names makes the code easier to read and maintain. For instance, using clear and concise naming for functions and variables like 'fetchDecks' or 'updateLastViewed'.

#### 06. UI Components used

- **UINavigationController:** Manages navigation between the main screen (list of flashcard decks) and individual flashcard views or editing screens.
- **UITabBarController:** Allows users to switch between different sections of the app, such as the main deck list and favorite decks.
- **UIViewController:** Each screen is managed by its own UIViewController.
- **UIButton:** Used for navigation, actions, and interactions like adding new decks, editing flashcards, or flipping cards during practice sessions.
- **UILabel:** Display text content like deck titles, card questions, and answers.
- **UITextField:** Input fields for entering deck titles, card questions, and answers.
- **UITextView:** Used for displaying longer text content like deck descriptions or card details.
- **UIAlertController:** Used to confirm actions such as deleting a flashcard or deck, or to show errors/alerts when user input is needed or an operation fails.
- **UIScrollView:** Allows users to scroll through entire views, especially when content exceeds the screen size.
- **UICollectionView:** Displays a collection of decks or flashcards in a grid layout, allowing users to horizontally scroll through decks.
- **UITableView:** Displays a list of flashcards or decks in a vertical layout.
- **UIImageView:** Displays images or icons.
- **UIProgressView:** Shows the progress of a practice session or the completion status of a deck.
- **UILongPressGestureRecognizer:** Used to detect long-press actions on decks for additional options like editing or deleting.
- **UITapGestureRecognizer:** Used to detect tap actions on flashcards for flipping or marking them as correct or incorrect.
- **UIPanGestureRecognizer:** Used to detect swipe actions on flashcards for flipping or marking them as correct or incorrect. -**UIView:** Used for container views, custom styling, and layout management.
- **UIVisualEffectView:** Adds visual effects like blur or vibrancy to views, enhancing the app's aesthetics.

#### 07. Testing carried out

No formal unit testing or UI testing was conducted for this application. Instead, the app was manually tested on iOS simulators to ensure functionality and user experience align with expectations. This manual testing process involved checking all features, such as creating and editing decks, adding and modifying flashcards, as well as navigating through the various UI components to detect any issues in real-time interaction scenarios.

#### 08. Documentation

(a) Design Choices

The development of the Flashcards app was guided by a commitment to clean, maintainable code and an intuitive user interface. Here are the key design choices that were made,

###### Architecture:

The app is structured using the Model-View-Controller (MVC) architectural pattern. This separation ensures that user interface logic is distinct from the data handling and the business logic, making the code cleaner and more maintainable.

###### Core Data:

Core Data was chosen for data persistence due to its efficiency and scalability. By creating separate service classes for managing decks and flashcards, the Core Data implementation is encapsulated away from the view controllers, promoting code reusability and modularity.

###### User Interface:

Emphasis was placed on creating a visually appealing interface that provides a seamless user experience. This includes smooth animations for navigating between cards in practice mode, enhancing the interactive aspect of the app.

The layout and design were implemented using Storyboards, which allowed for a visual approach to UI construction and the use of AutoLayout for responsive designs that adapt to different device sizes.

###### Custom Components:

No third-party libraries were used, promoting a lightweight and streamlined app footprint. This choice was made to avoid external dependencies and to keep the build process straightforward.

Several IBDesignable classes were created to encapsulate common UI elements, such as custom views and buttons. This approach not only streamlines the design process within the Storyboard but also ensures consistency across the app’s interface.

(b) Implementation Decisions

###### Data Management:

The app uses Core Data to manage decks and flashcards, ensuring that user-created content is persisted across app sessions. By abstracting Core Data operations into service classes, the view controllers remain focused on user interactions and UI updates.

###### User Interaction:

The app leverages gestures like swipe and tap to provide intuitive interactions for flipping cards during practice sessions and marking them as correct or incorrect. These gestures enhance the user experience by mimicking real-world flashcard interactions.

##### Storyboard and AutoLayout:

The user interface is designed entirely using Storyboards combined with AutoLayout. This approach allows for a visual representation of the app’s screens and ensures that the layout adapts to different screen sizes and orientations.

###### Custom Styling:

Custom styling is applied to various UI components, such as buttons, labels, and views, to create a cohesive and visually appealing interface. This styling is achieved through the use of IBDesignable classes that encapsulate the design elements and promote consistency throughout the app.

(c) Challenges

- **Limited Experience in iOS Design:**

As a beginner in iOS app development, one of the significant hurdles was the steep learning curve associated with understanding and effectively implementing user interface designs using UIKit.

- **Sparse UIKit Resources:**

There is a noticeable scarcity of comprehensive resources on crafting complex UIs with UIKit. This lack of detailed guides and tutorials made it challenging to implement sophisticated user interface elements and animations intended to enhance user engagement.

- **Debugging and Build Issues:**

Debugging was particularly challenging, as issues would often arise during the build process that were not only hard to trace but also difficult to resolve.

- **State Management Complexity:**

Managing the state across various components of the application was complex, especially given the app's reliance on real-time data updates for displaying flashcards and managing user interactions seamlessly.

- **Storyboard Constraints:**
  Resolving layout constraints in Storyboard was a recurrent challenge. The visual layout editor, while convenient, occasionally produced conflicts especially when dealing with dynamic content and varying screen sizes.

#### 09. Reflection

During this project, I faced a steep learning curve with Swift and UIKit due to limited prior knowledge and a lack of extensive resources. Xcode's performance issues also posed significant challenges, as frequent crashes sometimes required me to redo parts of the UI. In hindsight, a more focused initial study of Swift and simpler UI practices could have eased some of these challenges.
