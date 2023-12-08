
class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {

  ///

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xFF1D1332),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF1D1332),
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  color: mainPurple,
                  child: Center(
                    child: ListView.builder(
                      itemCount: wishes.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == wishes.length) {
                          return isLoading
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: (screenHeight - 350.0) / 2,
                              ),
                              CircularProgressIndicator(color: mainPurple),
                              SizedBox(height: 16.0),
                            ],
                          )
                              : Container();
                        } else {
                          return Padding(
                            key: ValueKey<String>(wishes[index].id),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: WishCell(wish: wishes[index]),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}