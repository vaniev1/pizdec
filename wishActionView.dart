class WishActionsView extends StatefulWidget {
  final Wish wish;

  WishActionsView({required this.wish});

  @override
  _WishActionsViewState createState() => _WishActionsViewState();
}

class _WishActionsViewState extends State<WishActionsView>
    with TickerProviderStateMixin {
  bool liked = false;


  @override
  void initState() {
    super.initState();
    checkIfLiked().then((value) {
      setState(() {
        liked = value;
      });
    });
  }


  Future<http.Response> addLikeToWish(String wishId, String caption,
      String username, String likedUsername, String selectedImagePath,
      String fullname, int likes) async {
    final token = await _getToken();

    final String apiUrl = 'localhost/like-wish';

    final Map<String, dynamic> requestBody = {
      'wishId': wishId,
      'caption': caption,
      'username': username,
      'likedUsername': likedUsername,
      'selectedImagePath': selectedImagePath,
      'fullname': fullname,
      'likes': likes,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    return response;
  }

  Future<http.Response> removeLikeFromWish(String wishId, String caption,
      String username, likedUsername) async {
    final token = await _getToken();

    final String apiUrl = 'http://localhost/unlike-wish';

    final Map<String, dynamic> requestBody = {
      'wishId': wishId,
      'caption': caption,
      'username': username,
      'likedUsername': likedUsername,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    return response;
  }

  Future<bool> checkIfLiked() async {
    final token = await _getToken();
    final String apiUrl = 'http://localhost/check-like';

    final Map<String, dynamic> requestBody = {
      'wishId': widget.wish.id,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['liked'];
    } else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    bool isCommentEmpty = textEditingController.text.isEmpty;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    color: liked ? Colors.red : Colors.white,
                  ),
                  onPressed: () async {
                    if (!isProcessing) {
                      setState(() {
                        isProcessing = true;
                      });

                      if (liked) {
                        final response = await removeLikeFromWish(
                            widget.wish.id,
                            widget.wish.caption,
                            widget.wish.username,
                            widget.wish.uid);
                        if (response.statusCode == 200) {
                          print("Лайк удален");
                          setState(() {
                            widget.wish.likes--;
                            liked = false;
                          });
                        } else {
                          print('Ошибка при удалении лайка');
                        }
                      } else {
                        final response = await addLikeToWish(
                            widget.wish.id,
                            widget.wish.caption,
                            widget.wish.username,
                            widget.wish.uid,
                            widget.wish.selectedImagePath,
                            widget.wish.fullname,
                            widget.wish.likes);
                        if (response.statusCode == 200) {
                          print("Лайк добавлен");
                          setState(() {
                            widget.wish.likes++;
                            liked = true;
                          });
                        } else {
                          print('Ошибка при добавлении лайка');
                        }
                      }

                      setState(() {
                        isProcessing = false;
                      });
                    }
                  },
                ),
                Text(
                  widget.wish.likes.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}