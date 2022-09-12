// ignore_for_file: constant_identifier_names

import 'package:scribe_lib/scribe_lib.dart';
import 'package:tuple/tuple.dart';

final latinSet = CharacterSetGroup(
  /* TODO(rxlabz) i18n*/
  name: 'Latin',
  variants: [
    CharacterSet(
      /* TODO(rxlabz) i18n*/
      name: 'Uppercase',
      characters: [
        char_A,
        char_B,
        char_C,
        char_D,
        char_E,
        char_F,
        char_G,
        char_H,
        char_I,
        char_J,
        char_K,
        char_L,
        char_M,
        char_N,
        char_O,
        char_P,
        char_Q,
        char_R,
        char_S,
        char_T,
        char_U,
        char_V,
        char_W,
        char_X,
        char_Y,
        char_Z,
      ],
    ),
    CharacterSet(
      name: 'Lowercase',
      characters: [
        char_a,
        char_b,
        char_c,
        char_d,
        char_e,
        char_f,
        char_g,
        char_h,
        char_i,
        char_j,
        char_k,
        char_l,
        char_m,
        char_n,
        char_o,
        char_p,
        char_q,
        char_r,
        char_s,
        char_t,
        char_u,
        char_v,
        char_w,
        char_x,
        char_y,
        char_z,
      ],
    ),
  ],
);

const char_a = Character(
  'a',
  duration: 2,
  segments: [
    Segment(
      path: 'M 359 204 L 359 439',
      interval: Tuple2(0, .39),
    ),
    Segment(
      path:
          'M 359 293 C 359 233 300 196 251 195 C 202 194 144 236 145 323 C 146 409 211 441 252 441 C 294 441 355 402 358 357',
      interval: Tuple2(0.4, 1),
    ),
  ],
);

const char_b = Character(
  'b',
  duration: 2,
  segments: [
    Segment(
      path: 'M 160 79 L 160 443',
      interval: Tuple2(0, .59),
    ),
    Segment(
      path:
          'M 159 284 C 160 230 215 192 274 193 C 317 194 380 228 378 315 C 377 402 318 441 277 443 C 212 444 165 410 162 365',
      interval: Tuple2(.6, 1),
    ),
  ],
);

const char_c = Character(
  'c',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 358 218 C 345 201 304 195 277 196 C 245 195 166 235 167 314 C 168 394 217 441 276 441 C 336 440 364 409 364 409',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_d = Character(
  'd',
  duration: 2,
  segments: [
    Segment(
      path: 'M 358 81 L 359 440',
      interval: Tuple2(0, .54),
    ),
    Segment(
      path:
          'M 358 314 C 358 253 325 193 252 194 C 179 195 144 261 144 316 C 144 372 181 443 249 441 C 317 438 358 391 359 315',
      interval: Tuple2(0.55, 1),
    ),
  ],
);

const char_e = Character(
  'e',
  duration: 2,
  segments: [
    Segment(
      path: 'M 153 303 L 364 304',
      interval: Tuple2(0, .34),
    ),
    Segment(
      path:
          'M 363 303 C 362 237 324 196 265 196 C 207 196 153 238 153 305 C 152 375 190 444 269 444 C 320 448 354 404 354 404',
      interval: Tuple2(.35, 1),
    ),
  ],
);

const char_f = Character(
  'f',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 335 92 C 314 80 285 80 271 92 C 257 104 248 114 249 158 C 249 202 247 371 248 372',
      interval: Tuple2(0, .79),
    ),
    Segment(
      path: 'M 191 207 L 325 208',
      interval: Tuple2(0.8, 1),
    ),
  ],
);

const char_g = Character(
  'g',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 362 278 C 350 226 298 194 245 194 C 192 195 140 245 139 319 C 138 394 195 444 246 443 C 298 442 363 409 364 339',
      interval: Tuple2(0, .49),
    ),
    Segment(
      path:
          'M 364 202 C 364 202 364 439 364 439 C 364 439 362 512 306 528 C 252 553 194 536 170 518',
      interval: Tuple2(.5, 1),
    ),
  ],
);

