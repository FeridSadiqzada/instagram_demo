// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_demo/controllers/comment_controller.dart';
import 'package:instagram_demo/controllers/home_page_controller.dart';
import 'package:instagram_demo/models/media.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_demo/models/post.dart';
import 'package:instagram_demo/models/stories.dart';
import 'package:instagram_demo/models/user.dart';
import 'package:instagram_demo/providers/stories_provider.dart';
import 'package:instagram_demo/views/comments_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StoriesProvider storiesProvider = StoriesProvider();
  int currentPage = 0;

  late HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.fetchPosts();
    Get.lazyPut(() => CommentController());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Divider(color: Colors.grey, thickness: 0.5),
            _labels(),
            _stories(),
            const Divider(color: Colors.grey, thickness: 0.5, height: 0.0),
            _posts(),
          ],
        ),
      ),
      bottomNavigationBar: _tapBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(
          color: Colors.black38,
          height: 0.75,
        ),
      ),
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //brightness: Brightness.light,
      centerTitle: true,
      title: Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: SizedBox(
            height: 40.0, child: Image.asset('assets/img/logo-instagram.png')),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add_reaction, color: Colors.black, size: 30.0),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.heart_broken, color: Colors.black, size: 28.0),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.messenger_outline_outlined,
              color: Colors.black, size: 28.0),
        ),
      ],
    );
  }

  Widget _labels() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Stories',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
          Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () {}, child: const Icon(Icons.arrow_right)),
              const Text('Watch All',
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _stories() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10.0, left: 5.0),
      height: 105.0,
      child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: storiesProvider.getStories().map((storie) {
            return _createStorie(storie);
          }).toList()),
    );
  }

  Widget _createStorie(Storie storie) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                width: 3,
                color: const Color(0xFF8e44ad),
              )),
          child: Container(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: const Image(
                image: NetworkImage(
                    "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp"),
                height: 65.0,
                width: 65.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          storie.name!,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13.0),
        )
      ],
    );
  }

  Widget _posts() {
    return Obx(() {
      if (homeController.posts.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeController.posts.length,
            itemBuilder: (context, i) {
              if (kDebugMode) {
                print(homeController.posts[i]);
              }
              return _createPost(
                  homeController.posts[i], homeController.posts[i].user);
            },
          ),
        );
      }
    });
  }

  Widget _createPost(Post post, User user) {
    var likes = post.likes.obs;
    List<Media> mediaList = post.media;
    Media media = mediaList[0];
    return Column(
      children: <Widget>[
        Container(
          //POST USER
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    top: 12.0, left: 18.0, bottom: 12.0, right: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image(
                    image: NetworkImage(media.path),
                    height: 45.0,
                    width: 45.0,
                  ),
                ),
              ),
              Text(
                user.username,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                iconSize: 30.0,
                onPressed: () {},
              ),
            ],
          ),
        ),
        FadeInImage(
          //POST IMAGE
          image: NetworkImage(media.path),
          placeholder: const AssetImage('assets/img/loading.gif'),
        ),
        Container(
          //ICONS ACTIONS
          padding: const EdgeInsets.only(
              top: 5.0, left: 7.0, right: 7.0, bottom: 0.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Image.asset('assets/img/heart.png', width: 30.0),
                      onPressed: () async {
                        if (!homeController.isLiked.value) {
                          var response = await http.get(
                              Uri.parse(
                                  'https://instagram.bakudevs.com/api/customer/v1/posts/like/${post.id}'),
                              headers: {
                                'Content-Type': 'application/json',
                                'Accept': 'application/json',
                                'Authorization':
                                    'Bearer ${homeController.token}'
                              });
                          if (response.statusCode == 200) {
                            homeController.isLiked.value = true;
                            likes++;
                            if (kDebugMode) {
                              print('OK');
                            }
                          } else {
                            if (kDebugMode) {
                              print('ERROR');
                            }
                            if (kDebugMode) {
                              print(response.body);
                            }
                          }
                        } else {
                          if (kDebugMode) {
                            print("Post already liked. No action taken.");
                          }
                        }
                      }),
                  IconButton(
                    icon: const Image(
                      image: AssetImage('assets/img/comment.png'),
                      width: 28.0,
                    ),
                    onPressed: () {
                      CommentController commentController = Get.find();
                      commentController.fetchComments(post.id);
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                            builder: (context) => const CommentPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Image(
                      image: AssetImage('assets/img/send.png'),
                      width: 29.0,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              IconButton(
                icon: const Image(
                  image: AssetImage('assets/img/save_o.png'),
                  width: 27.0,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          // LIKES
          padding: const EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
          width: double.infinity,
          color: Colors.white,
          child: Obx(() => Text(
                '${likes.toString()} likes',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              )),
        ),
        Container(
            color: Colors.white,
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "${user.username} ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0)),
                    TextSpan(
                        text: "${post.description} ",
                        style: const TextStyle(color: Colors.black)),
                  ]),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      post.description, //ilk commenti qoy
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 18.0),
                    ))
              ],
            )),
      ],
    );
  }

  Widget _tapBar() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black38, width: 0.75))),
      child: BottomNavigationBar(
        elevation: 0.0,
        iconSize: 28.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        backgroundColor: const Color(0xFFF9F9F9),
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            currentPage = i;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/img/home_o.png', width: 24, height: 24),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/img/Search.png', width: 24, height: 24),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/img/add_o.png', width: 24, height: 24),
              label: 'upload'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/img/heart.png', width: 24, height: 24),
              label: 'Likes'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/img/user_o.png', width: 24, height: 24),
              label: 'Profile')
        ],
      ),
    );
  }
}
