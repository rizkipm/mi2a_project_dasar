import 'package:flutter/material.dart';

class PageSearchListview extends StatefulWidget {
  const PageSearchListview({super.key});

  @override
  State<PageSearchListview> createState() => _PageSearchListviewState();
}

class _PageSearchListviewState extends State<PageSearchListview> {

  //data json static
  List<Map<String, dynamic>> books = [
    {
      "id":1,
      "title":"Harry Potter",
      "author":"J.K. Rowling",
      "year": "1997"
    },
    {
      "id":2,
      "title":"The Hobbit",
      "author":"J.R.R Tolkien",
      "year": "1937"
    },
    {
      "id":3,
      "title":"Clean Code",
      "author":"Robert C. Martin",
      "year": "2008"
    },
    {
      "id":4,
      "title":"Atomic Habits",
      "author":"James Clear",
      "year": "2018"
    },
    {
      "id":5,
      "title":"Deep Work",
      "author":"Cal New Port",
      "year": "2016"
    },
  ];

  List<Map<String, dynamic>> filteredBooks = [];
  TextEditingController txtSearch = TextEditingController();

  bool isGrid = false; //untuk toggle view

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredBooks = books;
  }

  void searchBooks(String keyword){
    final results = books.where((book){

      final title = book['title'].toLowerCase();
      final author = book['author'].toLowerCase();
      final input = keyword.toLowerCase();

      return title.contains(input) || author.contains(input);

    }).toList();

    setState(() {
      filteredBooks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Library Book"),
        backgroundColor: Colors.green,
        actions: [
          //fitur toggle button rubah jadi list atau grid
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: (){
              setState(() {
                isGrid = !isGrid;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            //Seacrh Bar
            TextField(
              controller: txtSearch,
              decoration: InputDecoration(
                hintText: "Search Books...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              onChanged: (value){
                searchBooks(value);
              },
            ),
            SizedBox(height: 12,),
            Expanded(child: filteredBooks.isEmpty ? Center(child: Text("Book Not Found"))
              : isGrid ? buildGridView()
                : buildListView()
            )
          ],
        ),
      ),

    );
  }

  Widget buildListView(){
    return ListView.builder(
      itemCount: filteredBooks.length,
      itemBuilder: (context, index){
        final book = filteredBooks[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: Icon(Icons.book, size: 32,),
            title: Text(book['title']),
            subtitle: Text("${book['author']} . ${book['year']}"),
          ),
        );
      },

    );
  }

  Widget buildGridView(){
    return GridView.builder(
      itemCount: filteredBooks.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        childAspectRatio: 3/4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
      itemBuilder: (context, index){
        final book = filteredBooks[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          elevation: 4,
          child: Padding(padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.menu_book, size: 60, color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  book['title'], style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6,),
                Text(
                  book['author'], style: TextStyle(color: Colors.green),
                ),
                Spacer(),
                Text(book['year'],
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        );
      },
    );

  }
}
