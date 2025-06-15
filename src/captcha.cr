require "stumpy_png"
require "stumpy_core"

class SimpleFont
  def initialize
  end

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
    StumpyCore::RGBA::WHITESMOKE,
    StumpyCore::RGBA::LIGHTCYAN,
    StumpyCore::RGBA::ALICEBLUE,
    StumpyCore::RGBA::AZURE,
    StumpyCore::RGBA::POWDERBLUE,
    StumpyCore::RGBA::LIGHTBLUE,
    StumpyCore::RGBA::MISTYROSE,
    StumpyCore::RGBA::PINK,
    StumpyCore::RGBA::LIGHTPINK,
    StumpyCore::RGBA::LAVENDERBLUSH,
    StumpyCore::RGBA::LAVENDER,
    StumpyCore::RGBA::THISTLE,
    StumpyCore::RGBA::PLUM,
    StumpyCore::RGBA::HONEYDEW,
    StumpyCore::RGBA::PALEGREEN,
    StumpyCore::RGBA::MINTCREAM,
    StumpyCore::RGBA::AQUAMARINE,
    StumpyCore::RGBA::LIGHTYELLOW,
    StumpyCore::RGBA::LEMONCHIFFON,
    StumpyCore::RGBA::BEIGE,
    StumpyCore::RGBA::CORNSILK,
    StumpyCore::RGBA::OLDLACE,
    StumpyCore::RGBA::FLORALWHITE,
    StumpyCore::RGBA::IVORY,
    StumpyCore::RGBA::SEASHELL,
    StumpyCore::RGBA::ANTIQUEWHITE,
    StumpyCore::RGBA::BLANCHEDALMOND,
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

class CaptchaGenerator
  getter code : String
  @io : IO::Memory

  def initialize(code : String? = nil, length : Int32 = 4)
    code = (0...length).map { Random.rand(10).to_s }.join if code.nil?
    @code = code

    @width = 200
    @height = 80
    @font = SimpleFont.new
    @format = "png"

    canvas = StumpyPNG::Canvas.new(@width, @height)

    # 设置背景色为白色
    (0...@width).each do |x|
      (0...@height).each do |y|
        canvas[x, y] = StumpyCore::RGBA.new(UInt16::MAX, UInt16::MAX, UInt16::MAX, UInt16::MAX)
      end
    end

    # 添加噪点
    add_noise(canvas)

    # 绘制验证码数字
    digit_width = 40
    start_x = (@width - code.size * digit_width) // 2

    code.each_char_with_index do |digit, index|
      x = start_x + index * digit_width
      y = (@height - 56) // 2 # 字符高度约为56像素 (7*8)

      # 添加随机偏移
      offset_x = Random.rand(-5..5)
      offset_y = Random.rand(-8..8)

      @font.draw_digit(canvas, digit, x + offset_x, y + offset_y)
    end

    # 添加干扰线
    add_interference_lines(canvas)

    # canvas
    @io = IO::Memory.new
    StumpyPNG.write(canvas, @io)
    @io.rewind
  end

  def base64
    @base64 ||= Base64.encode(@io.gets_to_end)
  end

  def img_tag(width : String? = nil, height : String? = nil) : String
    String.build do |io|
      io << <<-HEREDOC
<img src="data:image/#{@format};base64,#{base64}"
HEREDOC

      if width && height
        io << " style=\"width: #{width}; height: #{height};\""
      elsif width
        io << " style=\"width: #{width};\""
      elsif height
        io << " style=\"height: #{height};\""
      end

      io << " />"
    end
  end

  def write_html_file(name) : Nil
    html = <<-HEREDOC
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Base64 Image Demo</title>
  </head>

  <body>
    <h1>Show captcha image</h1>
    #{img_tag}
  </body>
</html>
HEREDOC

    File.write(name, html)
  end

  private def add_noise(canvas)
    noise_count = (@width * @height) // 20
    noise_count.times do
      x = Random.rand(@width)
      y = Random.rand(@height)
      # 随机灰色噪点
      gray = Random.rand(128..255).to_u16 * 257
      canvas[x, y] = StumpyCore::RGBA.new(gray, gray, gray, UInt16::MAX)
    end
  end

  private def add_interference_lines(canvas)
    3.times do
      x1 = Random.rand(@width)
      y1 = Random.rand(@height)
      x2 = Random.rand(@width)
      y2 = Random.rand(@height)

      draw_line(canvas, x1, y1, x2, y2)
    end
  end

  private def draw_line(canvas, x1, y1, x2, y2)
    dx = (x2 - x1).abs
    dy = (y2 - y1).abs
    steps = [dx, dy].max

    return if steps == 0

    x_increment = (x2 - x1).to_f / steps
    y_increment = (y2 - y1).to_f / steps

    x = x1.to_f
    y = y1.to_f

    (steps + 1).times do
      if x.to_i >= 0 && x.to_i < @width && y.to_i >= 0 && y.to_i < @height
        # 灰色干扰线
        canvas[x.to_i, y.to_i] = StumpyCore::RGBA.new(32768_u16, 32768_u16, 32768_u16, UInt16::MAX)
      end
      x += x_increment
      y += y_increment
    end
  end
end
