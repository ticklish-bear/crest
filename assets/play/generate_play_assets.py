"""Generate Google Play Store graphics for Crest (Forest palette).

Outputs into assets/play/:
  - play_icon_512.png   : 512x512 hi-res store icon (full square; Play masks it)
  - feature_graphic.png : 1024x500 feature graphic with wordmark + tagline

Run: python assets/play/generate_play_assets.py
"""

import os
from PIL import Image, ImageDraw, ImageFont

BG = (243, 236, 224, 255)   # #F3ECE0 cream
FG = (43, 74, 62, 255)      # #2B4A3E forest green
MUTED = (122, 117, 109, 255)
COVERLINE_ALPHA = 97

OUT = os.path.dirname(os.path.abspath(__file__))


def load_font(size, bold=False):
    candidates = (
        ["C:/Windows/Fonts/segoeuib.ttf", "C:/Windows/Fonts/arialbd.ttf"]
        if bold
        else ["C:/Windows/Fonts/segoeui.ttf", "C:/Windows/Fonts/arial.ttf"]
    )
    for c in candidates:
        if os.path.exists(c):
            return ImageFont.truetype(c, size)
    return ImageFont.load_default()


def cubic(p0, p1, p2, p3, steps=600):
    pts = []
    for i in range(steps + 1):
        t = i / steps
        u = 1 - t
        x = u**3 * p0[0] + 3*u*u*t * p1[0] + 3*u*t*t * p2[0] + t**3 * p3[0]
        y = u**3 * p0[1] + 3*u*u*t * p1[1] + 3*u*t*t * p2[1] + t**3 * p3[1]
        pts.append((x, y))
    return pts


def thick_curve(draw, pts, width, color):
    r = width / 2
    for x, y in pts:
        draw.ellipse((x - r, y - r, x + r, y + r), fill=color)
    for (x0, y0), (x1, y1) in zip(pts, pts[1:]):
        draw.line([(x0, y0), (x1, y1)], fill=color, width=int(width))


def dashed_line(draw, x0, x1, y, width, color, dash=28, gap=22):
    r = width / 2
    x = x0
    while x < x1:
        xe = min(x + dash, x1)
        draw.ellipse((x - r, y - r, x + r, y + r), fill=color)
        draw.ellipse((xe - r, y - r, xe + r, y + r), fill=color)
        draw.line([(x, y), (xe, y)], fill=color, width=width)
        x += dash + gap


def make_icon_512():
    size = 512
    img = Image.new("RGBA", (size, size), BG)
    draw = ImageDraw.Draw(img, "RGBA")
    # scale of the 1024 reference design by 0.5
    dashed_line(draw, 100, 412, 300, 5, FG[:3] + (COVERLINE_ALPHA,),
                dash=14, gap=11)
    pts = cubic((100, 350), (225, 350), (287, 190), (412, 190))
    thick_curve(draw, pts, 28, FG)
    img.save(os.path.join(OUT, "play_icon_512.png"), "PNG")
    print("wrote play_icon_512.png")


def make_feature_graphic():
    w, h = 1024, 500
    img = Image.new("RGBA", (w, h), BG)
    draw = ImageDraw.Draw(img, "RGBA")

    # Curve motif on the right
    dashed_line(draw, 600, 950, 300, 7, FG[:3] + (COVERLINE_ALPHA,))
    pts = cubic((600, 360), (740, 360), (810, 170), (950, 170))
    thick_curve(draw, pts, 30, FG)

    # Wordmark + tagline on the left
    title_font = load_font(96, bold=True)
    tag_font = load_font(34, bold=False)
    draw.text((80, 175), "Crest", font=title_font, fill=FG)
    draw.text((84, 285), "Symptothermal method charting",
              font=tag_font, fill=MUTED)
    draw.text((84, 330), "Free · offline · private",
              font=tag_font, fill=MUTED)

    img.convert("RGB").save(os.path.join(OUT, "feature_graphic.png"), "PNG")
    print("wrote feature_graphic.png")


if __name__ == "__main__":
    make_icon_512()
    make_feature_graphic()
