Modules:
-----------
- NTSAssignment - Main app (contains just the appdelegate & UIWindow creation)

- ListModule - Module contains displaying photos list and details & list module is covered with Unit tests

- NetworkClient - Module handles networking 

- Pods - used SDWebImage for loading & cache the remote images request


Code Structure:
------------------
(Designed completely in modular fashion)

* The workspace is organised with respective Modular structure,
* Used VIPER design pattern extensively on List Module 
- The main feature of the app is Photos Listing & Display respective detail.
- Found out the way to make the Photos Listing paginated with the API provided *** (https://jsonplaceholder.typicode.com/photos?_limit=10&_page=1)

* Unit test covers most of the areas of List module 
1. Builder, Presenter, Interactor, Router 
2. Services for photo request & Mapping of DTO (Data transfer object) to Model


Design (UI/UX):
-----------------
- Photos listing screen:
`UITableViewController` is used as  `ListViewController` with custom list cells designed with an `UIImageView`, a `UILabel` for displaying thumbnail image & image description.
`UIRefreshControl` is added to do pull-to-refresh which will refresh the whole API 

- Photo detail screen:
`UIImageView` is used to display main image passed from the list along with an `UILabel` to show the description.

- Subtle animation is used for soft-focus effect of image with fade animation

Build Notes:
--------------
- Open NTSAssignment.workspace & run the default NTSAssignment Target.
- To run the Unit test, use the same NTSAssignment (added target test dependency & coverage)

Docs:
------
P.S: I have written necessary comments in most of complex areas like in network client module, Rest of the module & code is self explanatory because of swift coding style followed (which contains minimalistic documentation)
