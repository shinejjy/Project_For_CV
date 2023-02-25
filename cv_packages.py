from IPython import display
from matplotlib import pyplot as plt
import cv2
import numpy as np


def use_svg_display():
    # 用矢量图显示
    display.set_matplotlib_formats('svg')


def set_figsize(figsize=(3.5, 2.5)):
    use_svg_display()
    # 设置图的尺寸
    plt.rcParams['figure.figsize'] = figsize


def show_image(image: np.ndarray, name=None, gray=False):
    plt.xticks([]), plt.yticks([])
    b, g, r = cv2.split(image)
    image = cv2.merge([r, g, b])
    if not gray:
        plt.imshow(image)
    else:
        plt.imshow(image, camp='gray')
    if name:
        plt.title(name)
    plt.show()


def show_image_hist(image, title=None):
    if title:
        plt.title(title)
    plt.hist(image.ravel(), 256, [0, 256], color='r')
    plt.show()
