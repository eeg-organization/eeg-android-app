import 'package:get/get.dart';

import '../../models/patients/yogaModel.dart';

class YogaController extends GetxController {
  final List<YogaPose> yogaPoses = [
    YogaPose(
      poseName: 'Child\'s Pose',
      poseImage:
          'https://media.istockphoto.com/id/1407965503/vector/woman-doing-childs-pose-stretch-exercise-flat-vector-illustration-isolated-on-white.jpg?s=612x612&w=0&k=20&c=xaOBczbmG_zzKVJt2i_BNiOthFjvDD1OJnQ6-uxakWo=',
      description:
          'Balasana is a gentle resting pose that promotes relaxation and reduces anxiety. It helps calm the mind and provides a sense of comfort and security.',
      steps: [
        'Start on your hands and knees with your knees wider than hip-width apart.',
        'Lower your hips toward your heels as you reach your arms forward, resting your forehead on the floor.',
        'Relax your body and breathe deeply, focusing on releasing tension.',
      ],
      videoUrl: 'https://youtu.be/CI_JxcErfO0',
    ),
    YogaPose(
      poseName: 'Standing Forward Bend',
      poseImage:
          'https://media.istockphoto.com/id/1407965503/vector/woman-doing-childs-pose-stretch-exercise-flat-vector-illustration-isolated-on-white.jpg?s=612x612&w=0&k=20&c=xaOBczbmG_zzKVJt2i_BNiOthFjvDD1OJnQ6-uxakWo=',
      description:
          'Uttanasana is a standing forward fold that stretches the entire back of the body, including the hamstrings and spine. It can help release tension and promote relaxation.',
      steps: [
        'Stand tall with your feet hip-width apart and your arms at your sides.',
        'Exhale and bend forward from your hips, keeping your knees slightly bent.',
        'Place your hands on the floor or grasp the back of your ankles.',
        'Relax your head, neck, and shoulders, and let gravity pull you deeper into the stretch.',
      ],
      videoUrl: 'https://youtu.be/CI_JxcErfO0',
    ),
    YogaPose(
      poseName: 'Tree Pose',
      poseImage:
          'https://media.istockphoto.com/id/1407965503/vector/woman-doing-childs-pose-stretch-exercise-flat-vector-illustration-isolated-on-white.jpg?s=612x612&w=0&k=20&c=xaOBczbmG_zzKVJt2i_BNiOthFjvDD1OJnQ6-uxakWo=',
      description:
          'Vrikshasana is a balancing pose that strengthens the legs and improves focus and concentration. It can help create a sense of stability and groundedness.',
      steps: [
        'Stand tall with your feet together and arms at your sides.',
        'Shift your weight onto your left foot and lift your right foot off the ground.',
        'Place the sole of your right foot against your left inner thigh or calf, avoiding the knee.',
        'Bring your hands together in front of your chest in a prayer position.',
        'Balance and breathe deeply, finding a steady focal point.',
      ],
      videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID',
    ),
    YogaPose(
      poseName: 'Corpse Pose',
      poseImage:
          'https://media.istockphoto.com/id/1407965503/vector/woman-doing-childs-pose-stretch-exercise-flat-vector-illustration-isolated-on-white.jpg?s=612x612&w=0&k=20&c=xaOBczbmG_zzKVJt2i_BNiOthFjvDD1OJnQ6-uxakWo=',
      description:
          'Savasana is a relaxation pose that promotes deep rest and rejuvenation. It allows the body and mind to fully relax and release tension.',
      steps: [
        'Lie flat on your back with your legs extended and arms at your sides.',
        'Close your eyes and relax your entire body, releasing any tension.',
        'Breathe deeply and let go of any thoughts or distractions.',
        'Stay in this pose for several minutes, enjoying the state of deep relaxation.',
      ],
      videoUrl: 'https://youtu.be/CI_JxcErfO0',
    ),
  ].obs;
}