const char_h = Character(
  'h',
  duration: 2,
  segments: [
    Segment(
      path: 'M 170 82 L 169 439',
      interval: Tuple2(0, .59),
    ),
    Segment(
      path:
          'M 170 270 C 199 226 226 197 268 198 C 310 198 350 225 350 268 C 350 310 349 442 349 442',
      interval: Tuple2(0.6, 1),
    ),
  ],
);

const char_i = Character(
  'i',
  duration: 2,
  segments: [
    Segment(
      path: 'M 261 195 L 260 440',
      interval: Tuple2(0, .89),
    ),
    Segment(
      path: 'M 261 127 L 260 123',
      interval: Tuple2(0.9, 1),
    ),
  ],
);

const char_j = Character(
  'j',
  duration: 2,
  segments: [
    Segment(
      path: 'M 252 205 C 252 205 253 426 252 471 C 251 515 220 537 192 536',
      interval: Tuple2(0, .89),
    ),
    Segment(
      path: 'M 251 130 L 251 124',
      interval: Tuple2(0.9, 1),
    ),
  ],
);

const char_k = Character(
  'k',
  duration: 2,
  segments: [
    Segment(
      path: 'M 181 83 L 181 441',
      interval: Tuple2(0, .44),
    ),
    Segment(
      path: 'M 357 200 L 181 350',
      interval: Tuple2(.45, .73),
    ),
    Segment(
      path: 'M 237 302 L 365 439',
      interval: Tuple2(.74, 1),
    ),
  ],
);

