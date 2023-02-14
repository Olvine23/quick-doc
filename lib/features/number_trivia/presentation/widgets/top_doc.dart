// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/doctor.dart';
// import '../providers/provider_file.dart';

// class TopDoc extends ConsumerWidget {
//   List<Doc> doctors = <Doc>[];
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     doctors.add(Doc('Olvine', "George", 'none', 'Kasuku', 6, 'A doctor profile typically includes information such as the doctors name, photo, education and training background, specialties, and any additional certifications or awards. It may also provide details about the doctors practice, such as the types of patients they see, the services they offer, and the location of their practice. A doctor profile may be available on the doctors website, on a hospital or clinics website, or on a medical directory website. It serves as a useful tool for patients who are looking for a doctor who can meet their specific medical needs.'));
//     doctors.add(Doc('George', "Geo", 'none', 'Kasuku', 6, 'A doctor profile typically includes information such as the doctors name, photo, education and training background, specialties, and any additional certifications or awards. It may also provide details about the doctors practice, such as the types of patients they see, the services they offer, and the location of their practice. A doctor profile may be available on the doctors website, on a hospital or clinics website, or on a medical directory website. It serves as a useful tool for patients who are looking for a doctor who can meet their specific medical needs.'));
//     print(doctors.length);
//     final text = ref.watch(boxProvider);

//     return SafeArea(
//       child: SizedBox(
//         child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: doctors.length,
//             itemBuilder: ((context, index) {
//               print(doctors[index].firstName);
//               return Column(
//                 children: [
//                   Text(doctors[index].firstName),
//                   Text(doctors[index].lastName)
//                 ],
//               );
//             })),
//       ),
//     );
//   }
// }
