# MyVKClient

<h2>Features and Requirements</h2>

1. Auth with VK SDK
2. Auth with VK API 
3. Login and Logout 
4. Async image loading
5. Cache loaded images
6. Pull to refresh when scroll up (load new)
7. Infinite loading when scroll down (load previos)
8. Using Core Data/realm database for local data storage
9. Using Cocoa Pods for connecting libraries and frameworks
10. Using Storyboard/NSLayoutConstraints/SnapKit for Autolayut
11. Using MVC/MVVM/VIPER architectures
12. Adapt for iPad
13. Landscape and Portrait orientation - using Size classes
14. Store user password/auth user/auth token. Auto login
15. Unit tests
16. JSON parsing with JSONSerialization/Codable
17. URLSession/Alamofire for networking
18. Using UIAppearance for color themes and possibility to swith app color themes

<h2>User Functionality</h2>

<h3>There are shold be following screens:</h3>

  1. Splash screen
  2. Login screen
  3. Latest news screen
  4. News details screen
  
<h3>Login Screen</h3>

Auth in app via VK SDK or VP API. After user authenticated do no need to show login screen. When user will run application again he should be directed to news screen. If user logout from application than login screen must be shown again. Auth error should be handled.

<h3>Latest News Screen</h3>

Show all latest news for user. When user scroll up (pull to refresh) new items should be loaded. When user scroll down (infinite scrolling) previous items should be loaded. Logout button should be in top right corner. Loaded news should be cached. When user select news item then detail screen must be shown. Following information must be displayed for every news item:
  1. Author name
  2. Author avatar image
  3. News item date
  4. One or two images
  5. Likes count

<h3>News Details Screen</h3>

All information from selected previously news item should be displayed. Also there are should be like button. All Images from news item must be shown.


 
