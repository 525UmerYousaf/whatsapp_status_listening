// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:story/story.dart';

class StoryModel {
  final String imageUrl;
  StoryModel(this.imageUrl);
}

class UserModel {
  final List<StoryModel> stories;
  final String userName;
  final String imageUrl;
  UserModel(this.stories, this.userName, this.imageUrl);
}

class StoryApp extends StatelessWidget {
  const StoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const StoryPage();
            }));
          },
          child: const Text('Show stories'),
        ),
      ),
    );
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  final sampleUsers = [
    UserModel([
      StoryModel(
          "https://cdn.pixabay.com/photo/2018/09/23/18/30/drop-3698073_960_720.jpg"),
      StoryModel(
          "https://cdn.pixabay.com/photo/2015/11/16/16/28/bird-1045954_960_720.jpg"),
      StoryModel(
          "https://cdn.pixabay.com/photo/2018/08/23/07/35/thunderstorm-3625405_960_720.jpg"),
      StoryModel(
          "https://cdn.pixabay.com/photo/2016/03/27/22/22/fox-1284512_960_720.jpg"),
      StoryModel(
          "https://cdn.pixabay.com/photo/2017/05/09/03/46/alberta-2297204_960_720.jpg"),
      StoryModel(
          "https://images.pexels.com/photos/924824/pexels-photo-924824.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ], "User1",
        "https://cdn.pixabay.com/user/2022/12/11/11-06-18-940_250x250.jpg"),
    UserModel([
      StoryModel(
          "https://cdn.pixabay.com/photo/2017/03/02/16/54/iceland-2111811_960_720.jpg"),
      StoryModel(
          "https://cdn.pixabay.com/photo/2013/10/02/23/03/dog-190056_960_720.jpg"),
      StoryModel(
          "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg"),
      StoryModel(
          "https://cdn.pixabay.com/photo/2014/12/08/02/59/benches-560435_960_720.jpg"),
      StoryModel(
          "https://cdn.pixabay.com/photo/2015/07/09/22/45/tree-838667_960_720.jpg"),
    ], "User2",
        "https://cdn.pixabay.com/user/2021/04/26/18-43-12-950_250x250.jpg"),
    UserModel([
      StoryModel(
          "https://cdn.pixabay.com/photo/2016/02/07/19/48/aurora-1185464_960_720.jpg"),
    ], "User3",
        "https://cdn.pixabay.com/user/2014/12/08/02-49-32-417_250x250.jpg"),
  ];

  @override
  void initState() {
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
    super.initState();
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        itemBuilder: (context, pageIndex, storyIndex) {
          final user = sampleUsers[pageIndex];
          final story = user.stories[storyIndex];
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.black,
                ),
              ),
              Positioned.fill(
                child: Image.network(
                  story.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 44, left: 8),
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      user.userName,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              if (pageIndex == 0)
                Center(
                  child: ElevatedButton(
                    child: const Text('Show Model Bottom Sheet'),
                    onPressed: () async {
                      indicatorAnimationController.value =
                          IndicatorAnimationCommand.pause;
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                'Look! The indicator is now paused\n\n'
                                'It will be continued after closing the modal bottom sheet',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      );
                      indicatorAnimationController.value =
                          IndicatorAnimationCommand.resume;
                    },
                  ),
                ),
            ],
          );
        },
        indicatorAnimationController: indicatorAnimationController,
        initialStoryIndex: (pageIndex) {
          if (pageIndex == 0) {
            return 1;
          }
          return 0;
        },
        pageLength: sampleUsers.length,
        storyLength: (int pageIndex) {
          return sampleUsers[pageIndex].stories.length;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
