class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Sales',
      image: 'assets/Group 1212.png',
      discription: "We are on a mission to reduce c-section rate in India"
  ),
  UnbordingContent(
      title: 'Admins',
      image: 'assets/Group 1213.png',
      discription: "Find expert Admins for particular problem on one tap"
  ),
];