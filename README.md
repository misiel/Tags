# Tags 🏷
**Bookmarking app for images**

**Tags** is a side project idea that I completed in a little under 2 weeks after using apps like Pocket and Instapaper. I was curious on how these apps interact with the share sheet across different applications and are able to save images, URLs, text etc and display them to the user in a seamless way.

While working on **Tags**, I reused a couple of components that I learned in my previous project like Combine, threading for UI updates, UITableView/UICollectionView customization and more. I also came across a bunch of newer learnings (Share Extension, Targets, App Group Containers, etc) that I would suggest you go check out in my blog () if you are curious! 

- Sharing my iOS dev journey along with "building in public" has been a revitalizing approach that I have implemented that has kept me accountable and has taught me a ton as I work on these side projects - I recommend any newer dev to implement this approach to your journey and see how it improves your results.

---
## Notes and Screenshots

Once again the UI is pretty minimal as I was just using this project as a way to learn more things in iOS dev land, although I did implement a pretty nifty trick with the HomeViewController tableview (tappable section headers and disappearing rows). A big part of this app was the data persistence, updating the data correctly throughout the app and share extension and passing data amongst multiple surfaces.

There's also a couple of TODO's sprinkled through the app of things I would like to implement, do in a different way or downright fix that I plan to get to hopefully in the future as I flesh this app a bit more! _(hopefully this doesn't enter the side project graveyard 🤣)_

Here are some screenshots of different actions throughout the app:
### Home (empty state) |        Home (with tags)
![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 52 13](https://user-images.githubusercontent.com/23410589/216789067-efacec1b-8706-4f39-9339-5a12edcce139.png)![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 52 24](https://user-images.githubusercontent.com/23410589/216789216-5e552e0c-9067-4392-8e86-9e3b88a21176.png)

### Home Refresh 
note: I added a manual refresh to the Home table view. Ideally, I would want the tags to refresh when I come back to the app from the share extension. If you see how I can do this, please share!

![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 54 06](https://user-images.githubusercontent.com/23410589/216789347-452b4de2-e47d-4220-a43f-642a03c2e6fa.png)

### Adding Tag
![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 52 35](https://user-images.githubusercontent.com/23410589/216789196-7ea591b0-95d0-4e76-8601-20c1c842a54e.png)

### Sharing Image to Tags
![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 52 52](https://user-images.githubusercontent.com/23410589/216789238-768682d1-f872-4ced-a693-c31173f8d28c.png)![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 53 02](https://user-images.githubusercontent.com/23410589/216789249-4804ba0b-b7c4-4924-ae5b-d9564f07040e.png)![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 53 06](https://user-images.githubusercontent.com/23410589/216789289-602c681d-bfae-406d-96d2-9abe19bccd51.png)

### Selected Tag Screen
![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 57 37](https://user-images.githubusercontent.com/23410589/216789404-4ca7101d-a10b-4eb3-90fd-84eb4f807740.png)![Simulator Screen Shot - iPhone 14 Pro - 2023-02-04 at 14 57 42](https://user-images.githubusercontent.com/23410589/216789409-73f01c7c-0148-4e3c-a5bc-48a07ceb864a.png)


