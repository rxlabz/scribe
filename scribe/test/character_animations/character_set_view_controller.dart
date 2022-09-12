import 'package:flutter_test/flutter_test.dart';
import 'package:scribe/data/latin_sets.dart';
import 'package:scribe/screens/character_animation/character_animation_screen.dart';

void main() {
  test('should open the first char. and jump to the next', () {
    final controller = CharacterSelectionController(latinSet.variants.first);

    expect(controller.value.symbol, 'A');
    controller.nextCharacter();
    expect(controller.value.symbol, 'B');
  });

  test('should select the last char. and not jump to the next', () {
    final controller = CharacterSelectionController(latinSet.variants.first);

    controller.select(latinSet.variants.first.characters.last);
    expect(controller.value.symbol, 'Z');
    controller.nextCharacter();
    expect(controller.value.symbol, 'Z');
  });
}
