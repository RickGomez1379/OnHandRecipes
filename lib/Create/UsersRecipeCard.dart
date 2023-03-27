import 'package:flutter/material.dart';

class UsersRecipeCard extends StatelessWidget {
  const UsersRecipeCard(
      {super.key, required this.name, this.image, required this.serving});
  final String name;
  final String? image;
  final int serving;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 180,
        //Card Display Attributes
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            //Shadow Box of Card
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: const Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            // Default image if no Image is Provided
            image: image != null
                ? DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.multiply,
                    ),
                    image: NetworkImage(image!),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.multiply,
                    ),
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        "https://media.istockphoto.com/id/618446308/vector/recipe-card.jpg?s=612x612&w=0&k=20&c=egib8N-ZFVW7-oUn9ikqynf9MZctvhrg5wdwp4ucP_E="))),
        child: Stack(
          children: [
            //Recipe's Name
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            serving != null
                ?
                //Serving Size
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Serving Size
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.bakery_dining_outlined,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              const SizedBox(width: 7),
                              Text("$serving",
                                  style: const TextStyle(color: Colors.black))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : const Text(" "),
          ],
        ),
      ),
    );
  }
}
