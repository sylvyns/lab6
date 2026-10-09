import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/get_posts.dart';
import 'package:flutter_application_1/post/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Posts> posts = [];
  late PostBloc postBloc;

  @override
  void initState() {
    postBloc = PostBloc();
    postBloc.add(GetPostEvent());
    super.initState();
  }

  @override
  void dispose() {
    postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        bloc: postBloc,
        builder: (BuildContext context, state) {
          if (state is PostInitial || state is LoadingPostState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FetchedPostsState) {
            posts = state.posts;
            return buildBody();
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Не удалось загрузить посты"),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => postBloc.add(GetPostEvent()),
                    child: const Text("Повторить"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildBody() {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: posts.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = posts[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(item.body),
          ],
        );
      },
    );
  }
}
