enum SoundEffect {
  uiClick('ui/click.mp3'),
  uiOpen('ui/open.mp3'),
  uiClose('ui/close.mp3'),
  uiSelect('ui/select.mp3'),
  ballBrick('break_bricks/tone.mp3'),
  bitWall('break_bricks/hit2.mp3'),
  ;

  final String path;

  const SoundEffect(this.path);
}
