class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Doctors',
      image: 'assets/Group 1212.png',
      discription: 'Find expert doctors for perticular problem on one tap'
  ),
  UnbordingContent(
      title: 'Antenatal Care',
      image: 'assets/Group 1213.png',
      discription: "We are on a mission to reduce c-section rate in India"
  ),
  UnbordingContent(
      title: 'Daily Tracker',
      image: 'assets/Group 1214.png',
      discription: "Build a routine of positive,life changing habits"
  ),
];