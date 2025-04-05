import 'package:flutter/material.dart';
class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      
      body: Stack(
        
        children: [
       Opacity(
            opacity: 1,
            child: Image.asset(
              "assets/gymboy.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upper Workout",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two columns
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: (screenWidth / 2) / (screenHeight * 0.4),
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return _buildTutorialCard(context, "Upper ${index + 1}", screenWidth, 'assets/upper${index + 1}.png','/upper${index + 1}');
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Lower Workout",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 249, 249, 249)),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two columns
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: (screenWidth / 2) / (screenHeight * 0.4),
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return _buildTutorialCard(context, "Lower ${index + 1}", screenWidth, 'assets/lower${index + 1}.png','/lower${index + 1}');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorialCard(BuildContext context, String title, double screenWidth, String imagePath, String route) {
    return GestureDetector(
   onTap: () {
      Navigator.pushNamed(context, route);
    },
      child: Container(
        width: screenWidth * 0.4,
        height: 100,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: const Color.fromARGB(255, 50, 50, 50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
