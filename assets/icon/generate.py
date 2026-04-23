"""Generate Crest launcher icons from scratch using Pillow.

Produces:
  - icon.png            : 1024x1024 full icon (rounded square background + curve)
  - icon_foreground.png : 1024x1024 foreground only (transparent bg, curve only)
                          Sized for Android adaptive-icon safe zone.

Run: python assets/icon/generate.py
"""

from PIL import Image, ImageDraw
import math
import os

# ---- Forest palette --------------------------------------------------------
BG_COLOR = (243, 236, 224, 255)    # #F3ECE0 cream
FG_COLOR = (43, 74, 62, 255)       # #2B4A3E forest green
COVERLINE_ALPHA = 97               # ~0.38 opacity

SIZE = 1024
OUT_DIR = os.path.dirname(os.path.abspath(__file__))


def cubic_bezier(p0, p1, p2, p3, steps=400):
    """Return [(x, y), ...] points along a cubic Bezier."""
    pts = []
    for i in range(steps + 1):
        t = i / steps
        u = 1 - t
        x = u**3 * p0[0] + 3*u*u*t * p1[0] + 3*u*t*t * p2[0] + t**3 * p3[0]
        y = u**3 * p0[1] + 3*u*u*t * p1[1] + 3*u*t*t * p2[1] + t**3 * p3[1]
        pts.append((x, y))
    return pts


def draw_thick_line(draw, points, width, color):
    """Draw a thick line by stamping filled circles along the path.
    This gives clean rounded caps and smooth curves at any width."""
    radius = width / 2
    # stamp circles at each point — sample density is high enough
    for x, y in points:
        draw.ellipse(
            (x - radius, y - radius, x + radius, y + radius),
            fill=color,
        )
    # also draw line segments between consecutive points to fill gaps
    for (x0, y0), (x1, y1) in zip(points, points[1:]):
        draw.line([(x0, y0), (x1, y1)], fill=color, width=int(width))


def rounded_rect_mask(size, radius):
    """Return an L-mode mask image with a rounded rectangle."""
    mask = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(mask)
    d.rounded_rectangle((0, 0, size - 1, size - 1), radius=radius, fill=255)
    return mask


def draw_curve_and_coverline(img, include_coverline=True):
    """Draw the biphasic curve + optional dashed coverline onto img."""
    draw = ImageDraw.Draw(img, "RGBA")

    # Dashed coverline
    if include_coverline:
        cl_y = 600
        cl_x0, cl_x1 = 200, 824
        dash_len, gap_len = 28, 22
        stroke_w = 10
        radius = stroke_w / 2
        coverline_color = FG_COLOR[:3] + (COVERLINE_ALPHA,)
        x = cl_x0
        while x < cl_x1:
            x_end = min(x + dash_len, cl_x1)
            # draw rounded dash as thick line with circle caps
            draw.ellipse(
                (x - radius, cl_y - radius, x + radius, cl_y + radius),
                fill=coverline_color,
            )
            draw.ellipse(
                (x_end - radius, cl_y - radius, x_end + radius, cl_y + radius),
                fill=coverline_color,
            )
            draw.line(
                [(x, cl_y), (x_end, cl_y)],
                fill=coverline_color,
                width=stroke_w,
            )
            x += dash_len + gap_len

    # Biphasic S-curve
    p0 = (200, 700)
    p1 = (450, 700)
    p2 = (574, 380)
    p3 = (824, 380)
    curve_points = cubic_bezier(p0, p1, p2, p3, steps=600)
    draw_thick_line(draw, curve_points, width=56, color=FG_COLOR)


def make_full_icon():
    """Full icon with background — for legacy launcher + web favicon."""
    img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    # Solid background, then mask to rounded square
    bg = Image.new("RGBA", (SIZE, SIZE), BG_COLOR)
    mask = rounded_rect_mask(SIZE, radius=224)
    img.paste(bg, (0, 0), mask)

    draw_curve_and_coverline(img, include_coverline=True)

    out_path = os.path.join(OUT_DIR, "icon.png")
    img.save(out_path, "PNG")
    print(f"wrote {out_path}")


def make_foreground_icon():
    """Adaptive-icon foreground: transparent bg, curve only, fits safe zone."""
    # Android adaptive icon safe zone ≈ central 66% of canvas.
    # Our curve already fits within that — draw on transparent canvas.
    img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    draw_curve_and_coverline(img, include_coverline=True)
    out_path = os.path.join(OUT_DIR, "icon_foreground.png")
    img.save(out_path, "PNG")
    print(f"wrote {out_path}")


if __name__ == "__main__":
    make_full_icon()
    make_foreground_icon()
