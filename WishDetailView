class WishDetailView extends StatefulWidget {
  final Wish wish;

  WishDetailView({required this.wish});

  @override
  _WishDetailViewState createState() => _WishDetailViewState();
}

class _WishDetailViewState extends State<WishDetailView> {
  String id = '';


  @override
  Widget build(BuildContext context) {
    List<Perform> performs = widget.wish.performs;
    return Scaffold(
      backgroundColor: Color(0xFF1D1332),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromRGBO(210, 39, 222, 1),
                          ),
                          tooltip: 'Назад',
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isPremium ? mainPurple : Colors.transparent,
                              width: 2.0,

                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isPremium ? mainPurple.withOpacity(0.5) : Colors.transparent,
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CachedNetworkImage(
                            imageUrl: 'image',
                            placeholder: (context, url) => CircleAvatar(
                              backgroundImage: AssetImage('assets/default_image.png'),
                            ),
                            imageBuilder: (context, imageProvider) => CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.wish.fullname,
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.wish.username,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      widget.wish.caption,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${widget.wish.timestamp.day.toString().padLeft(2, '0')}.${widget.wish.timestamp.month.toString().padLeft(2, '0')}.${widget.wish.timestamp.year}',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    WishActionsView(wish: widget.wish),
                  ],
                ),
              ),
            ),
          ),
          if (isLoadingDelete)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD227DE)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}