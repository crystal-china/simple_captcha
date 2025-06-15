class SimpleFont
  # 简化的数字位图，每个数字用7x5的点阵表示
  DIGIT_PATTERNS = {
    '0' => [
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
    ],
    '1' => [
      [0, 0, 1, 0, 0],
      [0, 1, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 1, 1, 1, 0],
    ],
    '2' => [
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 1, 1, 1, 1],
    ],
    '3' => [
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
    ],
    '4' => [
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
    ],
    '5' => [
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
    ],
    '6' => [
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0],
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
    ],
    '7' => [
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 1, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
      [0, 0, 1, 0, 0],
    ],
    '8' => [
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
    ],
    '9' => [
      [1, 1, 1, 1, 1],
      [1, 0, 0, 0, 1],
      [1, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
      [0, 0, 0, 0, 1],
      [0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1],
    ],
  }

  COLORS = [
    StumpyCore::RGBA::GAINSBORO,
    StumpyCore::RGBA::LIGHTGREY,
    StumpyCore::RGBA::SILVER,
    StumpyCore::RGBA::POWDERBLUE,
    StumpyCore::RGBA::LIGHTBLUE,
    StumpyCore::RGBA::MISTYROSE,
    StumpyCore::RGBA::PINK,
    StumpyCore::RGBA::LIGHTPINK,
    StumpyCore::RGBA::LAVENDERBLUSH,
    StumpyCore::RGBA::LAVENDER,
    StumpyCore::RGBA::THISTLE,
    StumpyCore::RGBA::PLUM,
    StumpyCore::RGBA::PALEGREEN,
    StumpyCore::RGBA::AQUAMARINE,
    StumpyCore::RGBA::BEIGE,
    StumpyCore::RGBA::ANTIQUEWHITE,
    StumpyCore::RGBA::BLANCHEDALMOND,
    StumpyCore::RGBA::LIGHTCYAN,
    StumpyCore::RGBA::BISQUE,
    StumpyCore::RGBA::PEACHPUFF,
  ]

  def draw_digit(canvas, digit : Char, x : Int32, y : Int32, scale : Int32 = 8)
    pattern = DIGIT_PATTERNS[digit]

    return unless pattern

    color = COLORS.sample

    pattern.each_with_index do |row, row_idx|
      row.each_with_index do |pixel, col_idx|
        if pixel == 1
          # 绘制像素块
          (0...scale).each do |dy|
            (0...scale).each do |dx|
              px = x + col_idx * scale + dx
              py = y + row_idx * scale + dy
              if px >= 0 && px < canvas.width && py >= 0 && py < canvas.height
                canvas[px, py] = color
              end
            end
          end
        end
      end
    end
  end
end
