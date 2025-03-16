


import '../heroes/prop/prop.dart';

List<String> get extraImages {
  List<String> result = [
    'images/Btn_V13.png',
    'images/Btn_V14.png',
    'images/Btn_V03.png',
    'images/Btn_V04.png',
    'images/Btn_V17.png',
    'images/Btn_V18.png',
    'images/Btn_V15.png',
    'images/Btn_V16.png',
    'images/Btn_V11.png',
    'images/Btn02.png',
    'images/Btn01.png',
    'images/BtnExitOpacity.png',
    'images/BtnExitNoOpacity.png',
    'images/blue_boxCheckmark.png',
    'images/grey_box.png',
    'images/red_cross.png',
    'images/buttonLong_beige.png',
    'images/buttonLong_beige_pressed.png',
    'images/shadedDark33.png',
    'images/shadedDark31.png',
    'images/shadedDark24.png',
    'images/texture_metal1.png',
    'images/texture_gem3.png',
    'images/texture_fabric1.png',
    'images/texture_ice1.png',
    'images/tile_0046.png',
    'images/tile_0044.png',
    'images/flatDark15.png',
    'images/flatDark13.png',
    'images/buttonLong_brown.png',
    'images/buttonLong_brown_pressed.png',
    'images/buttonLong_blue.png',
    'images/buttonLong_blue_pressed.png',
    'images/buttonLong_blue_pressed.png',
    'images/panel.png',
    'images/Window04.png',
    'images/level.png',
    'images/package.png',
    'images/Btn_V01.png',
    'images/Btn_V05.png',
    'images/prop_show_5s.png',
    'images/Cell01.png',
    'images/prop_random.png',
    'images/coin.png',
    'images/package_panel.png',
    'images/package_cell.png',
    'images/package_tab.png',
    'images/loading.png',
    'images/bg_gallery.png',
  ];

  for(int i=1;i<=14;i++){
    result.add('images/boom/TCSY_000${i.toString().padLeft(2,'0')}.png');
  }

  for(int i=1;i<=4;i++){
    result.add('images/bottom/lightning${i.toString().padLeft(2,'0')}.png');
  }

  for(int i=1;i<=12;i++){
    result.add('images/died/died_${i.toString().padLeft(4,'0')}.png');
  }

  result.addAll(Prop.values.map((e) => 'images/${e.src}'));
  return result;
}