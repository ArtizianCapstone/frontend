# Overview
## Impact your community

Built for artisans, the Amazon Community Helper app allows leaders to empower their communities by connecting artisans to the Amazon Handmade marketplace. This application supports the community leader in playing many distinct roles for their artisan group, such as banker, meeting coordinator, inventory manager, and shipper. The intuitive design of the app encourages face-to-face interaction between the group leader and artisans, so that the technology never replaces real business relationships. Usage information provided by the app will ensure that group leaders feel their work is meaningful, by informing users of the impact they are having on the community.

# Build Instructions
## Cloning This Repository
* Copy the link that pops up when pressing the green "Clone or Download" button at the top of this webpage.
* In the Terminal app, navigate to a path where you wish to clone this repo.
* Run the command `git clone <copied link>`.
## Add Build Dependencies
* Still in Terminal, enter the repo with the command `cd frontend`.
* Install the build dependencies with the command `pod install` and then `pod update`.
    * If you encounter a build dependency issue when running the aforementioned `pod` commands, remove two files within `frontend`.
    * Making sure you are still in `frontend`, remove "Podfile.lock": `rm Podfile.lock`.
    * Also remove the "Pods" folder: `rmdir -r Pods`.
    * Finally, install the build dependencies again with `pod install` and then `pod update`.
## Open and Build in Xcode
* In the Finder app, navigate to the same path where you cloned the repo.
* Click on the "frontend" folder.
* Click on “Frontend.xcworkspace”. The project will open via Xcode.
    * (Note: do *not* open via clicking “Frontend.xcproj”)
* In Xcode, check the project is being built to the iOS Simulator.
    * Locate the build target on screen. It is listed at the top left of the screen, to the right of the Play button.
    * If it says “Generic iOS Device", click on that text and choose any of the options listed under “iOS Simulator”. We recommend iPhone 8 or XR.
* Build the project to the iOS Simulator by pressing the Play button.