const char_l = Character(
  'l',
  duration: 2,
  segments: [
    Segment(
      path: 'M 259 80 L 259 443',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_m = Character(
  'm',
  duration: 2,
  segments: [
    Segment(
      path: 'M 80 199 L 81 446',
      interval: Tuple2(0, .29),
    ),
    Segment(
      path:
          'M 81 268 C 81 237 131 198 179 199 C 228 200 255 227 255 259 C 256 290 254 439 255 439',
      interval: Tuple2(0.3, .69),
    ),
    Segment(
      path:
          'M 256 273 C 256 273 263 197 348 197 C 420 196 435 243 435 264 C 435 285 435 440 435 440',
      interval: Tuple2(.7, 1),
    ),
  ],
);

const char_n = Character(
  'n',
  duration: 2,
  segments: [
    Segment(
      path: 'M 167 199 L 166 445',
      interval: Tuple2(0, .40),
    ),
    Segment(
      path:
          'M 167 272 C 167 232 230 189 273 189 C 317 190 351 216 351 267 C 351 319 349 444 349 444',
      interval: Tuple2(0.41, 1),
    ),
  ],
);

const char_o = Character(
  'o',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 261 195 C 183 195 144 260 145 319 C 145 383 187 442 254 443 C 319 443 375 401 374 318 C 372 236 315 196 263 195',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_p = Character(
  'p',
  duration: 2,
  segments: [
    Segment(
      path: 'M 158 198 L 157 545',
      interval: Tuple2(0, .59),
    ),
    Segment(
      path:
          'M 158 274 C 158 239 220 195 268 198 C 316 202 381 231 380 316 C 378 400 325 441 272 440 C 220 439 159 400 158 364',
      interval: Tuple2(0.6, 1),
    ),
  ],
);

const char_q = Character(
  'q',
  duration: 2,
  segments: [
    Segment(
      path: 'M 359 202 L 359 546',
      interval: Tuple2(0, .59),
    ),
    Segment(
      path:
          'M 360 265 C 360 265 343 196 254 195 C 169 197 139 266 142 326 C 145 386 190 442 248 441 C 306 440 359 399 360 353',
      interval: Tuple2(0.6, 1),
    ),
  ],
);

const char_r = Character(
  'r',
  duration: 2,
  segments: [
    Segment(
      path: 'M 214 200 L 213 444',
      interval: Tuple2(0, .59),
    ),
    Segment(
      path: 'M 214 271 C 214 271 224 193 298 195 C 337 193 356 223 356 223',
      interval: Tuple2(0.6, 1),
    ),
  ],
);

const char_s = Character(
  's',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 335 231 C 335 212 301 192 257 193 C 238 193 190 207 190 252 C 190 297 234 308 277 322 C 329 337 343 355 343 380 C 343 405 322 447 267 443 C 211 440 179 410 171 395',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_t = Character(
  't',
  duration: 2,
  segments: [
    Segment(
      path: 'M 248 125 C 248 125 247 397 247 398 C 247 399 247 449 303 433',
      interval: Tuple2(0, .8),
    ),
    Segment(
      path: 'M 190 204 L 323 204',
      interval: Tuple2(0.81, 1),
    ),
  ],
);

const char_u = Character(
  'u',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 169 200 C 169 200 169 360 169 360 C 169 360 172 439 255 439 C 339 439 351 381 350 357 C 350 333 352 200 352 200',
      interval: Tuple2(0, .6),
    ),
    Segment(
      path: 'M 350 200 L 352 440',
      interval: Tuple2(0.61, 1),
    ),
  ],
);

const char_v = Character(
  'v',
  duration: 2,
  segments: [
    Segment(
      path: 'M 155 194 L 258 434',
      interval: Tuple2(0, .49),
    ),
    Segment(
      path: 'M 258 433 L 366 190',
      interval: Tuple2(0.5, 1),
    ),
  ],
);

const char_w = Character(
  'w',
  duration: 2,
  segments: [
    Segment(
      path: 'M 99 193 L 182 436',
      interval: Tuple2(0, .24),
    ),
    Segment(
      path: 'M 181 435 L 257 247',
      interval: Tuple2(0.25, .49),
    ),
    Segment(
      path: 'M 256 247 L 336 433',
      interval: Tuple2(0.5, .74),
    ),
    Segment(
      path: 'M 336 431 L 419 191',
      interval: Tuple2(0.74, 1),
    ),
  ],
);

const char_x = Character(
  'x',
  duration: 2,
  segments: [
    Segment(
      path: 'M 165 198 L 355 442',
      interval: Tuple2(0, .49),
    ),
    Segment(
      path: 'M 355 193 L 165 444',
      interval: Tuple2(0.5, 1),
    ),
  ],
);

const char_y = Character(
  'y',
  duration: 2,
  segments: [
    Segment(
      path:
          'M 170 155 C 170 155 168 322 168 322 C 168 322 171 401 251 401 C 331 402 350 342 350 322 C 350 302 350 154 350 154',
      interval: Tuple2(0, .5),
    ),
    Segment(
      path:
          'M 348 157 C 348 157 351 401 351 401 C 351 401 350 459 296 486 C 242 513 196 494 172 479',
      interval: Tuple2(0.51, 1),
    ),
  ],
);

const char_z = Character(
  'z',
  duration: 2,
  segments: [
    Segment(
      path: 'M 181 199 L 350 199',
      interval: Tuple2(0, .3),
    ),
    Segment(
      path: 'M 347 196 L 170 437',
      interval: Tuple2(0.31, .7),
    ),
    Segment(
      path: 'M 170 436 L 345 436',
      interval: Tuple2(0.71, 1),
    ),
  ],
);

/*const char_a = Character(
  'a',
  duration: 3,
  segments: [
    Segment(
      path:
          'M 360 296 C 360 296 338 265 298 266 C 218 260 163 438 294 436 C 383 439 364 307 364 307',
      interval: Tuple2(0, .6),
    ),
    Segment(
      path: 'M 388 284 C 387 283 368 391 373 411 C 377 451 416 403 416 403',
      interval: Tuple2(0.61, 1),
    ),
  ],
);*/

const char_A = Character(
  'A',
  duration: 3,
  segments: [
    Segment(
      path: 'M 320 140 L 160 480',
      interval: Tuple2(0, 0.4),
    ),
    Segment(
      path: 'M 320 140 L 480 480',
      interval: Tuple2(0.41, .8),
    ),
    Segment(
      path: 'M 220 360 L 420 360',
      interval: Tuple2(0.81, 1),
    ),
  ],
);

const char_B = Character(
  'B',
  duration: 4,
  segments: [
    Segment(
      path: 'M 220 169 C 220 169 218 495 218 495',
      interval: Tuple2(0, .3),
    ),
    Segment(
      path:
          'M 219 170 C 219 170 244 167 344 169 C 453 168 462 320 342 322 C 223 323 219 323 219 323',
      interval: Tuple2(0.31, .65),
    ),
    Segment(
      path:
          'M 218 327 C 218 327 236 325 340 327 C 482 321 493 498 341 499 C 206 498 220 496 220 496',
      interval: Tuple2(0.66, 1),
    ),
  ],
);

const char_C = Character(
  'C',
  duration: 4,
  segments: [
    Segment(
      path:
          'M 457 194 C 457 194 417 165 356 164 C 166 148 115 496 355 502 C 418 505 464 465 464 465',
      /*'M 448 255 C 447 254 439 162 322 162 C 159 162 140 500 324 500 C 433 499 451 415 451 415 ',*/

      interval: Tuple2(0, 1),
    ),
  ],
);

const char_D = Character(
  'D',
  segments: [
    Segment(
      path: 'M 201 171 C 201 171 200 496 200 496',
      interval: Tuple2(0, 0.5),
    ),
    Segment(
      path:
          'M 200 168 C 199 168 219 167 336 167 C 515 167 502 505 331 498 C 218 497 200 497 200 497',
      interval: Tuple2(0.51, 1),
    ),
  ],
);
const char_E = Character(
  'E',
  segments: [
    Segment(
      path: 'M 240 169 L 239 494',
      interval: Tuple2(0, .4),
    ),
    Segment(
      path: 'M 241 169 L 424 169',
      interval: Tuple2(0.41, 0.6),
    ),
    Segment(
      path: 'M 239 327 L 405 326',
      interval: Tuple2(0.61, 0.8),
    ),
    Segment(
      path: 'M 241 496 L 429 496',
      interval: Tuple2(0.81, 1),
    ),
  ],
);

const char_F = Character(
  'F',
  segments: [
    Segment(
      path: 'M 240 169 L 239 494',
      interval: Tuple2(0, .5),
    ),
    Segment(
      path: 'M 241 169 L 424 169',
      interval: Tuple2(0.51, 0.75),
    ),
    Segment(
      path: 'M 239 327 L 405 326',
      interval: Tuple2(0.76, 1),
    ),
  ],
);

const char_G = Character(
  'G',
  segments: [
    Segment(
      path:
          'M 443 186 C 443 186 399 163 353 162 C 144 163 106 482 348 501 C 429 498 449 470 449 470',
      interval: Tuple2(0, 0.6),
    ),
    Segment(
      path: 'M 355 345 L 450 344 L 450 470',
      interval: Tuple2(0.61, 1),
    ),
  ],
);

const char_H = Character(
  'H',
  segments: [
    Segment(
      path: 'M 200 165 L 199 500',
      interval: Tuple2(0, .4),
    ),
    Segment(
      path: 'M 440 165 L 439 500',
      interval: Tuple2(0.41, .8),
    ),
    Segment(
      path: 'M 199 328 L 437 328',
      interval: Tuple2(0.81, 1),
    ),
  ],
);

const char_I = Character(
  'I',
  segments: [
    Segment(
      path: 'M 321 165 L 322 497',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_J = Character(
  'J',
  segments: [
    Segment(
      path: 'M 403 167 C 403 167 404 324 403 416 C 403 507 267 540 219 439',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_K = Character(
  'K',
  segments: [
    Segment(
      path: 'M 213 166 L 214 501',
      interval: Tuple2(0, .4),
    ),
    Segment(
      path: 'M 446 167 L 215 381',
      interval: Tuple2(0.41, .76),
    ),
    Segment(
      path: 'M 297 308 L 453 501',
      interval: Tuple2(0.77, 1),
    ),
  ],
);

const char_L = Character(
  'L',
  segments: [
    Segment(
      path: 'M 249 165 L 247 493',
      interval: Tuple2(0, 0.6),
    ),
    Segment(
      path: 'M 248 493 L 431 493',
      interval: Tuple2(0.61, 1),
    ),
  ],
);

const char_M = Character(
  'M',
  segments: [
    Segment(
      path: 'M 172 171 L 171 497',
      interval: Tuple2(0, .4),
    ),
    Segment(
      path: 'M 171 167 L 319 383 L 467 167',
      interval: Tuple2(0.41, 0.7),
    ),
    Segment(
      path: 'M 468 166 L 469 497',
      interval: Tuple2(0.71, 1),
    ),
  ],
);

const char_N = Character(
  'N',
  segments: [
    Segment(
      path: 'M 195 168 L 195 499',
      interval: Tuple2(0, .3),
    ),
    Segment(
      path: 'M 198 171 L 441 493',
      interval: Tuple2(0.31, .7),
    ),
    Segment(
      path: 'M 445 166 L 445 500',
      interval: Tuple2(0.71, 1),
    ),
  ],
);

const char_O = Character(
  'O',
  segments: [
    Segment(
      path: 'M 322 161 C 115 159 106 502 321 502 C 536 501 520 164 322 161',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_P = Character(
  'P',
  segments: [
    Segment(
      path: 'M 232 168 L 231 497',
      interval: Tuple2(0, .6),
    ),
    Segment(
      path:
          'M 233 167 C 232 167 251 166 352 166 C 454 166 467 345 358 345 C 250 345 234 344 234 344',
      interval: Tuple2(0.61, 1),
    ),
  ],
);

const char_Q = Character(
  'Q',
  segments: [
    Segment(
      path: 'M 322 161 C 115 159 106 502 321 502 C 536 501 520 164 322 161',
      interval: Tuple2(0, 0.7),
    ),
    Segment(
      path: 'M 386 435 L 452 503',
      interval: Tuple2(0.71, 1),
    ),
  ],
);

const char_R = Character(
  'R',
  segments: [
    Segment(
      path: 'M 232 168 L 231 497',
      interval: Tuple2(0, .5),
    ),
    Segment(
      path:
          'M 233 167 C 233 167 251 166 352 166 C 454 166 467 345 358 345 C 250 345 234 344 234 344',
      interval: Tuple2(0.51, .8),
    ),
    Segment(
      path: 'M 362 348 L 452 503',
      interval: Tuple2(0.81, 1),
    ),
  ],
);

const char_S = Character(
  'S',
  segments: [
    Segment(
      path:
          'M 425 208 C 425 208 397 167 337 160 C 252 146 135 269 328 328 C 507 396 411 500 332 502 C 251 508 204 447 204 447',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_T = Character(
  'T',
  segments: [
    Segment(
      path: 'M 319 172 L 319 502',
      interval: Tuple2(0, .5),
    ),
    Segment(
      path: 'M 196 169 L 446 170',
      interval: Tuple2(0.51, 1),
    ),
  ],
);

const char_U = Character(
  'U',
  segments: [
    Segment(
      path:
          'M 199 167 C 199 167 200 212 200 385 C 199 543 438 537 437 390 C 439 243 437 165 437 165',
      interval: Tuple2(0, 1),
    ),
  ],
);

const char_V = Character(
  'V',
  segments: [
    Segment(
      path: 'M 181 165 L 320 492',
      interval: Tuple2(0, 0.51),
    ),
    Segment(
      path: 'M 320 492 L 458 165',
      interval: Tuple2(0.51, 1),
    ),
  ],
);

const char_W = Character(
  'W',
  segments: [
    Segment(
      path: 'M 104 166 L 215 486',
      interval: Tuple2(0, .3),
    ),
    Segment(
      path: 'M 218 483 L 319 245',
      interval: Tuple2(0.31, .5),
    ),
    Segment(
      path: 'M 320 243 L 422 485',
      interval: Tuple2(0.51, .7),
    ),
    Segment(
      path: 'M 422 486 L 535 163',
      interval: Tuple2(0.71, 1),
    ),
  ],
);

const char_X = Character(
  'X',
  segments: [
    Segment(
      path: 'M 197 165 L 445 499',
      interval: Tuple2(0, .5),
    ),
    Segment(
      path: 'M 443 162 L 196 498',
      interval: Tuple2(0.51, 1),
    ),
  ],
);

const char_Y = Character(
  'Y',
  segments: [
    Segment(
      path: 'M 202 166 L 320 332 L 439 165',
      interval: Tuple2(0, 0.6),
    ),
    Segment(
      path: 'M 322 326 L 320 496',
      interval: Tuple2(0.61, 1),
    ),
  ],
);

const char_Z = Character(
  'Z',
  segments: [
    Segment(
      path: 'M 209 168 L 443 166',
      interval: Tuple2(0, .3),
    ),
    Segment(
      path: 'M 443 170 L 193 498',
      interval: Tuple2(0.31, .6),
    ),
    Segment(
      path: 'M 192 498 L 446 498',
      interval: Tuple2(0.61, 1),
    ),
  ],
);
