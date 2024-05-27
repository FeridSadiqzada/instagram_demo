import 'package:instagram_demo/models/stories.dart';

class StoriesProvider{

  List<Storie> stories = [];

   List<Storie> getStories(){
    stories = [
       Storie(
        name: "Carlos",
        photo: "https://images.pexels.com/photos/2027490/pexels-photo-2027490.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
      ),
       Storie(
        name: "Josue",
        photo: "https://images.pexels.com/photos/2182970/pexels-photo-2182970.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
      ),
       Storie(
        name: "Felipe",
        photo: "https://images.pexels.com/photos/761115/pexels-photo-761115.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
      ),
       Storie(
        name: "Tony",
        photo: "https://images.pexels.com/photos/532220/pexels-photo-532220.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
      ),
       Storie(
        name: "Andres",
        photo: "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
      ),
       Storie(
        name: "Miguel",
        photo: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
      ),
       Storie(
        name: "Karla",
        photo: "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
      ),
       Storie(
        name: "Eva",
        photo: "https://images.pexels.com/photos/1845534/pexels-photo-1845534.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
      )      
    ];

    return stories;

  }


}