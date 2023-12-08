class WishCell extends StatefulWidget {
  final Wish wish; 
  final Key? key; 

  WishCell({required this.wish, this.key}) : super(key: key);

  @override
  _WishCellState createState() => _WishCellState();
}


class _WishCellState extends State<WishCell> {
  String id = ''; 


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishDetailView(wish: widget.wish)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0F0820),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            if (isPremium)
              BoxShadow(
                color: mainPurple.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    'image',
                    placeholder: (context, url) => CircleAvatar(
                      backgroundImage: AssetImage('assets/default_image.png'),
                      radius: 28,
                    ),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 28,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.wish.fullname,
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              widget.wish.username,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            SizedBox(width: 10),
                            Text(
                              formatTimestamp(widget.wish.timestamp),
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                widget.wish.caption,
                style: TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2, // Set the maximum number of lines
                overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis (...).
              ),
              SizedBox(height: 16.0),
              WishActionsView(wish: widget.wish), // Передача колбэка onLike
            ],
          ),
        ),
      ),
    );
  }
}