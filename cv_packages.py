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


def add_pepper_noisy(image, n):
    result = image.copy()
    w, h = image.shape[:2]
    for i in range(n):
        x = np.random.randint(0, w)
        y = np.random.randint(0, h)
        if np.random.randint(0, 2) == 0:
            # 白噪点
            result[x, y] = 0
        else:
            # 黑噪点
            result[x, y] = 255
    return result


def add_random_noisy(img):
    noise = np.random.randint(low=0, high=255, size=img.shape)
    return np.clip(img + noise, 0, 255).astype(np.uint8)