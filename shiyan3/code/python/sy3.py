# -*- coding: utf-8 -*-

import cv2
import numpy as np


def main():

    # 1.创建原图片
    img_src = np.zeros((500, 500), dtype=np.uint8)
    img_src[:, 250:] = 255

    # 2.执行双边滤波与高斯滤波
    img_dst = cv2.bilateralFilter(img_src, 55, 100, 100)
    img_gauss = cv2.GaussianBlur(img_src, (55, 55), 0, 0)

    # 3.显示结果
    cv2.imshow("img_src", img_src)
    cv2.imshow("img_dst", img_dst)
    cv2.imshow("img_gauss", img_gauss)

    cv2.waitKey()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()