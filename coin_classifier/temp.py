from os import listdir, mkdir, path
from PIL import Image

d = listdir('obv_biased_images/')
if '.DS_Store' in d:
    d.remove('.DS_Store')
d.sort()

# mkdir('images_grade/')


def number_to_grade(number):
    if number >= 60:
        return 'MS'
    elif number >= 50:
        return 'AU'
    elif number >= 40:
        return 'XF'
    elif number >= 20:
        return 'VF'
    elif number >= 12:
        return 'F'
    elif number >= 8:
        return 'VG'
    elif number >= 4:
        return 'G'
    elif number == 3:
        return 'AG'
    elif number == 2:
        return 'FR'
    elif number == 1:
        return 'PO'
    return ''


with open('coin_classifier_labels_obv_biased.txt', 'w') as f:
    for coin_type in d:
        f.write('%s\n' % coin_type)

# for coin_type in d:
#     for img_name in listdir('images/%s/' % coin_type):
#         img = Image.open('images/%s/%s' % (coin_type, img_name))
#         grade_text = number_to_grade(int(img_name.split('-')[-1].replace('o',
#                                                                          '').replace('r', '').replace('.jpg', '')))
#         if not path.isdir('images_grade/%s' % grade_text):
#             mkdir('images_grade/%s' % grade_text)
#         img.save('images_grade/%s/%s' % (grade_text, img_name))

# for coin_type in d:
#     for img_name in listdir('images/%s/' % coin_type):
#         img = Image.open('images/%s/%s' % (coin_type, img_name))
#         if img_name.replace('.jpg', '')[-1] == 'o':
#             if not path.isdir('obv_imgs/%s' % coin_type):
#                 mkdir('obv_imgs/%s' % coin_type)
#             img.save('obv_imgs/%s/%s' % (coin_type, img_name))
#         else:
#             if not path.isdir('rev_imgs/%s' % coin_type):
#                 mkdir('rev_imgs/%s' % coin_type)
#             img.save('rev_imgs/%s/%s' % (coin_type, img_name))
