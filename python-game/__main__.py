{{py_copyright}}
from __future__ import print_function
import argparse
import os
import pygame
import sys
import time

from {{module_name}} import __description__, __project_name__, __version__
from {{module_name}}.config import Config

_IMAGES_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "images"))

def _run_game(config, args):
    pygame.init()

    size = width, height = 320, 240
    speed = [2, 2]
    black = 0, 0, 0

    pygame.display.set_caption("Welcome to {{project_name}}!")
    screen = pygame.display.set_mode(size)

    intro_ball_path = os.path.join(_IMAGES_DIR, "intro-ball.gif")
    ball = pygame.image.load(intro_ball_path)
    ballrect = ball.get_rect()

    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT: sys.exit()

        ballrect = ballrect.move(speed)
        if ballrect.left < 0 or ballrect.right > width:
            speed[0] = -speed[0]
        if ballrect.top < 0 or ballrect.bottom > height:
            speed[1] = -speed[1]

        screen.fill(black)
        screen.blit(ball, ballrect)
        pygame.display.flip()
        time.sleep(0.01)

def _main(argv=None):
    if argv is None:
        argv = sys.argv[1:]

    config_dir = os.path.abspath(os.path.expanduser(os.environ.get("{{ project_name | underscore | upper }}_DIR", "~/.{{project_name}}")))
    config = Config(config_dir)

    parser = argparse.ArgumentParser(prog=__project_name__, description=__description__)
    parser.add_argument("--version", action="version", version="{} version {}".format(__project_name__, __version__))

    args = parser.parse_args(argv)
    _run_game(config, args)

if __name__ == "__main__":
    _main()
