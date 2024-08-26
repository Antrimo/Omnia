import 'package:flutter/material.dart';
import 'package:omnia/Resources/Theme/theme.dart';

class Council extends StatefulWidget {
  const Council({super.key});

  @override
  State<Council> createState() => _CouncilState();
}

class _CouncilState extends State<Council> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        color: navColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Council Members',
                    style: TextStyle(
                      color: itemColor,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              // Custom card 1
              _buildCard(
                context: context,
                heading: 'Animesh Singh',
                subheading: 'Chairperson',
                imagePath: 'assets/council/chair.png',
                description: '"You know who I am"',
              ),
              // Custom card 2
              _buildCard(
                context: context,
                heading: 'Zama Rizvi',
                subheading: 'Vice Chairperson',
                imagePath: 'assets/council/vice.jpg',
                description: 'Master of Organized Chaos, Expert in Turning Coffee into Code , ensuring meetings are as smooth as your last code compilation and the Go-To for keeping the team spinning -- All the while making sure no one forgets the importance of emotional intelligence -- because great tech starts with great people (maybe a few snacks)',
              ),
              // Custom card 3
              _buildCard(
                context: context,
                heading: 'Aditya Kumar',
                subheading: 'Webmaster',
                imagePath: 'assets/council/webmaster.jpg',
                description: 'Creator and Co-Developer of Omnia \n\n"Council: App-master is not a thing. \n\tMe: Y\'know I\'m something of a Webmaster \n\tmyself."',
                gif: 'assets/council/rickroll.gif',
              ),
              // Custom card 4
              _buildCard(
                context: context,
                heading: 'Meghna Mankotia',
                subheading: 'Treasurer',
                imagePath: 'assets/council/treasurer.jpg',
                description: 'Life is not a waste of time, time is not a waste of life. So let\'s not waste any time, get wasted and have the time of our lives. \n"Party budget TBD"',
              ),
              // Custom card 5
              _buildCard(
                context: context,
                heading: 'Kartikey Srivastava',
                subheading: 'Secretary',
                imagePath: 'assets/council/secretary.jpg',
                description: 'Creator and co-developer of Omnia, \nCR3 ki permission chahiye? Miljayegi \nEvents ki attendance chahiye? Hojaegi \nVc se budget approval? Samjho hogaya, coz \nSecretary always 🔛🔝',
              ),
              _buildCard(
                context: context,
                heading: 'Norin Sharma',
                subheading: 'Membership Chair',
                imagePath: 'assets/council/memchair.jpg',
                description: 'I can strike up a conversation with anyone—even a houseplant! With a sixth sense for spotting potential members who just need a little nudge to join the fun, I’ll be the mastermind behind growing our club, turning casual visitors into committed members with my irresistible charm and creativity.',
              ),
              _buildCard(
                context: context,
                heading: 'Kanika Thakur',
                subheading: 'Creative Head',
                imagePath: 'assets/council/design.jpg',
                description: 'Brainstorming Wizard. \nMaster of Memes. \nArtistic force behind every cool poster. \nMotto of our council \n"Kanika Sambhal Legi"',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String heading,
    required String subheading,
    required String imagePath,
    required String description,
    String? gif,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(

          title: Text(heading),
          subtitle: Text(subheading),
          leading: CircleAvatar(
            backgroundImage: AssetImage(imagePath),
          ),
          onTap: () {
            _showDescriptionDialog(context, heading, subheading, description, imagePath, gif);
          },
        ),
      ),
    );
  }

  void _showDescriptionDialog(
  BuildContext context, String heading, String subheading, String description, String imagePath, String? gif) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Center(
          child: Text(
            heading,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blueAccent,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120, 
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.fill
                  ),
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(40)
                ),
              ),
              ListBody(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  Text(
                    'Position: $subheading',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  if (gif != null) // Only add this if gif is not null
                    Image.asset(gif, height: 30),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Close',
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


}
