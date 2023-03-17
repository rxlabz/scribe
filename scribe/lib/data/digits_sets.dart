import 'package:scribe_lib/scribe_lib.dart';
import 'package:tuple/tuple.dart';

const digitSet = CharacterSet(name: 'Digits', characters: [
  char_1,
  char_2,
  char_3,
  char_4,
  char_5,
  char_6,
  char_7,
  char_8,
  char_9,
  char_0,
]);

const char_0 = Character(
  '0',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 258 100 C 203 101 152 161 153 276 C 154 390 205 441 257 439 C 310 438 364 400 366 275 C 364 153 318 101 260 100',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_1 = Character(
  '1',
  duration: 3,
  segments: [
    Segment(
      path: 'M 172 167 L 274 82 L 273 435',
      interval: Tuple2(0, 0.7),
    ),
  ],
);

const char_2 = Character(
  '2',
  duration: 3,
  segments: [
    Segment(
      path:
          'M 171 159 C 171 159 193 96 260 97 C 328 98 352 141 353 186 C 354 231 330 257 295 299 C 260 341 179 430 179 430',
      interval: Tuple2(0, 0.6),
    ),
    Segment(
      path: 'M 179 433 L 368 432',
      interval: Tuple2(0.61, 1),
    ),
  ],
);

const char_3 = Character(
  '3',
  duration: 3,
  segments: [
    Segment(
      path:
          'M 155 116 C 155 116 269 45 335 123 C 369 173 329 216 308 227 C 269 255 204 250 204 250',
      interval: Tuple2(0, 0.5),
    ),
    Segment(
      path: 'M 205 251 C 205 251 353 229 350 339 C 348 476 144 412 144 412',
      interval: Tuple2(0.51, 1),
    ),
  ],
);

const char_4 = Character(
  '4',
  duration: 2,
  segments: [
    Segment(
      path: 'M 320 80 L 320 434',
      interval: Tuple2(0, .4),
    ),
    Segment(
      path: 'M 320 79 L 135 336',
      interval: Tuple2(0.41, .7),
    ),
    Segment(
      path: 'M 135 334 L 388 334',
      interval: Tuple2(0.71, 1),
    ),
  ],
);

const char_5 = Character(
  '5',
  duration: 2,
  segments: [
    Segment(
      path: 'M 340 93 L 178 94',
      interval: Tuple2(0, .3),
    ),
    Segment(
      path: 'M 178 95 L 178 244',
      interval: Tuple2(0.31, .51),
    ),
    Segment(
      path: 'M 181 243 C 181 243 269 208 324 254 C 364 291 367 372 316 409 '
          'C 282 444 185 432 174 412',
      interval: Tuple2(0.52, 1),
    ),
  ],
);

const char_6 = Character(
  '6',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 310 86 C 310 86 163 131 162 306 C 162 408 220 439 261 437 C 320 439 366 397 365 347 C 372 285 336 224 262 223 C 188 222 168 278 163 293',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_7 = Character(
  '7',
  duration: 2,
  segments: [
    Segment(
      path: 'M 145 93 L 362 91',
      interval: Tuple2(0, .34),
    ),
    Segment(
      path: 'M 363 91 L 209 434',
      interval: Tuple2(0.35, .8),
    ),
    Segment(
      path: 'M 249 254 L 336 254',
      interval: Tuple2(0.81, 1),
    ),
  ],
);

const char_8 = Character(
  '8',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 259 83 C 259 83 170 79 170 155 C 171 222 222 229 253 246 C 285 263 357 280 364 335 C 366 406 322 433 258 432',
      interval: Tuple2(0, .5),
    ),
    Segment(
      path:
          'M 258 431 C 258 431 160 433 159 353 C 156 244 351 255 351 155 C 354 81 259 82 259 82',
      interval: Tuple2(0.51, 1),
    ),
  ],
);

const char_9 = Character(
  '9',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 360 185 C 360 185 360 85 248 84 C 181 84 149 134 149 193 C 150 252 196 290 247 289 C 301 292 357 261 360 195',
      interval: Tuple2(0, .5),
    ),
    Segment(
      path: 'M 361 182 C 361 182 383 314 322 383 C 249 465 162 419 162 419',
      interval: Tuple2(0.51, 1),
    ),
  ],
);
