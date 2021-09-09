import 'package:flutter/material.dart';

class NetworkImage extends StatelessWidget {
  final String url;

  const NetworkImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, exception, stackTrace) {
        return const Image(
          image: AssetImage('assets/images/no-image.png'),
        );
      },
    );
  }
}
